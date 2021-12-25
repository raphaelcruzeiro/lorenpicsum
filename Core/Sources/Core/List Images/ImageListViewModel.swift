//
//  ImageListViewModel.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import Foundation
import CoreImage
import Utils
import Models
import Networking

public final class ImageListViewModel: ViewModel {
    
    // TODO: move this
    let imageService = ImageService()
    
    public typealias Item = ImageListItem
    
    public var items: [Item]
    
    var currentPage = 1
    
    public init() {
        items = []
    }
    
    func fetch(page: Int = 1) async throws -> [ImageListItem] {
        let newImages = try await imageService.list(page: page)
        print("Fetched page: \(page)")
        items += newImages
        currentPage = page
        
        return newImages
    }
    
    func image(for item: ImageListItem, with size: CGSize) async throws -> Data {
        return try await imageService.fetch(id: item.id, size: size)
    }
    
    func item(for indexPath: IndexPath) -> ImageListItem? {
        if indexPath.row + 1 > items.count {
            return nil
        }
        
        return items[indexPath.row]
    }
    
}
