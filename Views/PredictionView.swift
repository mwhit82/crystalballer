import SwiftUI

struct PredictionView: View {
    let match: Match
    @StateObject private var viewModel = PredictionViewModel()
    
    var body: some View {
        VStack {
            Text("\(match.homeTeam) vs \(match.awayTeam)")
                .font(.title2)
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                PredictionCard(prediction: viewModel.prediction)
            }
        }
        .task {
            await viewModel.getPrediction(for: match)
        }
    }
}
