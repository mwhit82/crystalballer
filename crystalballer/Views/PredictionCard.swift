import SwiftUI

struct PredictionCard: View {
    let prediction: Prediction?
    
    var body: some View {
        VStack(spacing: 16) {
            if let prediction = prediction {
                // Win probabilities
                HStack {
                    ProbabilityBar(label: "Home Win", probability: prediction.homeWinProbability)
                    ProbabilityBar(label: "Draw", probability: prediction.drawProbability)
                    ProbabilityBar(label: "Away Win", probability: prediction.awayWinProbability)
                }
                .padding()
                
                // Predicted score
                Text("Predicted Score: \(prediction.predictedScore)")
                    .font(.title3)
                
                // Confidence
                Text("Confidence: \(prediction.confidence)%")
                    .foregroundColor(.secondary)
                
                // Key factors
                VStack(alignment: .leading, spacing: 8) {
                    Text("Key Factors:")
                        .font(.headline)
                    ForEach(prediction.keyFactors, id: \.self) { factor in
                        Text("• \(factor)")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct ProbabilityBar: View {
    let label: String
    let probability: Double
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: 30, height: 100)
                    .foregroundColor(.gray.opacity(0.2))
                
                Rectangle()
                    .frame(width: 30, height: 100 * probability)
                    .foregroundColor(.blue)
            }
            .cornerRadius(8)
            
            Text(label)
                .font(.caption)
                .multilineTextAlignment(.center)
            
            Text("\(Int(probability * 100))%")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    PredictionCard(prediction: Prediction(
        homeWinProbability: 0.6,
        drawProbability: 0.25,
        awayWinProbability: 0.15,
        predictedScore: "2-1",
        confidence: 75,
        keyFactors: ["Recent form", "Head-to-head record"]
    ))
    .padding()
}
