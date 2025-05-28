//
//  PageViewModel.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2024-06-03.
//

import Foundation

@Observable
class PageViewModel: Observable {
    
    // Details of the current page being read
    var page: Page?
    
    init(book: BookStore) {
        
        // Load the details of the current page from the database
        Task {
                self.page = try await book.getCurrentPage()
        }
    }
    
}
