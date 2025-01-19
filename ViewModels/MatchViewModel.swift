import Foundation

@MainActor
class MatchViewModel: ObservableObject {
    @Published var matches: [Match] = []
    @Published var isLoading = false
    @Published var error: String?
    
    func fetchMatches(for date: Date) async {
        isLoading = true
        // TODO: Implement API call
        isLoading = false
    }
}
