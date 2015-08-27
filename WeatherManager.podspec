

Pod::Spec.new do |s|

  s.name         = "WeatherManager"
  s.version      = "2.0.0"
  s.summary      = "Obtain current weather Information."

  s.description  = <<-DESC
                   For PineApple Technology students.
                    Used to learn how to connect to an external API.
                   DESC
  s.license      = "MIT"
  s.homepage     = "http://pineapp.com.au"
  s.author        = "PJ"
  s.source       = { :git => "https://github.com/PineAppleTechAustralia/WeatherManager.git", :tag => "v2.0.0" }
  s.source_files  = "Pod/*"
  s.requires_arc = true
  s.platform     = :ios
  s.dependency =  "AFNetworking", "~> 2.0"

end
