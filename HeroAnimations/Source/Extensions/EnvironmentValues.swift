//
//  EnvironmentValues.swift
//  HeroAnimations
//
//  Created by SwiftUI-Lab on 04-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part1
//

import SwiftUI

extension EnvironmentValues {
    var heroConfig: HeroConfiguration {
        get { return self[HeroConfigKey.self] }
        set { self[HeroConfigKey.self] = newValue }
    }

    var modalTransitionPercent: CGFloat {
        get { return self[ModalTransitionKey.self] }
        set { self[ModalTransitionKey.self] = newValue }
    }
}

public struct HeroConfigKey: EnvironmentKey {
    public static let defaultValue: HeroConfiguration = .default
}

public struct ModalTransitionKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 0
}
