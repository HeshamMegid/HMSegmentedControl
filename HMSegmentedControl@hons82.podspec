Pod::Spec.new do |s|
  s.name         = "HMSegmentedControl@hons82"
  s.version      = "1.4.1"
  s.summary      = "A drop-in replacement for UISegmentedControl mimicking the style of various Google products. FORK of hons82"
  s.homepage     = "https://github.com/hons82/HMSegmentedControl"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       = { "Hesham Abd-Elmegid" => "hesham.abdelmegid@gmail.com",
  	 				 "Hannes Tribus" => "hons82@gmail.com" }
  s.source       = { :git => "https://github.com/hons82/HMSegmentedControl.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'HMSegmentedControl/*.{h,m}'
  s.framework  = 'QuartzCore'
end
