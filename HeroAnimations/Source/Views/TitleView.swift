//
//  TitleView.swift
//  HeroAnimations
//
//  Created by SwiftUI-Lab on 04-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part1
//

import SwiftUI

/// A view used to display the title of the item, with a semi-transparent gradient as the background to improve text readability
struct TitleView: View {
    let item: ItemData
    let scale: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(item.tagLine)
                .font(.callout)
            
            Text(item.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
        }
        .padding(30)
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .leading, endPoint: .trailing)
        )
        .foregroundColor(.white)
        .scaleEffect(scale, anchor: .topLeading)
    }
}
