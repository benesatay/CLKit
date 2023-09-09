//
//  BaseCompositionalCollectionView.swift
//  iosTurknet
//
//  Created by Bahadır Enes Atay on 30.06.2023.
//

import UIKit


// MARK: - BaseCompositionalCollectionView

open class CLCollectionView: UICollectionView {
    
    // MARK: - Private Properties
    public var diffableDataSource: DiffableDataSource?
    
    // MARK: - Public Properties
    public weak var clDelegate: CLDelegate?

    // MARK: - Init
    public init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Open Methods
    open func setupViews() {
        backgroundColor = .clear
    }
    
    // MARK: - Public Final Methods
    public final func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource(
            collectionView: self,
            cellProvider: { collectionView, indexPath, item in
                return self.configureCell(of: collectionView, at: indexPath, item: item)
            }
        )
        
        configureSupplementaryViewProvider()
        applySnapshot()
    }
    
    public final func registerCells(_ info: [CellRegistrationItem]) {
        for item in info {
            self.register(item.metatype, forCellWithReuseIdentifier: item.identifier)
        }
    }
    
    public final func registerSupplementaryItems(_ items: [SupplementaryRegistrationItem]) {
        for item in items {
            registerSupplementaryItem(item)
        }
    }
    
    public final func registerSupplementaryItem(_ item: SupplementaryRegistrationItem) {
        let kind = CLHelper.generateElementKind(item.sectionName, item.element)
        let identifier = CLHelper.generateIdentifier(item.sectionName, item.element)
        self.register(item.viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
    
    // MARK: - Private Methods
    private func configureSupplementaryViewProvider() {
        diffableDataSource?.supplementaryViewProvider = {(collectionView: UICollectionView,
                                                          kind: String,
                                                          indexPath: IndexPath) -> UICollectionReusableView? in
            guard let identifier = self.configureSupplementaryViewIdentifier(in: indexPath.section,
                                                                             kind: kind) else { return nil }
            return self.configureSupplementaryView(of: collectionView,
                                                   kind: kind,
                                                   identifier: identifier,
                                                   at: indexPath)
        }
    }
   
    private func applySnapshot() {
        var snapshot = DiffableDataSourceSnapshot()
        clDelegate?.configureSnapshot(snapshot: &snapshot)
        diffableDataSource?.apply(snapshot)
    }
    
    private func configureCell(of collectionView: UICollectionView,
                               at indexPath: IndexPath,
                               item: AnyHashable) -> UICollectionViewCell {
        return clDelegate?.setupCell(for: item, at: indexPath) ?? UICollectionViewCell()
    }
    
    private func configureSupplementaryView(of collectionView: UICollectionView,
                                            kind: String,
                                            identifier: String,
                                            at indexPath: IndexPath) -> UICollectionReusableView? {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: identifier,
                                                                   for: indexPath)
        clDelegate?.setupSupplementaryItem(view, in: indexPath.section)
        return view
    }
    
    private func configureSupplementaryViewIdentifier(in section: Int, kind: String) -> String? {
        return clDelegate?.configureSupplementaryViewIdentifier(in: section, kind: kind)
//        guard let supplementaryItems else { return nil }
//        for supplementaryItem in supplementaryItems {
//            if self.identifiers?[section] == supplementaryItem.sectionName {
//                let elementKind = CLHelper.generateElementKind(supplementaryItem.sectionName,
//                                                                                   supplementaryItem.element)
//                if kind == elementKind {
//                    return CLHelper.generateIdentifier(supplementaryItem.sectionName,
//                                                                           supplementaryItem.element)
//                }
//            }
//        }
//        return nil
    }
}

// MARK: - UICollectionViewDelegate
extension CLCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clDelegate?.didItemSelected(at: indexPath)
    }
}
