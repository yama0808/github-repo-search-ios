import Foundation

class RepositoryViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    @Published var errorText: String?

    private var api = GitHubAPI()

    @MainActor
    func search() async {
        guard !searchQuery.isEmpty else { return }
        isLoading = true
        errorText = nil
        
        do {
            let repositories = try await api.searchRepositories(query: searchQuery)
            self.repositories = repositories
            print(repositories.count)
            isLoading = false
        } catch {
            print(error.localizedDescription)
            errorText = error.localizedDescription
            isLoading = false
        }
    }
}
