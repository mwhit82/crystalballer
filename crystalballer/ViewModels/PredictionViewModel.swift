import Foundation
import Combine

@MainActor
class PredictionViewModel: ObservableObject {
    @Published var prediction: Prediction?
    @Published var isLoading = false
    @Published var error: Error?
    
    func loadPrediction(for match: FootballMatch) async {
        isLoading = true
        
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Generate a dummy prediction
        prediction = Prediction(
            homeWinProbability: Double.random(in: 0.1...0.8),
            drawProbability: 0.2,
            awayWinProbability: Double.random(in: 0.1...0.8),
            predictedScore: "\(Int.random(in: 0...3)) - \(Int.random(in: 0...3))",
            confidence: Int.random(in: 60...95),
            keyFactors: [
                "Recent head-to-head results",
                "Home team's current form",
                "Away team's away record",
                "Key player availability"
            ]
        )
        
        isLoading = false
    }
}
