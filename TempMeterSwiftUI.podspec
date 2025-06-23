Pod::Spec.new do |spec|
  spec.name         = "TempMeterSwiftUI"
  spec.version      = "0.1.4"
  spec.summary      = "A SwiftUI package for creating customizable speedometers."

  spec.description  = <<-DESC
    TempMeterSwiftUI is a lightweight and customizable Swift package that allows you 
    to integrate beautiful temperature meter components in your SwiftUI projects.
    It supports smooth animations and real-time data updates.
  DESC

  spec.homepage     = "https://github.com/xeieshan/TempMeterSwiftUI"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Zeeshan Haider" => "xeieshan@gmail.com" }

  spec.platform     = :ios, "15.0"
  spec.swift_version = "5.9"

  spec.source       = { :git => "https://github.com/xeieshan/TempMeterSwiftUI.git", :tag => "v0.1.4" }
  spec.source_files = "Sources/**/*.{swift}"

  spec.framework    = "UIKit"
end
