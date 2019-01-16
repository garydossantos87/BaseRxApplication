# Platform
platform :ios, '10.0'

# Sources
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/garydossantos87/PodSpecs.git'

# Common Pods for every OnionArchitecture target
def BaseRxApplicationPods
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'Action'
    pod 'RxAlamofire'
    pod 'KeychainAccess'
    pod 'ObjectMapper'
    pod 'MBProgressHUD'
    pod 'TTGSnackbar'                       #https://github.com/zekunyan/TTGSnackbar
    pod 'CocoaLumberjack/Swift'             #https://github.com/CocoaLumberjack/CocoaLumberjack
    pod 'SnapKit'
    pod 'JVFloatLabeledTextField'           #https://github.com/jverdi/JVFloatLabeledTextField
    pod 'FTLinearActivityIndicator'         #https://github.com/futuretap/FTLinearActivityIndicator
    pod 'SwiftLint'                         #https://github.com/realm/SwiftLint
end


target 'BaseRxApplication' do
    use_frameworks!

    # Pods for BaseRxApplication
    BaseRxApplicationPods()
end

target 'BaseRxApplicationExamples' do
    use_frameworks!

    # Pods for BaseRxApplication
    BaseRxApplicationPods()
end
