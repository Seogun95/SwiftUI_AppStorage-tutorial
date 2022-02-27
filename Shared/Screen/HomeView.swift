//
//  HomeView.swift
//  SwiftUI_AppStorage
//
//  Created by Seogun Kim on 2022/02/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("Onboarding") var isOnboardingActive: Bool = false
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            //MARK: - HEADER
            ZStack {
                CircleGroupView(CircleColor: Color("ColorRed"), CircleOpacity: 0.2)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35: -35)
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .repeatForever(), value: isAnimating)
            }
            //MARK: - CENTER
            Text("이곳은 HomeView 입니다. 아래로만 쌓아줄것이기 때문에 VStack만 사용합니다.")
                .font(.title3)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            Spacer()
            
            Button(action: {
                withAnimation {
                    playSound(sound: "success", type: "m4a")
                    isOnboardingActive = true
                    
                }
            }) {
                Image(systemName: "house.circle.fill")
                    .imageScale(.medium)
                Text("시작하기")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.regular)
            .foregroundColor(.white)
            //MARK: - FOOTER
        }//: VStack
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

