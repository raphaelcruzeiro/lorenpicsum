//
//  ImageService.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import Foundation
import Models

public class ImageService {
    
    private enum Endpoint {
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
    }
    
    public init() {}
    
    public func fetch(page: Int = 0) async throws -> [ImageListItem] {
        let response = try await fire(request: URLRequest(url: Endpoint.list(page: page).url))
        return try JSONDecoder().decode([ImageListItem].self, from: response.0)
    }
    
    private func fire(request: URLRequest) async throws -> (Data, URLResponse) {
        if #available(iOS 15.0, *) {
            return try await URLSession.shared.data(for: request, delegate: nil)
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    }
                    if let data = data, let response = response {
                        continuation.resume(with: .success((data, response)))
                    }
                }
                .resume()
            }
        }
    }
    
}
