# TempMeterSwiftUI

`TempMeterSwiftUI` is a SwiftUI library that provides a customizable temperature gauge for your iOS applications. It includes a variety of components and configurations to create an animated temperature meter with indicator lines and labels.

## Features

- **Customizable temperature gauge**: Easily adjust the number of segments, steps, and animation duration
- **Animated needle**: Smoothly animates the needle as the temperature changes
- **Indicator lines**: Displays indicator lines and labels for each segment
- **Temperature range**: Configurable minimum and maximum temperature values
- **Color gradient**: Temperature-appropriate color gradient from cold to hot
- **Reusable shapes**: Modular design with reusable shapes for drawing arcs and lines

## Customizing the Gauge

You can customize the `TemperatureGaugeView` with parameters such as:
- Animation duration
- Progress
- Number of segments
- Step interval for major indicator lines
- Font size for the indicator labels
- Temperature range (minimum and maximum values)
- Unit display (°C, °F, etc.)

## Indicator Configuration

The library provides a convenient way to configure indicator lines and labels using the `Calculator` struct. The `Calculator.indicatorsConfigurations` function generates configurations based on the specified start and end angles and the number of segments.

## Drawing Shapes

The library includes several reusable shapes for drawing arcs and lines:

- `ArcShape`: Draws an arc from a start angle to an end angle
- `ArcLineShape`: Draws a line from the center of a rectangle to a calculated position based on an angle
- `SpeedometerShape`: Draws the indicator lines based on the provided configurations

## Usage Example

Below is an example of how to integrate and customize the `TemperatureGaugeView` within your SwiftUI application:

```swift
import SwiftUI
import TempMeterSwiftUI

struct ContentView: View {
    @State private var isPressing: Bool = true
    @State private var speed: TimeInterval = 0.01
    @State var progress: CGFloat = 0.0
    @State var numberOfSegments: Int = 130
    @State var step: Int = 10
    @State var unit: String = "°C"
    @State private var inputTemperature: String = ""
    @State private var temperature: Double = 0.0
    @State private var targetTemperature: Double = 0.0
    @State private var previousTemperature: Double = 0.0
    
    private let minTemp: Double = -10.0
    private let maxTemp: Double = 120.0

    private func mapTemperatureToProgress(_ temp: Double) -> CGFloat {
        let boundedTemp = max(minTemp, min(maxTemp, temp))
        return CGFloat((boundedTemp - minTemp) / (maxTemp - minTemp))
    }

    var body: some View {
        VStack {
            speedometer

            VStack {
                Text("Temperature: \(temperature, specifier: "%.f")°C")
                Slider(value: $temperature, in: minTemp...maxTemp)
                    .rotation3DEffect(isPressing ? .degrees(45) : .zero, axis: (x: 1, y: 0, z: 0))
                    .animation(.easeInOut(duration: 0.2), value: isPressing)
                    .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, perform: {}, onPressingChanged: { isPressing in
                        self.isPressing = isPressing
                    })
                    .padding()
            }
            .padding()
        }
    }

    private var speedometer: some View {
        TimelineView(.animation(minimumInterval: speed)) { context in
            TemperatureGaugeView(
                animationDuration: speed,
                progress: mapTemperatureToProgress(temperature),
                numberOfSegments: numberOfSegments,
                step: step,
                unit: unit,
                temperatureMin: minTemp,
                temperatureMax: maxTemp,
                temperature: temperature
            )
            .onChange(of: context.date) { oldValue, newValue in
                let progress = if isPressing {
                    min(1.0, progress + 0.01)
                } else {
                    max(0.0, progress - 0.01)
                }

                self.speed = if isPressing { 0.05 } else { 0.2 }
                withAnimation(.bouncy(duration: speed * 3.0)) {
                    self.progress = progress
                }
            }
            .frame(width: 300.0, height: 300.0)
        }
    }
}

#Preview {
    ContentView(numberOfSegments: 100, step: 20)
        .preferredColorScheme(.dark)
}
```
