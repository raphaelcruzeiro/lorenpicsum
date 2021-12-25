//
//  ImageService.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import Foundation
import CoreImage
import Models

public class ImageService {
    
    private lazy var cache: URLCache = {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let diskCacheURL = cachesURL.appendingPathComponent("DownloadCache")
        let cache = URLCache(memoryCapacity: 10_000_000_000, diskCapacity: 1_000_000_000_000, directory: diskCacheURL)
        
        return cache
    }()
    
    private lazy var session: URLSession = {
        var config = URLSessionConfiguration.default
        config.urlCache = cache
        
        return URLSession(configuration: config)
    }()
    
    public init() {}
    
    @MainActor
    public func list(page: Int = 1) async throws -> [ImageListItem] {
        let response = try await fire(request: ImageEndpoint.list(page: page).request)
        return try JSONDecoder().decode([ImageListItem].self, from: response.0)
    }
    
    @MainActor
    public func fetch(id: String, size: CGSize) async throws -> Data {
        let request = ImageEndpoint.fetch(id: id, size: size).request
        
        if let response = cache.cachedResponse(for: request) {
            return response.data
        }
        
        let result = try await fire(request: request)
        cache.storeCachedResponse(CachedURLResponse(response: result.1, data: result.0), for: request)
        
        return result.0
    }
    
    private func fire(request: URLRequest) async throws -> (Data, URLResponse) {
        if #available(iOS 15.0, *) {
            return try await session.data(for: request, delegate: nil)
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                session.dataTask(with: request) { data, response, error in
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
