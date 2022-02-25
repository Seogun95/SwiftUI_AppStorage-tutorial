//
//  OnboardingView.swift
//  SwiftUI_AppStorage
//
//  Created by Seogun Kim on 2022/02/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("Onboarding") var isOnboardingActive: Bool = true
    //실제 화면 넓이의 - 80 : 왼쪽 오른쪽에 각각 40 포인트씩 패딩이 생김
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0 // CGFloat이 0과 같으면 이 속성은 가로 방향을 의미함
    
    var body: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 0) {
                //MARK: HEADER
                Spacer()
                
                VStack(spacing: 0) {
                    Text("SWIFTUI")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("""
                    SwiftUI에 대해 알아보도록 합시다.
                    이것은 아주 쉬운 튜토리얼 입니다.
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                    
                }//: HEADER
                
                //MARK: CENTER
                ZStack {
                    CircleGroupView(CircleColor: .white, CircleOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                    
                }//: CENTER
                
                Spacer()
                
                //MARK: FOOTER
                ZStack {
                    // 커스텀 버튼
                    
                    //1. background
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    //2. 액션
                    Text("시작하기")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    //3. 캡슐 - 다이나믹 넓이
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    //4. 드래그 버튼
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 20, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    
                                    if buttonOffset > buttonWidth / 2 {
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingActive = false
                                    } else {
                                        buttonOffset = 0
                                    }
                                }
                        )//:GESTURE
                        Spacer()
                    }//:HStack
                    
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
            }//:VSTACK
        }//: ZSTACK
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
