import SwiftUI
import SwiftData

struct TrackItMainView: View {
    
    @State private var isShowingItemSheet: Bool = false
    
    // 1. The Librarian (Context) to save new data
    @Environment(\.modelContext) private var context
    
    // 2. The spotlight (@Query) to fetch and watch data
    @Query(sort: \Day.date, order: .reverse) private var days: [Day]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                NavigationLink("Breakfast") {
                    BreakfastView()
                }
                NavigationLink("Lunch") {
                    LunchView()
                }
                NavigationLink("Dinner") {
                    DinnerView()
                }
                NavigationLink("Snacks") {
                    SnackView()
                }
            }
            .navigationTitle("welcome, \(Date.now.formatted(date: .abbreviated, time: .omitted))")
        }
    }
}

#Preview {
    TrackItMainView()
}
