//
//  SpeedIndicatorView.swift
//  SpeedometerSwiftUI
//
//  
import SwiftUI

public struct SpeedIndicatorView: View {
    public let labelValue: Int
    public let rect: CGRect
    public let angle: Double
    public let radius: CGFloat
    public let fontSize: CGFloat
    
    public init(labelValue: Int, rect: CGRect, angle: Double, radius: CGFloat, fontSize: CGFloat) {
        self.labelValue = labelValue
        self.rect = rect
        self.angle = angle
        self.radius = radius
        self.fontSize = fontSize
    }
    
    public var body: some View {
        Text("\(labelValue)")
            .font(.system(size: fontSize))
            .offset(
                x: Calculator.position(
                    in: rect,
                    angle: angle).x - radius,
                
                y: Calculator.position(
                    in: rect,
                    angle: angle).y - radius
            )
    }
}
