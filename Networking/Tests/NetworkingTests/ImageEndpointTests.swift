import XCTest
@testable import Networking

final class ImageEndpointTests: XCTestCase {
    
    func test_should_correctly_generate_list_request() throws {
        XCTAssertEqual(ImageEndpoint.list(page: 1).request.url, URL(string: "https://picsum.photos/v2/list?page=1"))
        XCTAssertEqual(ImageEndpoint.list(page: 2).request.url, URL(string: "https://picsum.photos/v2/list?page=2"))
        XCTAssertEqual(ImageEndpoint.list(page: 3).request.url, URL(string: "https://picsum.photos/v2/list?page=3"))
    }
    
    func test_should_correctly_generate_fetch_request() throws {
        XCTAssertEqual(
            ImageEndpoint.fetch(id: "1012", size: CGSize(width: 300, height: 400)).request.url,
            URL(string: "https://picsum.photos/id/1012/300/400")
        )
    }
    
}
