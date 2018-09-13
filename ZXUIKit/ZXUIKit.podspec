#
# Be sure to run `pod lib lint ZXUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZXUIKit'
  s.version          = '0.1.0'
  s.summary          = 'A meanful summary of ZXUIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'this is lzx UIKIT, remember, longer than summary'

  s.homepage         = 'https://github.com/lizhuxian020@gmail.com/ZXUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lizhuxian020@gmail.com' => 'lizhuxian020@gmail.com' }
  s.source           = { :git => 'https://github.com/lizhuxian020@gmail.com/ZXUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

# s.source_files = 'ZXUIKit/Classes/**/*'
  
  s.subspec 'Interface' do |inter|
      inter.source_files = 'ZXUIKit/Classes/Interface/ZXUIKit.h'
      inter.dependency 'ZXUIKit/Module'
  end
  
  s.subspec 'Module' do |mo|
      mo.source_files = 'ZXUIKit/Classes/ZXUIKit/**/*.{h,m}'
      # mo.dependency 'ZXConvenientCode/Interface'
  end
  
  # s.resource_bundles = {
  #   'ZXUIKit' => ['ZXUIKit/Assets/*.png']
  # }

#  s.public_header_files = 'ZXUIKit/Classes/Interface/ZXUIKit.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.resource = "ZXUIKit/Classes/ZXUIKit/**/*.{xib,sqlite}"
  s.prefix_header_file = 'ZXUIKit/Classes/PrefixHeader.h'
  s.dependency 'Masonry'
  s.dependency 'CocoaLumberjack'
  s.dependency 'CJLabel'
  s.dependency 'IQKeyboardManager'
end
