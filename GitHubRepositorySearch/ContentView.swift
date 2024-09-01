import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RepositoryViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                        .padding()
                } else if let errorText = viewModel.errorText {
                    Text("Error: \(errorText)")
                        .foregroundColor(.red)
                        .padding()
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                } else {
                    List(viewModel.repositories) { repo in
                        RepositoryRow(repository: repo)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("GitHub Search")
        }
        .searchable(text: $viewModel.searchQuery)
        .onSubmit(of: .search) {
            Task {
                await viewModel.search()
            }
        }
    }
}

#Preview {
    ContentView()
}
