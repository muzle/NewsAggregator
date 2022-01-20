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

def imageLoader
  pod 'SDWebImage', '~> 5.0'
end

def realm
  pod 'RxRealm'
  pod 'RealmSwift', '10.7'
  pod 'Realm', '10.7'
end

target 'NewsAggregator' do
  # Pods for NewsAggregator
  rxSwift
  rxCocoa
  apiRouter
  imageLoader
  pod 'SnapKit', '~> 5.0.0'
  pod 'lottie-ios'
  realm

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
  imageLoader
  rxCocoa
  
  target 'NetworkPlatformTests' do
    rxTest
  end
end

target 'RealmPlatform' do
  project 'RealmPlatform/RealmPlatform'
  realm
  rxSwift
  
  target 'RealmPlatformTests' do
    rxTest
  end
end

target 'CoreDataPlatform' do
  project 'CoreDataPlatform/CoreDataPlatform'
  rxSwift
  rxCocoa
  
  target 'CoreDataPlatformTests' do
    rxTest
  end
end


target 'AutoGenerator' do
  sourcery
  swiftGen
end
