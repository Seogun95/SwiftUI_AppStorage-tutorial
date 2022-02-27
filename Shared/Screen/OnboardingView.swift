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
    @State private var isAnimating: Bool = false
    //CGSize(width: 0, height: 0) 는 .zero 로 표시할 수 있음
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "SwiftUI"
    
    var body: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                //MARK: HEADER
                Spacer()
                
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .transition(.opacity)
                    //더 이상 동일한 뷰(textTitle)가 아님을 알리기 위한 identifiable 지정
                        .id(textTitle)
                    
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
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                //animation value는 iOS 15 이상에서 필수로 적어줘야 함
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: CENTER
                //Horizontal Parallax Effect
                ZStack {
                    CircleGroupView(CircleColor: .white, CircleOpacity: 0.2)
                        .offset(x: imageOffset.width * -1.2, y: 0) //image와 반대로 가게 하기 위해 음수값 사용
                        .blur(radius: abs(imageOffset.width / 10))
                        //블러 효과에 음수값을 제공하는것은 의미가 없음.
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    //abs : 주어진 숫자의 절대값을 반환한다
                                    //즉, 왼쪽으로 드래그하면 이 값이 음수 값으로 이동
                                    //여기서 조건은 양쪽 150 포인트 까지만 기동 가능함
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        //시작부터 현재까지의 전체 움직임에 대한 정보를 줌
                                        
                                        //드래그 할때마다 투명도 조절
                                        withAnimation(Animation.linear(duration: 0.2)) {
                                            indicatorOpacity = 0
                                            textTitle = "서근개발노트"
                                        }
                                    }
                                }
                            
                                .onEnded { _ in
                                    imageOffset = .zero
                                    withAnimation(Animation.linear(duration: 0.2)) {
                                        indicatorOpacity = 1
                                        textTitle = "SwiftUI"
                                    }
                                }
                        ) //:gesture
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                }//: CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 40, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity) //드래그 할때마다 투명도 조절
                    , alignment: .bottom //아래로 요소를 지정함
                 )
                
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
                                    
                                    withAnimation(Animation.easeOut(duration: 0.5)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingActive = false
                                        } else {
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )//:GESTURE
                        Spacer()
                    }//:HStack
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 60)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }//:VSTACK
        }//: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
