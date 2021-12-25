//
//  ImageDetailsViewModel.swift
//  
//
//  Created by Raphael Cruzeiro on 19/12/2021.
//

import Foundation
import CoreImage
import Utils
import Models
import Networking

public final class ImageDetailsViewModel: ViewModel {
    
    public typealias Item = ImageListItem
    
    var item: Item?
    
    public init(item: ImageListItem) {
        self.item = item
    }
    
    public init() {
        
    }
    
    func fetchImage(with size: CGSize) async throws -> Data {
        guard let item = item else {
            return Data()
        }
        
        return try await ImageService().fetch(id: item.id, size: size)
    }
    
}
