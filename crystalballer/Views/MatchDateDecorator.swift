import SwiftUI

struct MatchDateDecorator: ViewModifier {
    let hasMatch: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .fill(Color.blue)
                    .frame(width: 6, height: 6)
                    .opacity(hasMatch ? 1 : 0)
                    .offset(y: 14)
            )
    }
}

extension View {
    func matchDateDecorator(hasMatch: Bool) -> some View {
        modifier(MatchDateDecorator(hasMatch: hasMatch))
    }
}
