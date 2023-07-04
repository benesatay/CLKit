//public struct CLKit {
//    public private(set) var text = "Hello, World!"
//
//    public init() {
//    }
//
//}

import UIKit

open class CLKit: CLCollectionView {
  
    public override init() {
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open override func setupView() {
        super.setupView()
    }
}
