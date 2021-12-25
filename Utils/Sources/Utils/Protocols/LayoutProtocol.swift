//
//  LayoutProtocol.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

public protocol LayoutProtocol: Initializable {
    var insets: UIEdgeInsets { get }
    var margin: LayoutDistances.Type { get }
    var spacing: LayoutDistances.Type { get }
}
