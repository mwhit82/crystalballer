import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            DateSelectionView()
                .navigationTitle("Crystal Baller")
        }
    }
}

#Preview {
    ContentView()
}
