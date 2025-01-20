import SwiftUI

struct PredictionCard: View {
    let prediction: Prediction
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Match Prediction")
                .font(.headline)
            
            // Predicted Score
            VStack(spacing: 8) {
                Text("Predicted Score")
                    .font(.subheadline)
                Text(prediction.predictedScore)
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            // Win Probabilities
            HStack(spacing: 20) {
                ProbabilityView(label: "Home Win", probability: prediction.homeWinProbability)
                ProbabilityView(label: "Draw", probability: prediction.drawProbability)
                ProbabilityView(label: "Away Win", probability: prediction.awayWinProbability)
            }
            
            // Confidence Level
            VStack(spacing: 4) {
                Text("Confidence Level")
                    .font(.subheadline)
                Text("\(prediction.confidence)%")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            // Key Factors
            VStack(alignment: .leading, spacing: 8) {
                Text("Key Factors")
                    .font(.subheadline)
                
                ForEach(prediction.keyFactors, id: \.self) { factor in
                    HStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                        Text(factor)
                            .font(.caption)
                    }
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

private struct ProbabilityView: View {
    let label: String
    let probability: Double
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            Text("\(Int(probability * 100))%")
                .font(.headline)
        }
    }
}
