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

public struct ImageListSection: SectionProtocol {
    
    public typealias Item = ImageListItem
    public var title: String
    public var items: [ImageListItem]

}

public final class ImageListViewModel: ListViewModel {
    
    // TODO: move this
    let imageService = ImageService()
    
    public typealias Item = ImageListItem
    public typealias Section = ImageListSection
    
    public var sections: [ImageListSection]
    
    var currentPage = 1
    
    public init() {
        sections = []
    }
    
    public init(sections: [ImageListSection]) {
        self.sections = sections
    }
    
    func fetch(page: Int = 1) async throws -> [ImageListItem] {
        if sections.count == 0 {
            sections.append(Section(title: "", items: []))
        }
        
        let newImages = try await imageService.list(page: page)
        print("Fetched page: \(page)")
        sections[0].items += newImages
        currentPage = page
        
        return newImages
    }
    
    func image(for item: ImageListItem, with size: CGSize) async throws -> Data {
        return try await imageService.fetch(id: item.id, size: size)
    }
    
}
