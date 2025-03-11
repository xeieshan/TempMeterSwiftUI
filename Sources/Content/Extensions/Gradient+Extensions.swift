//
//  Gradient+Extensions.swift
//


import SwiftUI

public extension Gradient {
    static let speedometerGradient = Gradient(stops: [
        Gradient.Stop(color: .crimsonRed, location: 0.0),
        Gradient.Stop(color: .crimsonRed, location: 0.25),
        Gradient.Stop(color: .forestGreen, location: 0.50),
        Gradient.Stop(color: .goldenYellow, location: 0.75),
        Gradient.Stop(color: .crimsonRed, location: 1.0)
    ])
    static let temperatureGradient = Gradient(stops: [
        Gradient.Stop(color: .boiling, location: 0.0),   // Deep Blue (0°C)
        Gradient.Stop(color: .boiling, location: 0.15),      // Light Blue (15%)
        Gradient.Stop(color: .freezing, location: 0.25),
        Gradient.Stop(color: .cold, location: 0.40),      // Soft Blue (30%)
        Gradient.Stop(color: .cool, location: 0.50),   // White (50%)
        Gradient.Stop(color: .neutral, location: 0.55),      // Light Orange (70%)
        Gradient.Stop(color: .warm, location: 0.75),       // Deep Orange (85%)
        Gradient.Stop(color: .hot, location: 1.0)    // Red (100°C)
    ])
}
