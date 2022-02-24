//
//  ContentView.swift
//  Shared
//
//  Created by Seogun Kim on 2022/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("Onboarding") var isOnboardingActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
