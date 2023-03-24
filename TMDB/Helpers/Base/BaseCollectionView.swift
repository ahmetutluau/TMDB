//
//  BaseCollectionView.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import UIKit

class BaseCollectionView: UICollectionView {
    
    convenience init(layout: UICollectionViewLayout,
                     cells: [BaseCollectionViewCell.Type],
                     showsVerticalScrollIndicator: Bool = true,
                     showsHorizontalScrollIndicator: Bool = true,
                     backgroundColor: UIColor? = .white) {
        
        self.init(frame: .zero, collectionViewLayout: layout)
                
        for cell in cells {
            register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
        }
        
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        self.backgroundColor = backgroundColor
    }
}
