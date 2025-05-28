//
//  StatsView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2024-06-02.
//

import SwiftUI

struct StatsView: View {
    
    // MARK: Stored properties
    @Environment(BookStore.self) var book
    // Whether this view is showing in the sheet right now
    @Binding var showing: Bool
    let viewModel: PageViewModel

    // MARK: Computed properties
    var body: some View {
        NavigationStack {
            VStack {
                Text("A total of \(book.numberOfPageRead) pages out of 32 pages overall have been visited in this story.")
                if(book.numberOfEndingRead == 8) {
                    Text("You've visited all 8 endings!")
                } else {
                    Text("You've visited \(book.numberOfEndingRead) endings, there are more to discover.")
                }
            }
            .padding()
            .navigationTitle("Statistics")
            // Toolbar to show buttons for various actions
            .toolbar {
                
                // Hide this view
                ToolbarItem(placement: .automatic) {
                    Button {
                        showing = false
                    } label: {
                        Text("Done")
                            .bold()
                    }

                }
            }
        }
    }
    
}

#Preview {
    StatsView(showing: Binding.constant(true), viewModel: PageViewModel(book: BookStore()))
}
