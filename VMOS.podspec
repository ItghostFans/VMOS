#
# Be sure to run `pod lib lint VMOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VMOS'
  s.version          = '0.1.0'
  s.summary          = 'A iOS Extention Library.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ItghostFans/VMOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ItghostFans' => 'ItghostFans@gmail.com' }
  s.source           = { :git => 'https://github.com/ItghostFans/VMOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.default_subspec = 'UIKit'
  s.preserve_paths = '**'
  
  s.subspec 'Foundation' do |subspec|
    subspec.source_files = 'VMOS/Classes/Foundation/**/*', 'VMOS/Private/Foundation/**/*.h'
    subspec.private_header_files = 'VMOS/Private/Foundation/**/*.h'
  end
  
  s.subspec 'QuartzCore' do |subspec|
    subspec.source_files = 'VMOS/Classes/QuartzCore/**/*', 'VMOS/Private/QuartzCore/**/*.h'
    subspec.private_header_files = 'VMOS/Private/QuartzCore/**/*.h'
    subspec.dependency 'VMOS/Foundation'
  end
  
  s.subspec 'UIKit' do |subspec|
    subspec.source_files = 'VMOS/Classes/UIKit/**/*', 'VMOS/Private/UIKit/**/*.h'
    subspec.private_header_files = 'VMOS/Private/UIKit/**/*.h'
    subspec.dependency 'VMOS/QuartzCore'
  end
  
  # s.resource_bundles = {
  #   'VMOS' => ['VMOS/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'QuartzCore'
  # s.dependency 'AFNetworking', '~> 2.3'
end
