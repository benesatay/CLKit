//
//  UICollectionViewCompositionalLayoutConfiguration + Extensions.swift
//  iosTurknet
//
//  Created by Bahadır Enes Atay on 2.07.2023.
//

import UIKit

extension UICollectionViewCompositionalLayoutConfiguration {
    
    // MARK: - Final Methods
    final func configureLayoutHeader(layoutSize: NSCollectionLayoutSize,
                                     elementKind: String = UICollectionView.elementKindSectionHeader,
                                     alignment: NSRectAlignment = .top) {
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize,
                                                                 elementKind: elementKind,
                                                                 alignment: alignment)
        appendLayoutSupplementaryItems(header)
    }
    
    final func configureLayoutFooter(layoutSize: NSCollectionLayoutSize,
                                     elementKind: String = UICollectionView.elementKindSectionFooter,
                                     alignment: NSRectAlignment = .bottom) {
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize,
                                                                 elementKind: elementKind,
                                                                 alignment: alignment)
        appendLayoutSupplementaryItems(header)
    }
    
    // MARK: - Private Methods
    private func appendLayoutSupplementaryItems(_ sectionHeader: NSCollectionLayoutBoundarySupplementaryItem) {
        if boundarySupplementaryItems.isEmpty {
            boundarySupplementaryItems = [sectionHeader]
        } else {
            boundarySupplementaryItems.append(sectionHeader)
        }
    }
}
