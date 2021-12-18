//
//  ViewModelViewController.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

open class ViewModelViewController<V: UIView, VM: ViewModel>: HostingViewController<V>, ViewModelHolder {
    
    public let viewModel: VM
    
    public init(viewModel: VM = VM()) {
        self.viewModel = viewModel
        super.init()
    }
    
}

