//
//  Layoutable.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import Foundation

public protocol Layoutable {
    
    associatedtype Layout: LayoutProtocol
    
    static var layout: Layout { get }
    
}

public extension Layoutable {
    
    static var layout: Layout {
        return Layout()
    }
    
}
