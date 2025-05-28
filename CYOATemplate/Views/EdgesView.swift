//
//  EdgesView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-06-01.
//

import SwiftUI

struct EdgesView: View {

    // MARK: Stored properties

    // Access the book state through the environment
    @Environment(BookStore.self) var book
    
    // The view model for the page view
    //
    // Making the view model a constant means
    // when the page number changes in the BookStore class
    // (which is fed to the initializer of EdgesViewModel)
    // then EdgesView will be re-loaded, updating the text
    let viewModel: EdgesViewModel
    let pageViewModel: PageViewModel

    // MARK: Computed properties
    var body: some View {
        
        VStack(spacing: 20) {
            
            // Have edges loaded yet?
            if let edges = viewModel.edges {

                // Are there no edges for this page?
                // NOTE: This should not happen if database is populated correctly.
                if edges.isEmpty {
                    
                    HStack {
                        Spacer()
                        
                        Text("No edges found for page \(book.currentPageId!).")
                            .onTapGesture {
                                book.showCoverPage()
                            }
                    }

                } else {
                    
                    // Show the edges for this page
                    ForEach(edges) { edge in
                        HStack {
                            Spacer()
                            Text(
                                try! AttributedString(
                                    markdown: edge.prompt,
                                    options: AttributedString.MarkdownParsingOptions(
                                        interpretedSyntax: .inlineOnlyPreservingWhitespace
                                    )
                                )
                            )
                                .multilineTextAlignment(.trailing)
                        }
                        .onTapGesture {
                            totalPagesRead.numberOfPageRead += 1
                            print("\(totalPagesRead.numberOfPageRead)")
//                            if (pageViewModel.page?.ifRead != false){
//                                pageViewModel.page?.ifRead.toggle()
//                                if (pageViewModel.page!.isAnEndingOfTheStory) {
//                                    
//                                }
//                                pageViewModel.addPage()
//                            }
                            // DEBUG
                            print("Current page number is: \(book.currentPageId!)")
                            print("==== about to change page ====")
                            
                            book.read(edge.toPage)
                            
                            // DEBUG
                            print("==== changed page ====")
                            print("New page number is: \(book.currentPageId!)")
                        }
                    }
                }

            } else {
                
                // Edges are loading from database
                ProgressView()
            }
                
        }


    }
}

#Preview {
    EdgesView(
        viewModel: EdgesViewModel(book: BookStore()), pageViewModel: PageViewModel(book: BookStore())
    )
}
