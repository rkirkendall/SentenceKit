#
# Be sure to run `pod lib lint SentenceKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SentenceKit'
  s.version          = '0.3.0'
  s.summary          = 'A framework for building sentence-based user interfaces in native Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SentenceKit is an iOS framework for building user interfaces with natural language. This type of UI has been used successfully by apps like Beats by Dre (pre Apple Music) and Philz Coffee.
                       DESC

  s.homepage         = 'https://github.com/rkirkendall/SentenceKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ricky Kirkendall' => 'rkirkendall304@gmail.com' }
  s.source           = { :git => 'https://github.com/rkirkendall/SentenceKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rickykirkendall'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'SentenceKit/Classes/**/*'
  
  s.resource_bundles = {
      'SentenceKit' => ['SentenceKit/Assets/fonts/*.otf']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
