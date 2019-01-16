Pod::Spec.new do |s|

  s.platform                  = :ios
  s.swift_version             = '4.0'
  s.ios.deployment_target     = '10.0'
  s.name                      = "BaseRxApplication"
  s.version                   = "1.0.0"
  s.summary 	    		= "Swift extensions for projects in Reactive."
  s.description  			= <<-DESC
  							       Swift extensions for projects in Reactive.Too.
                   			DESC
  s.homepage		     	= "https://github.com/garydossantos87/BaseRxApplication.git"
  s.license      			= { :type => "MIT", :file => "LICENSE" }
  s.author					= { "Gary dos Santos" => "garydossantos87@gmail.com" }
  s.source 					= { :git => "https://github.com/garydossantos87/BaseRxApplication.git", :tag => "v#{s.version}" }
  s.source_files  			= "BaseRxApplication", "BaseRxApplication/**/*.{swift}"
  s.resources				= "BaseRxApplication/**/*.{strings,xib}"
  s.framework  				= "UIKit"

  s.dependency 'RxSwift'
  s.dependency 'RxAlamofire'
  s.dependency 'RxCocoa'
  s.dependency 'TTGSnackbar'
  s.dependency 'Action'
  s.dependency 'MBProgressHUD'
  s.dependency 'ObjectMapper'
  s.dependency 'KeychainAccess'
  s.dependency 'SnapKit'
  s.dependency 'CocoaLumberjack/Swift'
  s.dependency 'FTLinearActivityIndicator'
  s.dependency 'SwiftLint'

end
