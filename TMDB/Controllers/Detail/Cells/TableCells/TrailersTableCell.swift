//
//  TrailersCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 10.03.2023.
//

import UIKit

protocol TrailersTableCellProtocol: AnyObject {
    func pushVC(url: String)
}

class TrailersTableCell: BaseTableViewCell {
    weak var delegate: TrailersTableCellProtocol?
    var trailers = [TrailerModel]()

    private lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CGFloat.dWidth * 10/735

        let collectionView = BaseCollectionView(layout: layout,
                                                cells: [TrailerCollectionCell.self],
                                                showsHorizontalScrollIndicator: false,
                                                backgroundColor: .clear)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()
    
    private lazy var noTrailersView: BaseView = {
        let view = BaseView(backgroundColor: .clear)
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.isHidden = true
        
        return view
    }()
    
    lazy var noTrailersLabel: BaseLabel = {
        let label = BaseLabel(text: .plain("No trailers"),
                              textAlignment: .left,
                              numberOfLines: .zero,
                              textColor: UIColor(white: 1, alpha: 0.9),
                              font: .systemFont(ofSize: 12, weight: .regular),
                              backgroundColor: .clear,
                              adjustsFontSizeToFitWidth: false)
                    
        return label
    }()

    override func setupViews() {
        super.setupViews()
        
        contentView.addSubviews([collectionView,
                               noTrailersView])
        noTrailersView.addSubview(noTrailersLabel)
    }

    override func setupLayout() {
        super.setupLayout()
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 20/735)
        }
        noTrailersView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 20/735)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 20/735)
        }
        noTrailersLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setupCell(trailers: [TrailerModel]) {
        self.trailers = trailers
        self.collectionView.reloadData()
        self.noTrailersView.isHidden = !trailers.isEmpty 
    }
}

extension TrailersTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trailers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerCollectionCell.reuseIdentifier, for: indexPath) as! TrailerCollectionCell
        cell.setCell(trailer: trailers[indexPath.row])
        cell.delegate = self
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = CGFloat.dWidth * (450/735)
        let height = CGFloat.dHeight * (250/1500)
        return .init(width: width, height: height)
    }
}

extension TrailersTableCell: TrailerCollectionCellProtocol {
    func pushVC(url: String) {
        delegate?.pushVC(url: url)
    }
    
}
