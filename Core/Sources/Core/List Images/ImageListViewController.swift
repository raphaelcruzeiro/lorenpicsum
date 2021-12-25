//
//  ImageListViewController.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit
import Utils

public class ImageListViewController: ScrollViewController<ImageListView, ImageListViewModel> {
    
    private let thumbSize: CGFloat = 600
    
    private var isLoading = false
    
    var collectionView: UICollectionView {
        return hostedView.collectionView
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource = {
        return UICollectionViewDiffableDataSource<Int, ImageListViewModel.Item.ID>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell: ImageCollectionViewCell = collectionView.dequeue(for: indexPath)
            cell.item = self.viewModel.item(for: indexPath)
            
            Task {
                do {
                    guard let item = self.viewModel.item(for: indexPath) else { return }
                    cell.activityIndicator.startAnimating()
                    
                    let imageData = try await self.viewModel.image(
                        for: item,
                        with: CGSize(width: self.thumbSize, height: self.thumbSize)
                    )
                    
                    let image = UIImage(data: imageData)
                    cell.imageView.image = image
                    cell.activityIndicator.stopAnimating()
                } catch {
                    // We could add a placeholder here
                }
            }
            
            return cell
        })
    }()
    
    public override func setup() {
        super.setup()
        collectionView.delegate = self
        collectionView.dataSource = dataSource
    }
    
    public override func setupStrings() {
        super.setupStrings()
        title = "Loren Picsum"
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load()
    }
    
    func load(page: Int = 1) {
        if isLoading || (page == 1 && !viewModel.items.isEmpty) {
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let newImages = try await viewModel.fetch(page: page)
                var snapshot: NSDiffableDataSourceSnapshot<Int, ImageListViewModel.Item.ID>
                
                if page == 1 {
                    snapshot = NSDiffableDataSourceSnapshot<Int, ImageListViewModel.Item.ID>()
                    snapshot.appendSections([0])
                } else {
                    snapshot = dataSource.snapshot()
                }
                
                snapshot.appendItems(newImages.map(\.id), toSection: 0)
                dataSource.apply(snapshot, animatingDifferences: true)
                
            } catch {
                print(error.localizedDescription)
            }
            
            isLoading = false
        }
    }

}

extension ImageListViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let maxRow = (collectionView.indexPathsForVisibleItems.map({ $0.row }).max() ?? 0)
        
        if maxRow >= viewModel.items.count - 6 {
            load(page: viewModel.currentPage + 1)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModel.item(for: indexPath) else { return }
        navigationController?.pushViewController(
            ImageDetailsViewController(viewModel: ImageDetailsViewModel(item: item)),
            animated: true
        )
    }
    
}
