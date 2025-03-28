Pod::Spec.new do |spec|

  # Basic Information
  spec.name         = "TempMeterSwiftUI"
  spec.version      = "0.0.5"
  spec.summary      = "A SwiftUI package for creating customizable speedometers."

  spec.description  = <<-DESC
    TempMeterSwiftUI is a lightweight and customizable Swift package that allows you 
    to integrate beautiful temperature meter components in your SwiftUI projects.
    It supports smooth animations and real-time data updates.
  DESC

  spec.homepage     = "https://github.com/xeieshan/TempMeterSwiftUI"

  # License
  spec.license = { :type => "MIT", :file => "LICENSE" }

  # Author Information
  spec.author = { "Zeeshan Haider" => "xeieshan@gmail.com" }
  
  # Platform & Swift Version
  spec.platform = :ios, "15.0"
  spec.swift_version = "5.0"

  # Source Location
  spec.source = { :git => "https://github.com/xeieshan/TempMeterSwiftUI.git", :tag => "v0.0.5" }


  # Source Files (Swift Package)
  spec.source_files  = "Sources/**/*.{swift}"
  
  # Dependencies (if any)
  # spec.dependency "Alamofire", "~> 5.6"

  # Frameworks (if needed)
  spec.framework  = "UIKit"

end

