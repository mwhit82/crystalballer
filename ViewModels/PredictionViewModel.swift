import Foundation

@MainActor
class PredictionViewModel: ObservableObject {
    @Published var prediction: Prediction?
    @Published var isLoading = false
    @Published var error: String?
    
    func getPrediction(for match: Match) async {
        isLoading = true
        // TODO: Implement prediction logic
        isLoading = false
    }
}
