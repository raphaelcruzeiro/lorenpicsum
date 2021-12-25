//
//  ImageDetailsViewController.swift
//  
//
//  Created by Raphael Cruzeiro on 19/12/2021.
//

import UIKit
import Utils

public final class ImageDetailsViewController: ViewModelViewController<ImageDetailsViewHolder, ImageDetailsViewModel> {
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }
    
    private func load() {
        hostedView.isLoading = true
        
        Task {
            do {
                let imageData = try await viewModel.fetchImage(with: view.bounds.size)
                let image = UIImage(data: imageData) ?? UIImage()
                hostedView.set(image: image, with: viewModel.item?.author ?? "")
                hostedView.isLoading = false
            } catch {
                
            }
        }
    }
    
}
