//
//  File.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import Foundation

enum ImageEndpoint {
    case list(page: Int)
    
    var baseURL: URL {
        return URL(string: "https://picsum.photos")!
    }
    
    var path: String {
        switch self {
        case .list: return "v2/list"
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .list(let page): return [URLQueryItem(name: "page", value: "\(page)")]
        }
    }
    
    var url: URL {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = query
        
        return components?.url ?? url
    }
    
    var request: URLRequest {
        return URLRequest(url: url)
    }
}
