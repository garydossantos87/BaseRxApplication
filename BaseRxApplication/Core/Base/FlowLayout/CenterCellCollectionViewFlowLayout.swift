//
//  CenterCellCollectionViewFlowLayout.swift
//  Seat
//
//  Created by Gary Dos Santos on 27/1/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

public class CenterCellCollectionViewFlowLayout : UICollectionViewFlowLayout {
    
    // Centered Paging with Preview Cells on UICollectionView
    // http://blog.karmadust.com/centered-paging-with-preview-cells-on-uicollectionview/
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return CGPoint(x: 0, y: 0)
        }
        
        let cvBounds = collectionView.bounds
        let halfWidth = cvBounds.width / 2.0
        let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
        var candidateAttributes: UICollectionViewLayoutAttributes? = nil
        
        for attributes: UICollectionViewLayoutAttributes in layoutAttributesForElements(in: cvBounds)! {
            // Skip comparison with non-cell items (headers and footers)
            if attributes.representedElementCategory != .cell {
                continue
            }
            
            if candidateAttributes != nil {
                if abs(attributes.center.x - proposedContentOffsetCenterX) < abs((candidateAttributes?.center.x)! - proposedContentOffsetCenterX) {
                    candidateAttributes = attributes
                }
            } else { // First time in loop
                candidateAttributes = attributes
                continue
            }
        }
        
        // Special case
        if proposedContentOffset.x == -(collectionView.contentInset.left) {
            return proposedContentOffset
        }
        
        return CGPoint(x: floor(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)
    }
    
}
