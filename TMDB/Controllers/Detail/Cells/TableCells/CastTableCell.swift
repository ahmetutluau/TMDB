//
//  CastCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 10.03.2023.
//

import UIKit

protocol CastTableCellProtocol: AnyObject {
    func navigateToCastDetail(id: Int)
}

class CastTableCell: BaseTableViewCell {
    weak var delegate: CastTableCellProtocol?
    var cast = [Cast]()
    
    private lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CGFloat.dWidth * 10/735
        
        let collectionView = BaseCollectionView(layout: layout,
                                                cells: [CastCollectionCell.self,],
                                                showsHorizontalScrollIndicator: false,
                                                backgroundColor: .clear)
                                                        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(collectionView)
        backgroundColor = .clear
    }
    
    override func setupLayout() {
        super.setupLayout()
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 20/735)
        }
    }
    
    func setupCell(cast: [Cast]) {
        self.cast = cast
        self.collectionView.reloadData()
    }
}

extension CastTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionCell.reuseIdentifier, for: indexPath) as! CastCollectionCell
        cell.setCell(model: cast[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = CGFloat.dWidth * (170/735)
        let height = CGFloat.dHeight * (350/1500)
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navigateToCastDetail(id: cast[indexPath.row].id)
    }
}
