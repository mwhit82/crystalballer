import SwiftUI

struct MatchList: View {
    let matches: [Match]
    
    var body: some View {
        List(matches) { match in
            NavigationLink(destination: PredictionView(match: match)) {
                MatchRow(match: match)
            }
        }
    }
}

struct MatchRow: View {
    let match: Match
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(match.homeTeam)
                    .font(.headline)
                Text(match.awayTeam)
                    .font(.headline)
            }
            Spacer()
            Text(match.kickoffTime)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}
