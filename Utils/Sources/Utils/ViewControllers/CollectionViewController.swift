//
//  CollectionViewController.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit

open class CollectionViewController<V: UIView & CollectionViewHolder, VM: ListViewModel, C: CollectionViewCell<VM.Item>>: ViewModelViewController<V, VM>, CollectionViewHolder, UICollectionViewDataSource {
    
    open override func setup() {
        super.setup()
          
        collectionView.register(C.self)
        collectionView.dataSource = self
    }
    
    open var collectionView: UICollectionView {
        return hostedView.collectionView
    }
    
    open  func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = viewModel.section(for: section) else { return 0 }
        return section.items.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: C = collectionView.dequeue(for: indexPath)
        cell.item = viewModel.item(for: indexPath)
        
        return cell
    }
    
    open func collectionView(_ collectionView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.section(for: section)?.title
    }
    
}
