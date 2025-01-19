import Foundation

struct Prediction: Codable {
    let homeWinProbability: Double
    let drawProbability: Double
    let awayWinProbability: Double
    let predictedScore: String
    let confidence: Int
    let keyFactors: [String]
}
