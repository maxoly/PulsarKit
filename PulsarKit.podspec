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
  s.version          = "0.5.5"
  s.summary          = "PulsarKit is a lightweight framework to slim down your view controller when using UITableView or UICollectionView."
  s.description      = <<-DESC
                        A lightweight framework to slim down your view controller. PulsarKit is a set of class that provides all 
                        the methods required to display a tableview or a collectionview, including row count, returning a cell view 
                        for each row, handling row selection and many other optional features. 
                       DESC
  s.homepage         = "https://github.com/maxoly/PulsarKit"
  s.license          = 'MIT'
  s.author           = { "Massimo Oliviero" => "massimo.oliviero@gmail.com" }
  s.source           = { :git => "https://github.com/maxoly/PulsarKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/maxoly'

  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'PulsarKit/PulsarKit/**/*'
  s.frameworks = 'UIKit'

end
