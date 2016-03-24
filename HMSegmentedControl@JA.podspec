Pod::Spec.new do |s|
  s.name         = "HMSegmentedControl@JA“
  s.version      = “1.0.0”
  s.summary      = “im jason "
  s.homepage     = "https://github.com/JasonStu/HMSegmentedControl"
  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author       = { “Jason Xu” => “jason4271735@gmail.com" }
  s.source       = { :git => "https://github.com/JasonStu/HMSegmentedControl.git", :tag => "v1.5.2" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'HMSegmentedControl/*.{h,m}'
  s.framework  = 'QuartzCore'
end
