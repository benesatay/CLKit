//
//  CLCollectionView.swift
//  iosTurknet
//
//  Created by Bahadır Enes Atay on 26.06.2023.
//
import UIKit
import SnapKit

open class CLCollectionView: UIView {
    
    public lazy var collectionView: BaseCLCollectionView = {
        let layout = createLayout()
        let view = BaseCLCollectionView(collectionViewLayout: layout)
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Public Properties
    public weak var collectionDelegate: CCVDelegate? {
        didSet {
            collectionView.ccvDelegate = collectionDelegate
        }
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    open func setupView() {
        backgroundColor = .clear
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Private Methods
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            return self.collectionDelegate?.configureLayout(at: sectionIndex)
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        collectionDelegate?.configureLayoutConfig(config)
        layout.configuration = config
        collectionDelegate?.registerLayoutDecorationView(layout)
        return layout
    }
}
