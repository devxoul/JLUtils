Pod::Spec.new do |s|
  s.name         = "JLUtils"
  s.version      = "0.0.1"
  s.summary      = ""
  s.homepage     = "http://github.com/devxoul/JLUtils"
  s.license      = 'BSD'
  s.author       = { "devxoul" => "devxoul@gmail.com" }
  s.source       = { :git => "https://github.com/devxoul/JLUtils.git", :tag => "0.0.1" }
  s.platform     = :ios, '6.0'
  s.source_files = 'JLUtils', 'JLUtils/**/*.{h,m}'
  s.exclude_files = 'JLUtils/Exclude'
  s.frameworks = 'UIKit', 'Foundation', 'MapKit'
  s.requires_arc = true
end
