//
//  ImageCollectionViewCell.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit
import Utils
import Models

public final class ImageCollectionViewCell: CollectionViewCell<ImageListItem> {
    
    public let imageView = UIImageView()
    public let activityIndicator = UIActivityIndicatorView()
    
    public override func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicator)
        super.setup()
    }
    
    public override func setupLayout() {
        imageView.fillSuperview()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    public override func setupStyle() {
        backgroundColor = .systemGray
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
