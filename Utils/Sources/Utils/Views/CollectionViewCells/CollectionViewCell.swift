//
//  CollectionViewCell.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

open class CollectionViewCell<Item>: UICollectionViewCell, ViewAware {
    
    open var item: Item?
    
    open unowned var view: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        view = self
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() {
        setupStyle()
        setupStrings()
        setupLayout()
    }
 
    open func setupStyle() {}
    open func setupStrings() {}
    open func setupLayout() {}
    
}
