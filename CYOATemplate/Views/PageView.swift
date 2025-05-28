//
//  PageView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-06-01.
//

import SwiftUI

struct PageView: View {
    
    // MARK: Stored properties
    
    // Access the book state through the environment
    @Environment(BookStore.self) var book
    
    // The view model for the page view
    //
    // Making the view model a constant means
    // when the page number changes in the BookStore class
    // (which is fed to the initializer of PageViewModel)
    // then PageView will be re-loaded, updating the text
    let viewModel: PageViewModel
    
    // MARK: Computed properties
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                // Has the page loaded yet?
                if let page = viewModel.page {
                    
                    // DEBUG
                    let _ = print("Text for this page is:\n\n\(page.narrative)\n\n")
                    let _ = print("Image for this page is:\n\n\(page.image ?? "(no image for this page)")\n\n")
                    
                    Text(
                        try! AttributedString(
                            markdown: page.narrative,
                            options: AttributedString.MarkdownParsingOptions(
                                interpretedSyntax: .inlineOnlyPreservingWhitespace
                            )
                        )
                    )
                    .font(.title2)
                    
                    Divider()
                    
                    if page.isAnEndingOfTheStory {
                        
                        // Page is an ending, so tell the user,
                        // and allow book to be re-started
                        Text("The End")
                            .bold()
                            .onTapGesture {
                                book.showCoverPage()
                            }
                        
                    } else {
                        
                        // Page is not an ending, so show available edges
                        EdgesView(
                            viewModel: EdgesViewModel(book: book), pageViewModel: PageViewModel(book: book)
                        )
                        
                    }
                    
                    
                    Spacer()
                    
                } else {
                    
                    // Page still loading from database
                    ProgressView()
                }
                
            }
            .padding()
        }
        
    }
}
//#Preview {
//    PageView(
//        viewModel: PageViewModel(book: BookStore())
//    )
//}
