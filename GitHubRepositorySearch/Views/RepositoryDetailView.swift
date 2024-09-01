import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: repository.owner.avatarUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                }
                .padding()

                Text(repository.fullName)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                if let description = repository.description {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.gray)
                }

                Text("Stars: \(repository.stargazersCount)")
                    .font(.headline)
                    .padding(.top)

                Link("View on GitHub", destination: URL(string: repository.htmlUrl)!)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Repository Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    RepositoryDetailView(repository: sampleRepository)
}
