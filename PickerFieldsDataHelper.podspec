#
# Be sure to run `pod lib lint PickerFieldsDataHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PickerFieldsDataHelper'
  s.version          = '0.2.0'
  s.summary          = 'PickerFieldsDataHelper is a protocol in Swift, that helps using selectable options in text field outlets.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Swift (3) Protocol to create Picker Views and Date Pickers to work with Text Fields' outlets, providing selectable options to fulfill them.
                       DESC

  s.homepage         = 'https://github.com/allanalves/PickerFieldsDataHelper'
  s.screenshots     = 'https://raw.githubusercontent.com/allanalves/PickerFieldsDataHelper/master/Images/normal-picker.png', 'https://raw.githubusercontent.com/allanalves/PickerFieldsDataHelper/master/Images/date-picker.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Allan Alves' => 'allanalves90@gmail.com' }
  s.source           = { :git => 'https://github.com/allanalves/PickerFieldsDataHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PickerFieldsDataHelper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PickerFieldsDataHelper' => ['PickerFieldsDataHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
