//
//  Dequeuable.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

public protocol Dequeuable: AnyObject {
    var reuseIdentifier: String? { get }
}

extension Dequeuable where Self : UIView {
    public static var reuseIndentifier: String {
        return NSStringFromClass(self)
    }
}
