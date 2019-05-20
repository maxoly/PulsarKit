Pod::Spec.new do |spec|
  spec.name         = "PulsarKit"
  spec.version      = "1.1.1"
  spec.summary      = "PulsarKit is a simple and beautiful wrapper around the official UICollectionView API written in pure Swift"
  spec.description  = <<-DESC
                  PulsarKit is a simple and beautiful wrapper around the official UICollectionView API written in pure Swift. PulsarKit is a library that lets you populate and update collection views simply using your models. 
                  This framework is lightly inspire by Lighter view controllers and UITableViewSource and UICollectionViewSource in Xamarin Platform.
                   DESC

  spec.homepage     = "http://www.massimooliviero.net"
  spec.social_media_url = 'http://twitter.com/maxoly'
  spec.license      = "MIT"
  spec.author       = { "Massimo Oliviero" => "massimo.oliviero@gmail.com" }
  spec.ios.deployment_target = "10.0"
  spec.source       = { :git => "https://github.com/maxoly/PulsarKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "PulsarKit", "PulsarKit/PulsarKit/**/*.{h,m,swift,c}"
  spec.swift_version = '5.0'
end
