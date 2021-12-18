//
//  ViewModelHolder.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import Foundation

public protocol ViewModelHolder {
    associatedtype VM: ViewModel
    var viewModel: VM { get }
}
