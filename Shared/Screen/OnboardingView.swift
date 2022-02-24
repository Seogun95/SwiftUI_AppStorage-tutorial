//
//  OnboardingView.swift
//  SwiftUI_AppStorage
//
//  Created by Seogun Kim on 2022/02/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("Onboarding") var isOnboardingActive: Bool = true
    var body: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all)
            VStack {
                Spacer()
                //MARK: - HEADER
                VStack(spacing: 0) {
                    Text("SwiftUI 시작")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    
                    Text("""
                    AppStoreage를 사용하여
                    뷰 생성하는 방법에 대해
                    알아보도록 합시다.
                    """)
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                } //:Header
                
                //MARK: - CENTER
                ZStack {
                    ZStack {
                        Capsule()
                            .stroke(.white.opacity(0.2), lineWidth: 40)
                            .frame(width: 200, height: 200, alignment: .center)
                        Capsule()
                            .stroke(.white.opacity(0.2), lineWidth: 80)
                            .frame(width: 200, height: 200, alignment: .center)
                        
                        Image("character-1")
                            .resizable()
                            .scaledToFit()
                    }
                } //: Center
                Spacer()
                //MARK: - FOOTER
                ZStack {
                    Capsule()
                        .fill(Color(.white).opacity(0.2))
                    Capsule()
                        .fill(Color(.white).opacity(0.2))
                        .padding(8)
                    
                    HStack {
                        Circle()
                            .fill(Color("ColorRed"))
                            .frame(width: 80)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("시작하기")
                            .font(.title2)
                            .foregroundColor(.white)
                            .offset(x: 20)
                    }
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("colorRed"))
                            Circle()
                                .fill(Color(.black).opacity(0.2))
                                .padding(10)
                            Image(systemName: "house.circle")
                                .font(.system(size: 25).weight(.bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .onTapGesture {
                            isOnboardingActive = false
                        }
                        Spacer()
                    }
                }
                .frame(height: 80)
                .padding()
                
                
            }//: VStack
        } //: ZStack
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
