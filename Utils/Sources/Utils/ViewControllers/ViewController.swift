//
//  ViewController.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

public protocol ViewControllerDelegate: AnyObject {
    func viewControllerWillDismiss(_ viewController: UIViewController)
    func viewControllerDidDismiss(_ viewController: UIViewController)
}

public protocol ViewControllerProtocol: AnyObject {
    var viewControllerDelegate: ViewControllerDelegate? { get set }
    func setPresentationControllerDelegate(viewControllerToPresent: UIViewController)
}

extension ViewControllerProtocol where Self : UIAdaptivePresentationControllerDelegate {
    
    public func setPresentationControllerDelegate(viewControllerToPresent: UIViewController) {
        if viewControllerToPresent is ViewControllerProtocol {
            viewControllerToPresent.presentationController?.delegate = self
        }
    }
    
}

open class ViewController: UIViewController, ViewControllerProtocol, ViewAware {

    weak public var viewControllerDelegate: ViewControllerDelegate?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        setPresentationControllerDelegate(viewControllerToPresent: viewControllerToPresent)
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    // MARK: Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        c_viewWillAppear(animated)
    }

    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        c_didMove(toParent: parent)
    }
    
    // MARK: ViewAware
    open func setup() {
        setupStyle()
        setupStrings()
        setupLayout()
    }
    
    open func setupStyle() {
        view.backgroundColor = .white
    }
    
    open func setupStrings() {
        // To be overriden
    }
    
    open func setupLayout() {
        // To be overriden
    }
    
    // MARK: Keyboard
    
    open func keyboardWillShow(endframe: CGRect?) {
        // Not implemented here
    }
    
    open func keyboardDidShow(endframe: CGRect?) {
        // Not implemented here
    }
    
    open func keyboardWillHide(endframe: CGRect?) {
        // Not implemented here
    }
    
    open func keyboardDidHide(endframe: CGRect?) {
        // Not implemented here
    }
    
    // MARK Internal
    
    func c_viewWillAppear(_ animated: Bool) {}
    func c_didMove(toParent parent: UIViewController?) {}
    
}

extension ViewController: UIAdaptivePresentationControllerDelegate {
    
    open func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        (presentationController.presentedViewController as? ViewControllerProtocol)?.viewControllerDelegate?.viewControllerWillDismiss(presentationController.presentedViewController)
    }
    
    open func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        (presentationController.presentedViewController as? ViewControllerProtocol)?.viewControllerDelegate?.viewControllerDidDismiss(presentationController.presentedViewController)
    }
    
}
