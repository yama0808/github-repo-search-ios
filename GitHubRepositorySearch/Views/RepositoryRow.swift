import SwiftUI

struct RepositoryRow: View {
    let repository: Repository

    var body: some View {
        NavigationLink(destination: RepositoryDetailView(repository: repository)) {
            HStack {
                AsyncImage(url: URL(string: repository.owner.avatarUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                }

                VStack(alignment: .leading) {
                    Text(repository.fullName)
                        .font(.headline)
                    if let description = repository.description {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(repository.stargazersCount)")
                            .font(.footnote)
                    }
                }
                .padding(.leading, 8)
            }
        }
    }
}

#Preview {
    RepositoryRow(repository: sampleRepository)
}
