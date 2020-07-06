//
//  ConfigPopup.swift
//  HeroAnimations
//
//  Created by SwiftUI-Lab on 04-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part1
//

import SwiftUI

/// A view used on a popover. It presents a Form to change the HeroConfiguration data, to alter display and test customizations.
///
/// The popover can be presented from two places. Using the toolbar icon at the top right, or
/// if the modal is presented, by double-tapping on it.
///
struct ConfigPopover: View {
    @State private var _slowAnimations = debugAnimations
    @Binding var config: HeroConfiguration
    let isPortrait: Bool
    
    let vStackSpacing: CGFloat = 8
    let vStackPadding: CGFloat = 6
    
    var body: some View {
        
        let slowAnimations = Binding<Bool>(get: { _slowAnimations }, set: { _slowAnimations = $0; debugAnimations = $0 } )
        
        return Form {
            Section(header: Text("Thumbnail Configuration")) {
                VStack(alignment: .leading, spacing: vStackSpacing) {
                    HStack {
                        Spacer()
                        Text("Scaling \(String(format: "%2.2f", config.thumbnailScalingFactor))")
                        Spacer()
                        Text("Radius \(String(format: "%2.2f", config.thumbnailRadius))")
                        Spacer()
                    }
                    HStack {
                        Slider(value: $config.thumbnailScalingFactor, in: config.lowestFactor...config.highestFactor)
                        Slider(value: $config.thumbnailRadius, in: 0...300)
                    }
                }.padding(.vertical, vStackPadding)
                
                VStack(alignment: .leading, spacing: vStackSpacing) {
                    HStack {
                        Spacer()
                        Text("Width \(Int(self.config.thumbnailSize.width))")
                        Spacer()
                        Text("Height \(Int(self.config.thumbnailSize.height))")
                        Spacer()
                    }
                    HStack {
                        Slider(value: $config.thumbnailSize.width, in: 50...1366)
                        Slider(value: $config.thumbnailSize.height, in: 50...1366)
                    }
                }.padding(.vertical, vStackPadding)
                
                VStack(alignment: .leading, spacing: vStackSpacing) {
                    HStack {
                        Spacer()
                        Text("V Space \(Int(config.verticalSeparation))")
                        Spacer()
                        Text("H Space \(Int(config.horizontalSeparation))")
                        Spacer()
                    }
                    HStack {
                        Slider(value: $config.verticalSeparation, in: 0...200)
                        Slider(value: $config.horizontalSeparation, in: 0...200)
                    }
                }.padding(.vertical, vStackPadding)

            }

            Section(header: Text("Modal Configuration")) {
                VStack(alignment: .leading, spacing: vStackSpacing) {
                    HStack {
                        Spacer()
                        Text("Width \(Int(config.modalSize.width))")
                        Spacer()
                        Text("Height \(Int(config.modalSize.height))")
                        Spacer()
                    }
                    HStack {
                        Slider(value: $config.modalSize.width, in: 100...1366)
                        Slider(value: $config.modalSize.height, in: 100...1366)
                    }
                }.padding(.vertical, vStackPadding)
                
                VStack(alignment: .leading, spacing: vStackSpacing) {
                    HStack {
                        Spacer()
                        Text("Image Height \(Int(config.modalImageHeight))")
                        Spacer()
                        Text("Modal Radius \(Int(config.modalRadius))")
                        Spacer()
                    }
                    HStack {
                        Slider(value: $config.modalImageHeight, in: 100...800)
                        Slider(value: $config.modalRadius, in: 0...600)
                    }

                }
            }
            
            Section(header: Text("Other")) {
                Toggle("Dark Mode", isOn: self.$config.darkMode)
                
                Toggle("Slow Animations", isOn: slowAnimations)

                HStack {
                    Spacer()
                    Button("Reset to Defaults") {
                        withAnimation(.resetConfig) {
                            self.config = isPortrait ? HeroConfiguration.defaultPortrait : HeroConfiguration.defaultLandscape
                        }
                    }
                    Spacer()
                }.padding(.vertical, vStackPadding)
            }
            

        }.frame(width: 400, height: 700)//.font(.caption)
    }
}
