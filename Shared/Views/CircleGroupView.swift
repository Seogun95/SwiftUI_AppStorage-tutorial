//
//  CircleGroupView.swift
//  SwiftUI_AppStorage
//
//  Created by Seogun Kim on 2022/02/24.
//

import SwiftUI

struct CircleGroupView: View {
    @State var CircleColor: Color
    @State var CircleOpacity: Double
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Capsule()
                .stroke(CircleColor.opacity(CircleOpacity), lineWidth: 40)
                .frame(width: 200, height: 200, alignment: .center)
            Capsule()
                .stroke(CircleColor.opacity(CircleOpacity), lineWidth: 80)
                .frame(width: 200, height: 200, alignment: .center)
        }
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
    }
}
struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all)
            CircleGroupView(CircleColor:.white, CircleOpacity: 0.2)
        }
    }
}
