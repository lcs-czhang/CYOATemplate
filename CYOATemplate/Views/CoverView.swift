//
//  CoverView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2024-06-02.
//

import SwiftUI

struct CoverView: View {
    
    // MARK: Stored properties
    
    // Access the book state through the environment
    @Environment(BookStore.self) var book
    
    // MARK: Computed properties
    var body: some View {
        VStack {
            
            if book.isNotReadyToRead {
                
                ProgressView()
                
            } else {
                ZStack{
                    Image("cocoon")
                    VStack{
                        // Show the cover
                        Text("The Cocoon")
                            .font(.largeTitle)
                            .background(Color.white)
                        
                        Button {
                            // Animate page changes (fade)
                            withAnimation {
                                book.beginReading()
                            }
                        } label: {
                            Text("Begin reading")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
            }
            
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    CoverView()
}
