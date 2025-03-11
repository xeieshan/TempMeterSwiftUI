//
//  ArcShape.swift
//  
//


import SwiftUI

///A simple reusable arc
public struct ArcShape: Shape {
    public let startAngle: Angle
    public let endAngle: Angle
    public let clockwise: Bool
    
    public init(startAngle: Angle, endAngle: Angle, clockwise: Bool) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.clockwise = clockwise
    }
    
    public func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 2.0
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: clockwise
            )
        }
    }
}
