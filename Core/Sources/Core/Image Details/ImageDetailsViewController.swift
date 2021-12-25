//
//  ImageDetailsViewController.swift
//  
//
//  Created by Raphael Cruzeiro on 19/12/2021.
//

import UIKit
import Utils

public final class ImageDetailsViewController: ViewModelViewController<ImageDetailsViewHolder, ImageDetailsViewModel> {
    
    var image: UIImage?
    
    public override func setup() {
        super.setup()
        
        let shareButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain, target: self,
            action: #selector(self.shareTap(_:))
        )
        navigationItem.rightBarButtonItem = shareButton
    }
    
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
                self.image = image
                hostedView.set(image: image, with: viewModel.item?.author ?? "")
                hostedView.isLoading = false
            } catch {
                
            }
        }
    }
    
    @objc private func shareTap(_ sender: UIControl) {
        let activityController = UIActivityViewController(
            activityItems: [image as Any], applicationActivities: nil
        )
        present(activityController, animated: true, completion: nil)
    }
    
}
