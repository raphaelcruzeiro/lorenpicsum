//
//  UICollectionView+Dequeable.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

extension UICollectionViewCell: Dequeuable {}

extension UICollectionView {
    public func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.classForCoder(), forCellWithReuseIdentifier: T.reuseIndentifier)
    }
    
    public func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIndentifier, for: indexPath) as! T
    }
}
