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
        applySnapshot()
    }
    
    public final func registerCells(_ info: [CellRegistrationItem]) {
        for item in info {
            self.register(item.metatype, forCellWithReuseIdentifier: item.identifier)
        }
    }

    public final func configureSupplementaryViewProvider(with registrationItems: [SupplementaryRegistrationItem]) {
        registerSupplementaryItems(registrationItems)
        guard let diffableDataSource else { return }
        diffableDataSource.supplementaryViewProvider = {(collectionView: UICollectionView,
                                                          kind: String,
                                                          indexPath: IndexPath) -> UICollectionReusableView? in
            guard let identifier = self.configureSupplementaryViewIdentifier(in: indexPath.section) else { return nil }
            return self.configureSupplementaryView(of: collectionView,
                                                   kind: kind,
                                                   identifier: identifier,
                                                   at: indexPath)
        }
    }
    
    // MARK: - Private Methods
    
    private func registerSupplementaryItems(_ items: [SupplementaryRegistrationItem]) {
        for item in items {
            registerSupplementaryItem(item)
        }
    }
    
    private func registerSupplementaryItem(_ item: SupplementaryRegistrationItem) {
        let kind = CLHelper.generateElementKind(item.sectionName, item.element)
        let identifier = CLHelper.generateIdentifier(item.sectionName, item.element)
        self.register(item.viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
    
    private func applySnapshot() {
        var snapshot = DiffableDataSourceSnapshot()
        clDelegate?.configureSnapshot(snapshot: &snapshot)
        diffableDataSource?.apply(snapshot)
    }
    
    private func configureCell(of collectionView: UICollectionView,
                               at indexPath: IndexPath,
                               item: AnyHashable) -> UICollectionViewCell {
        return clDelegate?.setupCell(for: item, of: collectionView, at: indexPath) ?? UICollectionViewCell()
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
    
    private func configureSupplementaryViewIdentifier(in section: Int) -> String? {
        return clDelegate?.configureSupplementaryViewIdentifier(in: section)
    }
}

// MARK: - UICollectionViewDelegate
extension CLCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clDelegate?.didItemSelected(at: indexPath)
    }
}
