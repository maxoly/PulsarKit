#
# Be sure to run `pod lib lint PulsarKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PulsarKit"
  s.version          = "0.0.2"
  s.summary          = "An UITableView and UICollectionView framework"
  s.description      = <<-DESC
                        A lightweight framework to slim down your view controller. PulsarKit is a set of class that provides all 
                        the methods required to display a tableview or a collectionview, including row count, returning a cell view 
                        for each row, handling row selection and many other optional features. 
                       DESC
  s.homepage         = "https://github.com/maxoly/PulsarKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Massimo Oliviero" => "massimo.oliviero@gmail.com" }
  s.source           = { :git => "https://github.com/maxoly/PulsarKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/maxoly'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'PulsarKit/PulsarKit/**/*'
  s.header_mappings_dir = 'PulsarKit/PulsarKit'
  s.public_header_files = "PulsarKit/PulsarKit/Public/*.h"
  s.frameworks = 'UIKit'

end
