//public struct CLKit {
//    public private(set) var text = "Hello, World!"
//
//    public init() {
//    }
//
//}

import UIKit

open class CLKit: CLCollectionView {
    
    public override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
