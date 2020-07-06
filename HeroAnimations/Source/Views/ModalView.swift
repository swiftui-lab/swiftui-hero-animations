//
//  ModalView.swift
//  HeroAnimations
//
//  Created by SwiftUI-Lab on 04-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part1
//

import SwiftUI
import Combine

/// A view used as a modal. It reacts to the environment key .modalTransitionPercent,
/// in order to determine how much flight it has done. This allows it to morph
/// from the thumbnail picture into its full display.
struct ModalView: View {
    
    // .modalTransitionPercent goes from 0 to 1 when flying in, and from 1 to 0 when flying out.
    @Environment(\.modalTransitionPercent) var pct: CGFloat
    @Environment(\.heroConfig) var config: HeroConfiguration
    
    let item: ItemData
    var onCloseTap: () -> Void
    var onDoubleTap: (() -> Void)? = nil
    let scrollUp: PassthroughSubject<Void, Never>
    
    var body: some View {
        
        // Cropped image size
        let imgH = config.modalImageHeight
        let imgW = config.modalSize.width
        
        // How much height is left for the text area
        let textH = config.modalSize.height - imgH
        
        // Image cropping is done to scale the image to this factor
        let scaleFactor: CGFloat = 1.0

        // Size difference between the modal's image and the thumbnail
        let d = CGSize(width: (imgW - config.thumbnailSize.width), height: (imgH - config.thumbnailSize.height))

        // Interpolate values from thumbnail size, to full modal size, using the pct value from the flight transition
        let w = config.thumbnailSize.width + d.width * pct
        let h = config.thumbnailSize.height + d.height * pct
        let s = 0.75 + 0.25 * pct
        let f = scaleFactor + (config.thumbnailScalingFactor - scaleFactor) * (1 - pct)
        let r = (config.thumbnailRadius - config.modalRadius) * (1 - pct) + config.modalRadius
        
        return Color.clear.overlay(
            ScrollView(.vertical) {
                ScrollViewReader { reader in
                    VStack(spacing: 0) {
                        Image("\(item.id)").resizable().aspectRatio(contentMode: .fill)
                            .frame(width: (w * f))
                            .frame(width: w, height: h)
                            .clipped()
                            .overlay(CloseButton(onTap: onCloseTap).opacity(Double(pct)), alignment: .topTrailing)
                            .zIndex(2)
                        
                        SlideText(textWidth: config.modalSize.width, backgroundWidth: max(config.modalSize.width, config.thumbnailSize.width))
                            .frame(maxHeight: .infinity)
                            .clipped()
                            .zIndex(1)
                        
                    }
                    .id(1)
                    .onReceive(scrollUp, perform: {
                        withAnimation(.hero) {
                            reader.scrollTo(1, anchor: .top)
                        }
                    })
                }
            }
        )
        .overlay(TitleView(item: item, scale: s), alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: r))
        .contentShape(RoundedRectangle(cornerRadius: r))
        .frame(width: w, height: h + textH * pct)
        .onTapGesture(count: 2, perform: onDoubleTap ?? { })
        .shadow(radius: 8 * pct)
        
    }
    
    struct CloseButton: View {
        var onTap: () -> Void
        
        var body: some View {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundColor(.white)
                .padding(30)
                .onTapGesture(perform: onTap)
        }
    }
    
    struct SlideText: View {
        let textWidth: CGFloat
        let backgroundWidth: CGFloat
        
        let horizontalPadding: CGFloat = 20
        let verticalPadding: CGFloat = 20
        
        var body: some View {
            VStack {
                Text(loremIpsum)
                    .font(.title3)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .frame(idealWidth: textWidth - 2 * horizontalPadding)
                    .fixedSize()
                    .padding(.vertical, verticalPadding)
            }
            .padding(.horizontal, horizontalPadding)
            .frame(width: backgroundWidth)
            .background(Color(UIColor.secondarySystemBackground))
        }
    }
}
