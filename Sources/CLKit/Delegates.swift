//
//  File.swift
//  
//
//  Created by Bahadır Enes Atay on 4.07.2023.
//

import UIKit

public typealias CLDelegate = (CLCellDelegate & CLDecorationViewDelegate & CLSupplementaryItemDelegate)

public protocol CLCellDelegate: AnyObject {
    func setupCell(_ cell: UICollectionViewCell, at indexPath: IndexPath, item: AnyHashable)
    func didItemSelected(at indexPath: IndexPath)
    func configureSnapshot(snapshot: inout DiffableDataSourceSnapshot)
}

public protocol CLDecorationViewDelegate: AnyObject {
    func registerLayoutDecorationView(_ layout: UICollectionViewCompositionalLayout)
}

public protocol CLSupplementaryItemDelegate: AnyObject {
    func setupSupplementaryItem(_ view: UICollectionReusableView, in section: Int)
}
