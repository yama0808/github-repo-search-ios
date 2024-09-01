import XCTest
@testable import GitHubRepositorySearch

final class GitHubRepositorySearchTests: XCTestCase {
    var mockGitHubClient: MockGitHubClient!

    override func setUpWithError() throws {
        mockGitHubClient = MockGitHubClient()
    }

    override func tearDownWithError() throws {
        mockGitHubClient = nil
    }

    func testFetchRepositoriesSuccess() async throws {
        let mockResponse = """
                {
                    "items": [
                        {
                            "id": 1,
                            "name": "swift",
                            "full_name": "apple/swift",
                            "description": "The Swift Programming Language",
                            "stargazers_count": 12345,
                            "html_url": "https://github.com/apple/swift",
                            "owner": {
                                "login": "apple",
                                "avatar_url": "https://avatars.githubusercontent.com/u/10639145?v=4"
                            },
                            "updated_at": "2024-09-01T21:55:17Z",
                        }
                    ]
                }
                """.data(using: .utf8)!

        mockGitHubClient.mockData = mockResponse

        let query = "swift"
        let repositories = try await mockGitHubClient.searchRepositories(query: query)

        XCTAssertEqual(repositories.first?.name, "swift")
        XCTAssertEqual(repositories.first?.description, "The Swift Programming Language")
    }
    
    func testFetchRepositoriesUnknown() async throws {
        mockGitHubClient.mockError = URLError(.unknown)
        
        let query = "invalid-query"
        do {
            _ = try await mockGitHubClient.searchRepositories(query: query)
            XCTFail("Expected an error but got a successful response")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .unknown)
        }
    }
}
