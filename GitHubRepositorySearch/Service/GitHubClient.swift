import Foundation

actor GitHubClient {
    private let baseURL = "https://api.github.com/search/repositories"

    func searchRepositories(query: String) async throws -> [Repository] {
        let url = URL(string: "\(baseURL)?q=\(query)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(SearchResult.self, from: data)
        return result.items
    }
}

class MockGitHubClient {
    var mockData: Data?
    var mockError: Error?
    
    func searchRepositories(query: String) async throws -> [Repository] {
        if let error = mockError {
            throw error
        }
        guard let data = mockData else {
            throw NSError(domain: "MockGitHubClientError", code: 0, userInfo: nil)
        }
        let result = try JSONDecoder().decode(SearchResult.self, from: data)
        return result.items
    }
}
