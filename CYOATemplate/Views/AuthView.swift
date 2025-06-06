//
//  AuthView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2024-06-02.
//

import Supabase
import SwiftUI

struct AuthView: View {

    // Keeps track of what happened when we tried to authenticate with Supabase
    @State var result: Result<Void, Error>?
    
    var body: some View {
        
        VStack {
            
            // Show a "spinner" indicator while authentication occurs
            ProgressView()

            // Based on what happened during authentication, show an appropriate
            // message
            // NOTE: Unlikely this will ever be seen by the user, since a successful
            //       anonymous sign-in will trigger AppEntryView to reload and direct
            //       us to the main view of our app
            if let result {
                switch result {
                case .success:
                    Text("Ready!")
                case .failure(let error):
                    Text(error.localizedDescription).foregroundStyle(.red)
                }
            }
            
        }
        .task {
            do {
                
                // Try to restore an existing session rather than create a new one
                let _ = try await supabase.auth.user()
                result = .success(())
                
                // NOTE: It's important to restore an existing session if it exists,
                //       so that we can see data we previously created.
                //
                // NOTE: Sessions last indefinitely by default.
                // https://supabase.com/docs/guides/auth/sessions
                
            } catch AuthError.sessionMissing {
                
                // No session was found when we tried to restore a session.
                // So, we need to sign out (to avoid edge case issues),
                // then sign in anonymously for the first time.
                do {

                    try await supabase.auth.signOut()

                    try await supabase.auth.signInAnonymously()
                    
                } catch {
                    
                    // Report any error encountered when signing in
                    result = .failure(error)
                    
                }
                
            } catch {
                
                // Report any error encountered when trying to find an existing session
                result = .failure(error)
                
            }
        }
    }
    
}

#Preview {
    AuthView()
}
