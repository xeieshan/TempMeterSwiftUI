//
//  TemperatureGaugeView.swift
//  



import SwiftUI

public struct TemperatureGaugeView: View {
    public var animationDuration: TimeInterval
    public var progress: CGFloat
    public var numberOfSegments: Int
    public var step: Int
    public var fontSize: CGFloat
    public var unit: String
    public var temperatureMin: CGFloat
    public var temperatureMax: CGFloat
    @Binding private var meterAngle: Double
    @Binding private var indicatorsConfigurations: [IndicatorViewConfiguration] = []
    @Binding public var temperature: CGFloat
    @Binding public init(animationDuration: TimeInterval, progress: CGFloat = 0.0, numberOfSegments: Int = 100, step: Int = 10, fontSize: CGFloat = 16, unit: String, temperatureMin: CGFloat, temperatureMax: CGFloat, temperature: CGFloat) {
        self.animationDuration = animationDuration
        self.progress = progress
        self.numberOfSegments = numberOfSegments
        self.step = step
        self.fontSize = fontSize
        self.meterAngle = Constants.startAngle
        self.unit = unit
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.temperature = temperature
        
    }
    
    private struct Constants {
        static let startAngle: Double = 135.0
        static let endAngle: Double = 45.0
    }
    
    public var body: some View {
        TemperatureView(
            startAngle: Constants.startAngle,
            endAngle: Constants.endAngle,
            meterAngle: meterAngle,
            progress: progress,
            numberOfSegments: numberOfSegments,
            step: step,
            fontSize: fontSize,
            indicatorsConfigurations: indicatorsConfigurations,
            unit: unit,
            temperature: temperature,
            temperatureMin: temperatureMin,
            temperatureMax: temperatureMax
        )
        .onAppear {
            
            Task {
                indicatorsConfigurations = await Calculator.indicatorsConfigurations(
                    startAngle: Constants.startAngle,
                    endAngle: Constants.endAngle,
                    numberOfSegments: numberOfSegments
                )
            }
            
        }
        .onChange(of: progress) { _ in
            Task {
                await animateMeter()
            }
        }
    }

    
    //TODO: - Fix: When the meter is decelerating the animation looks and feels like there is a tiny delay.
    private func animateMeter() {
        let meterAngle = Calculator.angle(progress: progress, startAngle: Constants.startAngle, endAngle: Constants.endAngle)
        withAnimation(.bouncy(duration: animationDuration * 3.0)) {
            self.meterAngle = meterAngle
        }
    }
}


//#Preview {
//        TemperatureGaugeView(
//            animationDuration: 1.5,
//            progress: 0.5,
//            numberOfSegments: 50,
//            step: 5
//            
//        )
//        .frame(width: 200, height: 200)
//    
//}
