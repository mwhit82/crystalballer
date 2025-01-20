import Foundation
import SwiftUI

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case noData
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Data decoding error: \(error.localizedDescription)"
        case .noData:
            return "No data received"
        }
    }
}

// Renamed to FootballMatch to avoid ambiguity
struct FootballMatch: Identifiable, Hashable {
    let id: String
    let homeTeam: String
    let awayTeam: String
    let kickoffTime: String
    let date: Date
    let competition: String
    let venue: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FootballMatch, rhs: FootballMatch) -> Bool {
        lhs.id == rhs.id
    }
}

class APIClient {
    static let shared = APIClient()
    
    private func generateSeasonFixtures() -> [(date: String, matches: [FootballMatch])] {
        var allFixtures: [(date: String, matches: [FootballMatch])] = []
        
        // Updated teams for 2024-25 season (with promoted teams)
        let teams = [
            "Arsenal", "Aston Villa", "Bournemouth", "Brentford",
            "Brighton", "Chelsea", "Crystal Palace", "Everton",
            "Fulham", "Liverpool", "Manchester City", "Manchester United",
            "Newcastle", "Nottingham Forest", "Sheffield United", "Tottenham",
            "West Ham", "Wolves", "Leicester City", "Leeds United"
        ]
        
        let venues = [
            "Emirates Stadium", "Villa Park", "Vitality Stadium", "Gtech Community Stadium",
            "Amex Stadium", "Stamford Bridge", "Selhurst Park", "Goodison Park",
            "Craven Cottage", "Anfield", "Etihad Stadium", "Old Trafford",
            "St James' Park", "City Ground", "Bramall Lane", "Tottenham Hotspur Stadium",
            "London Stadium", "Molineux", "King Power Stadium", "Elland Road"
        ]
        
        let startDate = "2024-08-17"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let currentDate = dateFormatter.date(from: startDate) else { return [] }
        let calendar = Calendar.current
        
        for week in 0..<38 {
            // Saturday matches
            if let saturdayDate = calendar.date(byAdding: .day, value: week * 7, to: currentDate) {
                let dateString = dateFormatter.string(from: saturdayDate)
                var saturdayMatches: [FootballMatch] = []
                
                for i in 0..<3 {
                    let homeTeam = teams[i * 2]
                    let awayTeam = teams[i * 2 + 1]
                    let venue = venues[i * 2]
                    
                    saturdayMatches.append(FootballMatch(
                        id: "\(dateString)-\(i)",
                        homeTeam: homeTeam,
                        awayTeam: awayTeam,
                        kickoffTime: ["12:30", "15:00", "17:30"][i],
                        date: saturdayDate,
                        competition: "Premier League",
                        venue: venue
                    ))
                }
                
                print("📅 Generated matches for Saturday: \(dateString)")
                allFixtures.append((date: dateString, matches: saturdayMatches))
            }
            
            // Sunday matches
            if let sundayDate = calendar.date(byAdding: .day, value: week * 7 + 1, to: currentDate) {
                let dateString = dateFormatter.string(from: sundayDate)
                var sundayMatches: [FootballMatch] = []
                
                for i in 0..<2 {
                    let homeTeam = teams[(i + 6) * 2]
                    let awayTeam = teams[(i + 6) * 2 + 1]
                    let venue = venues[(i + 6) * 2]
                    
                    sundayMatches.append(FootballMatch(
                        id: "\(dateString)-\(i)",
                        homeTeam: homeTeam,
                        awayTeam: awayTeam,
                        kickoffTime: ["14:00", "16:30"][i],
                        date: sundayDate,
                        competition: "Premier League",
                        venue: venue
                    ))
                }
                
                print("📅 Generated matches for Sunday: \(dateString)")
                allFixtures.append((date: dateString, matches: sundayMatches))
            }
        }
        
        return allFixtures
    }
    
    func fetchFixtures(for targetDate: Date) async throws -> [FootballMatch] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let targetDateString = dateFormatter.string(from: targetDate)
        print("🔍 Fetching fixtures for: \(targetDateString)")
        
        let allFixtures = generateSeasonFixtures()
        
        if let matchDay = allFixtures.first(where: { $0.date == targetDateString }) {
            print("✅ Found \(matchDay.matches.count) matches for \(targetDateString)")
            matchDay.matches.forEach { match in
                print("   • \(match.homeTeam) vs \(match.awayTeam) at \(match.kickoffTime)")
            }
            return matchDay.matches
        }
        
        print("⚠️ No matches found for \(targetDateString)")
        return []
    }
}
