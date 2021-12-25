//
//  ScrollViewController.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

import UIKit

open class ScrollViewController<V: UIView & ScrollViewHolder, VM: ViewModel>: ViewModelViewController<V, VM> {
    
    public var scrollView: UIScrollView {
        return hostedView.scrollView
    }
    
    open override func setup() {
        super.setup()
        (hostedView as? Setupable)?.setup()
    }
    
}
