import Foundation

enum APIError: Error {
    case invalidURL
    case networkError
    case decodingError
}

class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    func fetchMatches(date: Date) async throws -> [Match] {
        // TODO: Implement API calls
        return []
    }
    
    func fetchPrediction(for match: Match) async throws -> Prediction {
        // TODO: Implement prediction API
        return Prediction(
            homeWinProbability: 0.5,
            drawProbability: 0.25,
            awayWinProbability: 0.25,
            predictedScore: "2-1",
            confidence: 75,
            keyFactors: ["Recent form", "Head-to-head record"]
        )
    }
}
