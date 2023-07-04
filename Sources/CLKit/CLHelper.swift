//
//  CompositionalCollectionUtils.swift
//  iosTurknet
//
//  Created by Bahadır Enes Atay on 2.07.2023.
//

import UIKit

// MARK: - Base Diffable Data Soruce
public typealias DiffableDataSource = UICollectionViewDiffableDataSource<AnyHashable, AnyHashable>
// MARK: - Base Diffable Data Soruce Snapshot
public typealias DiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>
// MARK: - Cell Registration Item
public typealias CellRegistrationItem = (metatype: UICollectionViewCell.Type, identifier: String)
// MARK: - LayoutComponents
public typealias LayoutSingleItemComponents = (item: NSCollectionLayoutItem,
                                        group: NSCollectionLayoutGroup,
                                        section: NSCollectionLayoutSection)
public typealias LayoutMultipleItemComponents = (items: [NSCollectionLayoutItem],
                                          group: NSCollectionLayoutGroup,
                                          section: NSCollectionLayoutSection)

// MARK: - Supplementary Registration Item
public struct SupplementaryRegistrationItem {
    var viewClass: AnyClass?
    var sectionName: String
    var element: CompositionalLayoutElementKindKey = .header
    
    public init(viewClass: AnyClass? = nil, sectionName: String, element: CompositionalLayoutElementKindKey) {
        self.viewClass = viewClass
        self.sectionName = sectionName
        self.element = element
    }
}

// MARK: - Supplementary Item Type
public enum CompositionalLayoutElementKindKey: String {
    case decoration
    case header
    case footer
}

public enum CompositionalLayoutGroupDirection {
    case vertical
    case horizontal
}

public class CLHelper {
    // MARK: - Public Methods
    public class func generateElementKind(_ sectionName: String, _ key: CompositionalLayoutElementKindKey) -> String {
        switch key {
        case .decoration:
            return String(format: "%@%@", sectionName, "SectionDecoration")
        case .footer:
            return UICollectionView.elementKindSectionFooter
        case.header:
            return UICollectionView.elementKindSectionHeader
        }
    }
    
    public class func generateIdentifier(_ sectionName: String, _ key: CompositionalLayoutElementKindKey) -> String {
        return String(format: "%@%@", sectionName, key.rawValue)
    }
}
