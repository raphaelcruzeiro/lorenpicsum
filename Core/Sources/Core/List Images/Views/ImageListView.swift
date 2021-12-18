//
//  ImageListView.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit
import Utils

public final class ImageListView: UIView, ScrollViewHolder, Setupable {
    
    public var scrollView: UIScrollView {
        return collectionView
    }
        
    public let collectionView: UICollectionView
    
    private var layout: UICollectionViewLayout = {
        let fraction: CGFloat = 1 / 2
        let inset: CGFloat = 2.5
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup() {
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ImageCollectionViewCell.self)
        
        addSubview(collectionView)
        
        setupLayout()
        setupStyle()
        setupStrings()
    }
    
    
    public func setupLayout() {
        collectionView.fillSuperview()
        collectionView.layoutMargins = UIEdgeInsets(top: 36, left: 16, bottom: 36, right: 16)
    }
    
    public func setupStyle() {
        
    }
    
    public func setupStrings() {
        
    }
    
}


