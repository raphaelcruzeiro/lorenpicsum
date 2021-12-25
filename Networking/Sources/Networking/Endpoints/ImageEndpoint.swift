//
//  File.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import Foundation
import CoreImage

enum ImageEndpoint {
    case list(page: Int)
    case fetch(id: String, size: CGSize)
    
    var baseURL: URL {
        return URL(string: "https://picsum.photos")!
    }
    
    var path: String {
        switch self {
        case .list: return "v2/list"
        case .fetch(let id, let size): return "id/\(id)/\(Int(size.width))/\(Int(size.height))"
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .list(let page): return [URLQueryItem(name: "page", value: "\(page)")]
        default: return nil
        }
    }
    
    var url: URL {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = query
        
        return components?.url ?? url
    }
    
    var request: URLRequest {
        switch self {
        case .fetch: return URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        case  .list: return URLRequest(url: url)
        }
        
    }
}
