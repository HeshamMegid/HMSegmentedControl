Pod::Spec.new do |s|
  s.name         = "HMSegmentedControl@kennygunie"
  s.version      = "1.0.0"
  s.summary      = "fork of kennygunie"
  s.homepage     = "https://github.com/kennygunie/HMSegmentedControl"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       = { "Hesham Abd-Elmegid" => "hesham.abdelmegid@gmail.com",
                     "Kien NGUYEN" => "kennygunie@gmail.com" }
  s.source       = { :git => "https://github.com/kennygunie/HMSegmentedControl.git", :tag => "v1.0.0" }
  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'HMSegmentedControl/*.{h,m}'
  s.framework  = 'QuartzCore'
end
