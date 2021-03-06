source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def database_pods
  pod 'RealmSwift'
  pod 'SwiftyJSON'
end

def ui_pods
  pod 'MBProgressHUD', '~> 1.1.0'
end

def diff_pods
  pod 'DifferenceKit'
end

def shared_pods
  # Analytics
  pod 'Firebase/Core'

  # Crash Report
  pod 'Fabric'
  pod 'Crashlytics'

  # Code utilities
  pod 'semver'

  # UI
  pod 'SlackTextViewController', :git => 'https://github.com/rafaelks/SlackTextViewController.git'
  pod 'MobilePlayer', :git => 'https://github.com/RocketChat/RCiOSMobilePlayer'
  pod 'SimpleImageViewer', :git => 'https://github.com/cardoso/SimpleImageViewer.git'
  pod 'SwipeCellKit'
  ui_pods

  # Text Processing
  pod 'RCMarkdownParser', :git => 'https://github.com/RocketChat/RCMarkdownParser.git'

  # Database
  database_pods

  # Network
  pod 'Nuke', '~> 7.3'
  pod 'Nuke-FLAnimatedImage-Plugin'
  pod 'Starscream', '~> 2'
  pod 'ReachabilitySwift'

  # Authentication SDKs
  pod 'OAuthSwift'
  pod '1PasswordExtension'

  # Debugging
  pod 'SwiftLint', :configurations => ['Debug']
  pod 'FLEX', '~> 2.0', :configurations => ['Debug', 'Beta']

  # Diffing
  diff_pods
end

target 'Rocket.Chat.ShareExtension' do
  pod 'Nuke-FLAnimatedImage-Plugin'
  database_pods
  ui_pods
  diff_pods
end

target 'Rocket.Chat' do
  # Shared pods
  shared_pods
end

target 'Rocket.ChatTests' do
  # Shared pods
  shared_pods
end

post_install do |installer|
  swift3Targets = ['MobilePlayer', 'RCMarkdownParser']
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.1'
      if config.name == 'Debug'
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      else
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
      end
    end
    if swift3Targets.include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.1'
      end
    end
  end
end

