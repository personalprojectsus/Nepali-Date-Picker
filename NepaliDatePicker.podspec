#
# Be sure to run `pod lib lint NepaliDatePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NepaliDatePicker'
  s.version          = '1.0.0'
  s.summary          = 'NepaliDatePicker is the pickerview that allows users to select date in B.S.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Nepali Date Picker is the simple pickerview that allows users to pick date in nepali date.
                       DESC

  s.homepage         = 'https://github.com/personalprojectsus/Nepali-Date-Picker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nabin Shrestha' => 'nabs107@gmail.com' }
  s.source           = { :git => 'https://github.com/personalprojectsus/Nepali-Date-Picker.git', :tag => "1.0.0" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'NepaliDatePicker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NepaliDatePicker' => ['NepaliDatePicker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.swift_version = "4.2"
end
