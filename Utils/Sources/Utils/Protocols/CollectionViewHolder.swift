//
//  CollectionViewHolder.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

public protocol CollectionViewHolder: ScrollViewHolder {
    var collectionView: UICollectionView { get }
    
    func add(tableHeaderView view: UIView)
}

public extension CollectionViewHolder {
    
    var scrollView: UIScrollView {
        return collectionView
    }
    
    func add(tableHeaderView view: UIView) {}
    
}

public extension CollectionViewHolder where Self: Layoutable {
    
}
