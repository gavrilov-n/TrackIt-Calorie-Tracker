//
//  DinnerView.swift
//  TrackIt
//
//  Created by Nikita on 20/03/2026.
//

import SwiftUI

struct DinnerView: View {
    
    @State private var serchFood: String = ""
    var dinnerItems: [FoodItem] = []
    
    var body: some View {
        NavigationStack {
            NavigationStack {
                Text("Searching for \(serchFood)")
                    .navigationTitle("Searchable example")
            }
            .searchable(text: $serchFood, prompt: "Search")
            
            List{
                ForEach(dinnerItems) { item in }
            }
            .navigationBarTitle("Dinner")
        }
    }
}

#Preview {
    DinnerView()
}

struct FoodCell: View {

    let food: FoodItem
    
    var body: some View {
       
    }
}
