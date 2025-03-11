//
//  SpeedometerShape.swift
// 

import SwiftUI

public struct SpeedometerShapeConfiguration: Sendable {
    public let angle: Double
    public let length: CGFloat
    
    public init(angle: Double, length: CGFloat) {
        self.angle = angle
        self.length = length
    }
}

public struct SpeedometerShape: Shape {
    public let configurations: [SpeedometerShapeConfiguration]
    
    public init(configurations: [SpeedometerShapeConfiguration]) {
        self.configurations = configurations
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let centerX = rect.midX
        let centerY = rect.midY
        
        ///X^2 + Y^2 = R^2
        for config in configurations {
            let targetPosition = Calculator.position(in: rect, angle: config.angle)
            let dx = (centerX - targetPosition.x)
            let dy = (centerY - targetPosition.y)
            let distance = sqrt(dx * dx + dy * dy)
            
            let scale = config.length / distance
            let endPoint = CGPoint(x: targetPosition.x + dx * scale, y: targetPosition.y + dy * scale)
            
            path.move(to: targetPosition)
            path.addLine(to: endPoint)
        }
        
        return path
    }
}
