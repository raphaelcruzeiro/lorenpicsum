import XCTest
@testable import Models

final class ImageListItemTests: XCTestCase {
    
    func test_should_correctly_decode_from_json() throws {
        let jsonString = """
        [
            {"id":"1011","author":"Roberto Nickson","width":5472,"height":3648,"url":"https://unsplash.com/photos/7BjmDICVloE","download_url":"https://picsum.photos/id/1011/5472/3648"},
            {"id":"1012","author":"Scott Webb","width":3973,"height":2639,"url":"https://unsplash.com/photos/uAgLGG1WBd4","download_url":"https://picsum.photos/id/1012/3973/2639"}
        ]
        """
        
        let json = jsonString.data(using: .utf8) ?? Data()
        let sut: [ImageListItem] = try JSONDecoder().decode([ImageListItem].self, from: json)
        
        XCTAssertEqual(sut.count, 2)
        
        XCTAssertEqual(sut[0].id, "1011")
        XCTAssertEqual(sut[0].author, "Roberto Nickson")
        XCTAssertEqual(sut[0].downloadURL, URL(string: "https://picsum.photos/id/1011/5472/3648"))
        
        XCTAssertEqual(sut[1].id, "1012")
        XCTAssertEqual(sut[1].author, "Scott Webb")
        XCTAssertEqual(sut[1].downloadURL, URL(string: "https://picsum.photos/id/1012/3973/2639"))
    }
    
}
