//
//  IndicatorsView.swift
//  

import SwiftUI

struct IndicatorsView: View {
    let indicatorConfigurations: [IndicatorViewConfiguration]
    let step: Int
    let fontSize: CGFloat
    let temperatureMin: CGFloat
    let temperatureMax: CGFloat
    
    private struct Constants {
        static let stepLength: CGFloat = 30.0
        static let lengthReducer: CGFloat = 10.0
    }
    
    private var speedometerShapeConfigurations: [SpeedometerShapeConfiguration] {
        return zip(0..., indicatorConfigurations).compactMap { index, config in
            let length: CGFloat = if index.isMultiple(of: step) {
                Constants.stepLength
            } else if index.isMultiple(of: (step / 2)) {
                Constants.stepLength - Constants.lengthReducer
            } else {
                Constants.stepLength - (Constants.lengthReducer * 2)
            }
            return SpeedometerShapeConfiguration(angle: config.angle,
                                                 length: length)
        }
    }
    
    private var filteredIndicatorConfigurations: [IndicatorViewConfiguration] {
        return indicatorConfigurations.filter { $0.index.isMultiple(of: step) }
    }
    
    private var speedIndicatorInset: CGFloat {
        return (Constants.stepLength + fontSize)
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            SpeedometerShape(configurations: speedometerShapeConfigurations)
                .stroke(Color.gray, lineWidth: 1.0)
                .frame(width: width, height: height)
            
            ForEach(filteredIndicatorConfigurations) { configuration in
                let indexFraction = CGFloat(configuration.index) / CGFloat(indicatorConfigurations.count)
                let tempRange = temperatureMax - temperatureMin
                let scaledValue = indexFraction * CGFloat(tempRange)

//                let roundedValue = (scaledValue + CGFloat(temperatureMin)).rounded(.up)
                let roundedValue = (scaledValue + CGFloat(temperatureMin))
                let labelValue: Double = String(format: "%.1f", Double(roundedValue))

                
                
                SpeedIndicatorView(
                    labelValue: labelValue,
                    rect: proxy.frame(in: .local).insetBy(dx: speedIndicatorInset, dy: speedIndicatorInset),
                    angle: configuration.angle,
                    radius: width / 2.0,
                    fontSize: fontSize
                )
                .frame(width: width, height: height)
            }
        }
    }

    
}
//#Preview {
//    IndicatorsView(
//        indicatorConfigurations: (0..<100).map { index in
//            IndicatorViewConfiguration(index: index, angle: Double(index * 10))
//        },
//        step: 5,
//        fontSize: 14
//    )
//    .frame(width: 200, height: 200)
//}
