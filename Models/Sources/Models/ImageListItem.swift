//
//  ImageListItem.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import Foundation

public class ImageListItem: Decodable, Identifiable, CustomDebugStringConvertible {
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case downloadURL = "download_url"
    }
    
    public var id: String
    public var author: String
    public var downloadURL: URL
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        self.downloadURL = try container.decode(URL.self, forKey: .downloadURL)
    }
    
    public var debugDescription: String {
        return [id, author].joined(separator: " - ")
    }
    
}
