import SwiftUI

struct DateSelectionView: View {
    @State private var selectedDate = Date()
    @StateObject private var viewModel = MatchViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.matches.isEmpty {
                ContentUnavailableView(
                    "No Matches",
                    systemImage: "sportscourt",
                    description: Text("No matches scheduled for this date")
                )
            } else {
                MatchList(matches: viewModel.matches)
            }
        }
        .onChange(of: selectedDate) { newDate in
            Task {
                await viewModel.fetchMatches(for: newDate)
            }
        }
    }
}

#Preview {
    DateSelectionView()
}
