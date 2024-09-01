import Foundation

struct SearchResult: Codable {
    let items: [Repository]
}

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let stargazersCount: Int
    let htmlUrl: String
    let owner: Owner
    let updatedAt: String

    struct Owner: Codable {
        let login: String
        let avatarUrl: String
        
        enum CodingKeys: String, CodingKey {
            case login
            case avatarUrl = "avatar_url"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
        case owner
        case updatedAt = "updated_at"
    }
}

let sampleRepository: Repository = .init(id: 1, name: "Swift", fullName: "Swift", description: "description", stargazersCount: 100, htmlUrl: "", owner: .init(login: "", avatarUrl: ""), updatedAt: "")
