import SwiftUI
import Foundation

struct MatchList: View {
    let matches: [FootballMatch]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(matches) { match in
                    NavigationLink(destination: PredictionView(match: match)) {
                        MatchRow(match: match)
                    }
                }
            }
            .padding()
        }
    }
}

struct MatchRow: View {
    let match: FootballMatch
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text(match.homeTeam)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(match.awayTeam)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(match.kickoffTime)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(match.venue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct MatchList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let sampleMatch = FootballMatch(
                id: "1",
                homeTeam: "Arsenal",
                awayTeam: "Chelsea",
                kickoffTime: "15:00",
                date: Date(),
                competition: "Premier League",
                venue: "Emirates Stadium"
            )
            
            MatchList(matches: [sampleMatch])
                .padding()
        }
    }
}
