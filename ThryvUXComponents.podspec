#
# Be sure to run `pod lib lint ThryvUXComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ThryvUXComponents'
  s.version          = '0.0.1'
  s.summary          = 'ThryvUXComponents contains everything you need to create a simple social app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
There's a bunch of really cool stuff in this pod, all targeted at letting you build the things that are *different* about your app, not the reproducing the same things over and over. Customizable, extendable, bare bones implementations of common UX components like splash, login, creds creation, commenting, and view/edit profile screens, an app delegate implementation that sets up fabric and crashlytics for you, a simple framework for handling user sessions, a material design based controller for table views... and more coming!
                       DESC

  s.homepage         = 'https://github.com/Elliot/ThryvUXComponents'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Elliot' => '' }
  s.source           = { :git => 'https://github.com/ThryvInc/thryv-ux-components.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/thryvinc'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ThryvUXComponents/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ThryvUXComponents' => ['ThryvUXComponents/Assets/*.png']
  # }

  #s.public_header_files = 'Pod/Classes/**/*.h'
  #s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'FunkyNetwork'
  #s.dependency 'Eureka'
  #s.dependency 'MaterialComponents'
  #s.dependency 'Fabric'
  #s.dependency 'Crashlytics'
  #s.dependency 'SDWebImage'
  s.dependency 'Cloudinary'
  #s.dependency 'Bolts'
  #s.dependency 'FBSDKCoreKit'
  s.dependency 'FBSDKLoginKit'
  s.dependency 'SSPullToRefresh'
  s.dependency 'ISO8601DateFormatter'
  #s.dependency 'SBTextInputView'
  s.dependency 'MultiModelTableViewDataSource'
  s.dependency 'Prelude', '~> 3.0'
end
