import SwiftUI
import Foundation
import Combine

struct PredictionView: View {
    let match: FootballMatch
    @StateObject private var viewModel = PredictionViewModel()
    
    var body: some View {
        VStack {
            // Match details header
            VStack(spacing: 8) {
                Text("\(match.homeTeam) vs \(match.awayTeam)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(match.venue)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Kickoff: \(match.kickoffTime)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else if let prediction = viewModel.prediction {
                VStack(spacing: 16) {
                    PredictionCard(prediction: prediction)
                }
                .padding()
            } else {
                Text("No prediction available")
                    .foregroundColor(.secondary)
                    .padding()
            }
            
            Spacer()
        }
        .navigationTitle("Match Prediction")
        .task {
            await viewModel.loadPrediction(for: match)
        }
    }
}
