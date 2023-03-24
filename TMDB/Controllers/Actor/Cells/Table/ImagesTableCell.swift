//
//  ImagesTableCell.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 15.03.2023.
//

import UIKit

class ImagesTableCell: BaseTableViewCell {
    var images = [Profile]()
    var timer: Timer?
    var currentCellIndex = 0
    
    private lazy var layout: CustomLayout = {
        let layout = CustomLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 50
        layout.itemSize.width = CGFloat.dWidth * 0.4
        
        return layout
    }()
    
    private lazy var collectionView: BaseCollectionView = {
        let collectionView = BaseCollectionView(layout: layout,
                                                cells: [ImagesCollectionCell.self],
                                                showsHorizontalScrollIndicator: false,
                                                backgroundColor: .clear)
                                                        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 50.0, bottom: 0.0, right: 50.0)
        collectionView.decelerationRate = .fast
        
        return collectionView
    }()
    
    override func setupViews() {
        contentView.addSubview(collectionView)
        backgroundColor = .black
    }
    
    override func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setCell(images: [Profile]) {
        self.images = images
        self.collectionView.reloadData()
    }
    
    private func setTimer() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {_ in
            //get cell size
            let cellSize = self.contentView.frame.size

            //get current content Offset of the Collection view
            let contentOffset = self.collectionView.contentOffset

            if self.collectionView.contentSize.width <= self.collectionView.contentOffset.x + cellSize.width
            {
                let r = CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
                self.collectionView.scrollRectToVisible(r, animated: true)

            } else {
                let r = CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
                self.collectionView.scrollRectToVisible(r, animated: true)
            }
        }
    }
}

extension ImagesTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionCell.reuseIdentifier, for: indexPath) as! ImagesCollectionCell
        cell.setCell(model: images[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = CGFloat.dWidth * 0.4
        let height = CGFloat.dWidth * 0.58
        return .init(width: width, height: height)
    }
}

extension ImagesTableCell {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupCell()
        }
    }
        
    private func setupCell() {
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) {
            transformCell(cell)
        }
    }
    
    private func transformCell(_ cell: UICollectionViewCell, isEffect: Bool = true) {
        if !isEffect {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        for otherCell in collectionView.visibleCells {
            if let indexPath = collectionView.indexPath(for: otherCell) {
                if indexPath.item != layout.currentPage {
                    UIView.animate(withDuration: 0.2) {
                        otherCell.transform = .identity
                    }
                }
            }
        }
    }
}
