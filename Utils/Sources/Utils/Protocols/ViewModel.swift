//
//  ViewModel.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import Foundation

public protocol ViewModel: Initializable, AnyObject {
    associatedtype Item
}
