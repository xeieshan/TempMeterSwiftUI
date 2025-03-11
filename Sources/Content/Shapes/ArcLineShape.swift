//
//  ArcLineShape.swift
//

import SwiftUI

///Draws a line from rect.midX , rect.midY to angle calculated position .
public struct ArcLineShape: Shape {
    public var animatableData: Double
    
    public init(animatableData: Double) {
        self.animatableData = animatableData
    }
    
    public func path(in rect: CGRect) -> Path {
        let targetPosition = Calculator.position(in: rect, angle: animatableData)
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addLine(to: targetPosition)
        }
    }
}

