import Foundation

actor GitHubAPI {
    private let baseURL = "https://api.github.com/search/repositories"

    func searchRepositories(query: String) async throws -> [Repository] {
        let url = URL(string: "\(baseURL)?q=\(query)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(SearchResult.self, from: data)
        return result.items
    }
}
