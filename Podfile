# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
workspace 'NewsAggregator'
use_frameworks!

def rxSwift
  pod 'RxSwift'
end

def rxCocoa
  pod 'RxCocoa'
end

def rxTest
  pod 'RxBlocking'
  pod 'RxTest'
end

def sourcery
  pod 'Sourcery'
end

def swiftGen
  pod 'SwiftGen', '~> 6.0'
end

def apiRouter
  pod 'ApiRouter'
end

target 'NewsAggregator' do
  # Pods for NewsAggregator
  rxSwift
  rxCocoa
  apiRouter
  pod 'SnapKit', '~> 5.0.0'

  target 'NewsAggregatorTests' do
    inherit! :search_paths
    # Pods for testing
    rxTest
    rxCocoa
  end

  target 'NewsAggregatorUITests' do
    # Pods for testing
  end

end

target 'Domain' do
  project 'Domain/Domain'
  rxSwift
  rxCocoa
end


target 'NetworkPlatform' do
  project 'NetworkPlatform/NetworkPlatform'
  rxSwift
  apiRouter
  
  target 'NetworkPlatformTests' do
    rxTest
  end
end

target 'AutoGenerator' do
  sourcery
  swiftGen
end
