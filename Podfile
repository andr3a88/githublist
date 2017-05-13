platform :ios, '9.0'

def import_pods
    pod 'Alamofire'
    pod 'RxSwift', '~> 3.4'
    pod 'RxCocoa', '~> 3.4'
    pod 'Moya'
    pod 'Moya/RxSwift'
    pod 'ObjectMapper'
end

target 'GitHubList' do
    use_frameworks!
    
    import_pods
    
    target 'GitHubListTests' do
        inherit! :search_paths
    end
    
    target 'GitHubListUITests' do
        inherit! :search_paths
    end
    
end
