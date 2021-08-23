#
#  Be sure to run `pod spec lint CodableAlamofire.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name               = "CodableAlamofire"
  s.version            = "2.0.0"
  s.summary            = "An extension for Alamofire that converts JSON data into Decodable Objects."
  s.homepage           = "https://github.com/Otbivnoe/CodableAlamofire"
  s.license            = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Nikita Ermolenko" => "gnod94@gmail.com" }
  s.social_media_url   = "https://twitter.com/iOtbivnoe"

  s.ios.deployment_target     = '9.0'
  s.osx.deployment_target     = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target    = '9.0'

  s.source        = { :git => "https://github.com/Otbivnoe/CodableAlamofire.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/**/*.{h,swift}"
  s.swift_versions = ['4.0', '5.0', '5.1']

  s.requires_arc = true
  s.dependency 'Alamofire', '~> 4.9'

end
