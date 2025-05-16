//
//  SpeedDisplayView.swift
//  
//
//

import SwiftUI

struct SpeedDisplayView: View {
    let progress: CGFloat
    let numberOfSegments: Int
    let unit: String
    let temperature: CGFloat
    var body: some View {
        VStack(spacing: 6.0) {
//            Text(String(format: "%.f", progress * CGFloat(numberOfSegments)))
            if #available(iOS 16.0, macOS 13.0, *) {
                Text(String(format: "%.1f", CGFloat(temperature)))
                    .font(.largeTitle)
                    .bold()
                    .monospaced()
                    .transaction { transaction in
                        transaction.animation = nil
                    }
            } else {
                Text(String(format: "%.1f", CGFloat(temperature)))
                    .font(.largeTitle)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
            }

            
            Text(unit)
        }
    }
}
