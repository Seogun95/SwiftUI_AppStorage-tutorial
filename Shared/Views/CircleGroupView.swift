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
    var body: some View {
        ZStack {
            Capsule()
                .stroke(CircleColor.opacity(CircleOpacity), lineWidth: 40)
                .frame(width: 200, height: 200, alignment: .center)
            Capsule()
                .stroke(CircleColor.opacity(CircleOpacity), lineWidth: 80)
                .frame(width: 200, height: 200, alignment: .center)
        }
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
