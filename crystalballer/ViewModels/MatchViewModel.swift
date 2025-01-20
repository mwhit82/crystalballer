import Foundation
import SwiftUI
import Combine

@MainActor
class MatchViewModel: ObservableObject {
    @Published var matches: [FootballMatch]?
    @Published var isLoading = false
    @Published var error: Error?
    
    func fetchMatches(for date: Date) async {
        isLoading = true
        matches = nil
        error = nil
        
        do {
            matches = try await APIClient.shared.fetchFixtures(for: date)
        } catch {
            self.error = error
            print("Error fetching matches: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}
