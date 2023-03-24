//
//  CustomLayout.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 15.03.2023.
//

import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    var previousOffset: CGFloat = 0.0
    var currentPage = 0
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let cv = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let itemCount = cv.numberOfItems(inSection: 0)
        if previousOffset > cv.contentOffset.x && velocity.x < 0.0 {
            //<-
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < cv.contentOffset.x && velocity.x > 0.0 {
            //->
            currentPage = min(currentPage+1, itemCount-1)
        }
        let w = cv.frame.width
        let itemW = itemSize.width
        let sp = minimumLineSpacing
        let edge = (w - itemW - sp*2) / 2
        let offset = (itemW + sp) * CGFloat(currentPage) - (edge + sp)
        previousOffset = offset
        return CGPoint(x: offset, y: proposedContentOffset.y)
    }
}
