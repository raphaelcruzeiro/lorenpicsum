//
//  ImageDetailsViewHolder.swift
//  
//
//  Created by Raphael Cruzeiro on 19/12/2021.
//

import UIKit
import Utils

public final class ImageDetailsViewHolder: UIView, ViewHolder, Setupable {

    public unowned var view: UIView!
    
    private let activityIndicatorView = UIActivityIndicatorView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(activityIndicatorView)
        
        setupStyle()
        setupLayout()
        setupStrings()
    }
    
    public func setupStyle() {
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        titleLabel.layer.shadowOpacity = 0.8
        titleLabel.layer.shadowRadius = 2
        titleLabel.layer.shadowColor = UIColor.black.cgColor
    }
    
    public func setupStrings() {
        
    }
    
    public func setupLayout() {
        imageView.fillSuperview()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    public func set(image: UIImage, with title: String) {
        imageView.image = image
        titleLabel.text = title
    }
    
}
