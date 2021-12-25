//
//  HostingViewController.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

open class HostingViewController<V: UIView>: ViewController {
    
    open var hostedView: V {
        return view as! V
    }
    
    open override func loadView() {
        self.view = V()
        
        (view as? Setupable)?.setup()
    }
    
}
