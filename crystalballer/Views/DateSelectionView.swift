import SwiftUI
import Foundation
import Combine

@MainActor
struct DateSelectionView: View {
    @State private var selectedDate = Date()
    @StateObject private var viewModel = MatchViewModel()
    @State private var isCalendarExpanded = false
    
    var body: some View {
        VStack(spacing: 16) {
            // Collapsible Calendar Section
            VStack {
                HStack {
                    Text(selectedDate.formatted(date: .long, time: .omitted))
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            isCalendarExpanded.toggle()
                        }
                    }) {
                        Image(systemName: isCalendarExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                
                if isCalendarExpanded {
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .padding()
                }
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
            .padding()
            
            // Matches List Section
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                if let matches = viewModel.matches, !matches.isEmpty {
                    MatchList(matches: matches)
                } else {
                    Text("No matches scheduled for this date")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            
            Spacer()
        }
        .navigationTitle("Fixtures")
        .onChange(of: selectedDate) { oldValue, newValue in
            Task {
                await viewModel.fetchMatches(for: newValue)
            }
        }
        .task {
            await viewModel.fetchMatches(for: selectedDate)
        }
    }
}

struct DateSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DateSelectionView()
        }
    }
}
