//
//  File.swift
//  
//
//  Created by Bahadır Enes Atay on 4.07.2023.
//

import UIKit

public typealias CLDelegate = (CLCellDelegate & CLDecorationViewDelegate & CLSupplementaryItemDelegate)

public protocol CLCellDelegate: AnyObject {
    func setupCell(for item: AnyHashable, of collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    func didItemSelected(at indexPath: IndexPath)
    func configureSnapshot(snapshot: inout DiffableDataSourceSnapshot)
}

public protocol CLDecorationViewDelegate: AnyObject {
    func registerLayoutDecorationView(_ layout: UICollectionViewCompositionalLayout)
}

public protocol CLSupplementaryItemDelegate: AnyObject {
    func configureSupplementaryViewIdentifier(in section: Int) -> String?
    func setupSupplementaryItem(_ view: UICollectionReusableView, in section: Int)
}
