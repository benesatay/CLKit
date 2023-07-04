//
//  NSCollectionLayoutSection + Extensions.swift
//  iosTurknet
//
//  Created by Bahadır Enes Atay on 1.07.2023.
//

import UIKit

extension NSCollectionLayoutSection {
    // MARK: - Final Methods
    final public func setBackground(ofSection name: String) {
        let kind = CLHelper.generateElementKind(name, .decoration)
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: kind)
        self.decorationItems = [sectionBackgroundDecoration]
    }
    
    final public func configureSectionHeader(layoutSize: NSCollectionLayoutSize,
                                             elementKind: String = UICollectionView.elementKindSectionHeader,
                                             alignment: NSRectAlignment = .top) {
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize,
                                                                        elementKind: elementKind,
                                                                        alignment: alignment)
        appendSectionSupplementaryItems(sectionHeader)
    }
    
    final public func configureSectionFooter(layoutSize: NSCollectionLayoutSize,
                                             elementKind: String = UICollectionView.elementKindSectionFooter,
                                             alignment: NSRectAlignment = .bottom) {
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSize,
                                                                        elementKind: elementKind,
                                                                        alignment: alignment)
        appendSectionSupplementaryItems(sectionHeader)
    }
    
    final public func updaLayoutSection(group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        return NSCollectionLayoutSection(group: group)
    }
    
    final class public func createLayoutSection(with group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        return NSCollectionLayoutSection(group: group)
    }
    
    // MARK: - Private Methods
    private func appendSectionSupplementaryItems(_ sectionHeader: NSCollectionLayoutBoundarySupplementaryItem) {
        if boundarySupplementaryItems.isEmpty {
            boundarySupplementaryItems = [sectionHeader]
        } else {
            boundarySupplementaryItems.append(sectionHeader)
        }
    }
}





extension NSCollectionLayoutSection {
    // MARK: - Layout
    public class func createLayoutComponents(itemLayoutSize: NSCollectionLayoutSize,
                                      groupLayoutSize: NSCollectionLayoutSize? = nil,
                                      groupDirection: CompositionalLayoutGroupDirection = .horizontal) -> LayoutSingleItemComponents {
        let item = createLayoutItem(itemLayoutSize: itemLayoutSize)
        let group = createLayoutGroup(item: item,
                                      groupLayoutSize: groupLayoutSize,
                                      groupDirection: groupDirection)
        let section = NSCollectionLayoutSection(group: group)
        return (item, group, section)
    }
    
    public class func createLayoutComponents(itemLayoutSizes: [NSCollectionLayoutSize],
                                      groupLayoutSize: NSCollectionLayoutSize,
                                      groupDirection: CompositionalLayoutGroupDirection = .horizontal) -> LayoutMultipleItemComponents {
        let items = createLayoutItems(itemLayoutSizes: itemLayoutSizes)
        let group = createLayoutGroup(with: items,
                                      groupLayoutSize: groupLayoutSize,
                                      groupDirection: groupDirection)
        let section = NSCollectionLayoutSection(group: group)
        return (items, group, section)
    }
    
    // MARK: - Item
    public class func createLayoutItem(itemLayoutSize: NSCollectionLayoutSize) -> NSCollectionLayoutItem {
        return NSCollectionLayoutItem(layoutSize: itemLayoutSize)
    }
    
    public class func createLayoutItems(itemLayoutSizes: [NSCollectionLayoutSize]) -> [NSCollectionLayoutItem] {
        return itemLayoutSizes.map { itemLayoutSize in
            NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        }
    }
    
    // MARK: - Group
    public class func createLayoutGroup(item: NSCollectionLayoutItem,
                                 groupLayoutSize: NSCollectionLayoutSize? = nil,
                                 groupDirection: CompositionalLayoutGroupDirection) -> NSCollectionLayoutGroup {
        let groupSize = groupLayoutSize ?? item.layoutSize
        switch groupDirection {
        case .vertical:
            return createVerticalLayoutGroup(item: item, groupLayoutSize: groupSize)
        case .horizontal:
            return createHorizontalLayoutGroup(item: item, groupLayoutSize: groupSize)
        }
    }
    
    public class func createLayoutGroup(with multipleItems: [NSCollectionLayoutItem],
                                 groupLayoutSize: NSCollectionLayoutSize,
                                 groupDirection: CompositionalLayoutGroupDirection) -> NSCollectionLayoutGroup {
        switch groupDirection {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: groupLayoutSize, subitems: multipleItems)
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: multipleItems)
        }
    }
    
    // MARK: - Private Methods
    
    // MARK: - Group
    private class func createVerticalLayoutGroup(item: NSCollectionLayoutItem,
                                                 groupLayoutSize: NSCollectionLayoutSize) -> NSCollectionLayoutGroup {
        if #available(iOS 16.0, *) {
            return NSCollectionLayoutGroup.vertical(layoutSize: groupLayoutSize, repeatingSubitem: item, count: 1)
        } else {
            return NSCollectionLayoutGroup.vertical(layoutSize: groupLayoutSize, subitem: item, count: 1)
        }
    }
    
    private class func createHorizontalLayoutGroup(item: NSCollectionLayoutItem,
                                                   groupLayoutSize: NSCollectionLayoutSize) -> NSCollectionLayoutGroup {
        if #available(iOS 16.0, *) {
            return NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, repeatingSubitem: item, count: 1)
        } else {
            return NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitem: item, count: 1)
        }
    }
}
