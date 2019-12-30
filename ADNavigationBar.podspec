Pod::Spec.new do |s|
  s.name             = 'ADNavigationBar'
  s.version          = '0.1.2'
  s.summary          = 'ADNavigationBar.'
  s.description      = 'ADNavigationBar description'

  s.homepage         = 'https://github.com/goodswifter/ADNavigationBar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'goodswifter' => '1042480866@qq.com' }
  s.source           = { :git => 'https://github.com/goodswifter/ADNavigationBar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'ADNavigationBar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ADNavigationBar' => ['ADNavigationBar/Assets/*.png']
  # }
end
