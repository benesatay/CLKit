//
//  File.swift
//  
//
//  Created by Bahadır Enes Atay on 4.07.2023.
//

import UIKit

public typealias CCVDelegate = (CCVCellDelegate & CCVLayoutDelegate & CCVDecorationViewDelegate & CCVSupplementaryItemDelegate)

public protocol CCVCellDelegate: AnyObject {
    func setupCell(_ cell: UICollectionViewCell, at indexPath: IndexPath)
    func didItemSelected(at indexPath: IndexPath)
}

public protocol CCVLayoutDelegate: AnyObject {
    func configureLayout(at sectionIndex: Int) -> NSCollectionLayoutSection?
    func configureLayoutConfig(_ config: UICollectionViewCompositionalLayoutConfiguration)
    func configureSnapshot(snapshot: DiffableDataSourceSnapshot)
}

public protocol CCVDecorationViewDelegate: AnyObject {
    func registerLayoutDecorationView(_ layout: UICollectionViewCompositionalLayout)
}

public protocol CCVSupplementaryItemDelegate: AnyObject {
    func setupSupplementaryItem(_ view: UICollectionReusableView, in section: Int)
}
