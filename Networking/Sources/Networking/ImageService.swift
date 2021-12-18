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
    
    public init() {}
    
    @MainActor
    public func list(page: Int = 1) async throws -> [ImageListItem] {
        let response = try await fire(request: ImageEndpoint.list(page: page).request)
        return try JSONDecoder().decode([ImageListItem].self, from: response.0)
    }
    
    @MainActor
    public func fetch(id: String, size: CGSize) async throws -> Data {
        return try await fire(request: ImageEndpoint.fetch(id: id, size: size).request).0
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
