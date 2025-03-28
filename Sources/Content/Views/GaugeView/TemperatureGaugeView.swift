//
//  TemperatureGaugeView.swift
//  



import SwiftUI

public struct TemperatureGaugeView: View {
    public var animationDuration: TimeInterval
    @Binding public var progress: CGFloat
    public var numberOfSegments: Int
    public var step: Int
    public var fontSize: CGFloat
    public var unit: String
    public var temperatureMin: CGFloat
    public var temperatureMax: CGFloat
    @State public var meterAngle: Double
    @State private var indicatorsConfigurations: [IndicatorViewConfiguration] = []
    @Binding public var temperature: CGFloat
    public init(animationDuration: TimeInterval, progress: Binding<CGFloat>, numberOfSegments: Int = 100, step: Int = 10, fontSize: CGFloat = 16, unit: String, temperatureMin: CGFloat, temperatureMax: CGFloat, temperature: Binding<CGFloat>) {
        self.animationDuration = animationDuration
        self._progress = progress
        self.numberOfSegments = numberOfSegments
        self.step = step
        self.fontSize = fontSize
        self.meterAngle = Constants.startAngle
        self.unit = unit
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self._temperature = temperature
       
        
    }
    
    private struct Constants {
        static let startAngle: Double = 135.0
        static let endAngle: Double = 45.0
    }
    
    public var body: some View {
        if #available(macOS 11.0, *) {
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
        } else {
            Text("This feature requires macOS 11.0 or later.")
                .font(.headline)
                .foregroundColor(.red)
                .padding()
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
//#Preview {
//    TemperatureGaugeView(
//        animationDuration: 1.5,
//        progress: .constant(0.5),
//        numberOfSegments: 50,
//        step: 5,
//        fontSize: 16,
//        unit: "°C",
//        temperatureMin: -40.0,
//        temperatureMax: 120.0,
//        temperature: .constant(25.0)
//        
//    )
//    .frame(width: 200, height: 200)
//}

