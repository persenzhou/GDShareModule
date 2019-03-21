
Pod::Spec.new do |s|


  s.name         = "GDShareModule"
  s.version      = "1.3.5"
  s.summary      = "三方分享、登录、咨询"

  s.description  = <<-DESC
                   封装三方，QQ、Weibo、WeChat、Udesk 分享、登录、咨询等其他功能！
                   DESC

  s.homepage     = "http://gitlab.gaodun.com/GDComponentizationGroup/GDShareModule"


  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "persen" => "persen.zhou@gaoudn.com" }

  s.platform     = :ios, "8.0"



  s.source       = { :git => "http://gitlab.gaodun.com/GDComponentizationGroup/GDShareModule.git", :tag => "#{s.version}" }
  s.frameworks = "SystemConfiguration","CoreTelephony","Security","CFNetwork"
  s.libraries = "iconv", "sqlite3","stdc++","z","c++"



  s.requires_arc = true

  s.xcconfig = {
                  'OTHER_LDFLAGS' => '-ObjC'
               }

  s.subspec 'Core' do |core|

    core.source_files = "GDShareModule/Core/*.{h,m}"

  end

  s.subspec 'Udesk' do |udesk|

    udesk.source_files = "GDShareModule/Udesk/*.{h,m}"
    udesk.dependency 'UdeskSDK','~> 3.4.9'

  end

  s.subspec 'Counseler' do |counseler|

    counseler.source_files = "GDShareModule/Counseler/*.{h,m}"
    counseler.dependency 'GDShareModule/Tencent'
    counseler.dependency 'GDShareModule/Udesk'

  end

  s.subspec 'Tencent' do |tencent|

    tencent.source_files = "GDShareModule/Tencent/*.{h,m}"
    tencent.dependency 'GDShareModule/Core'
    tencent.vendored_frameworks = "GDShareModule/Tencent/SDK/TencentOpenAPI.framework"
    tencent.resources = ['GDShareModule/Tencent/SDK/TencentOpenApi_IOS_Bundle.bundle']

  end

  s.subspec 'WeChat' do |wechat|

    wechat.source_files = "GDShareModule/WeChat/*.{h,m}","GDShareModule/WeChat/SDK/*.{h,m}"
    wechat.dependency 'GDShareModule/Core'
    wechat.vendored_libraries = 'GDShareModule/WeChat/SDK/libWeChatSDK.a'

  end


  s.subspec 'Weibo' do |weibo|

    weibo.source_files = "GDShareModule/Weibo/*.{h,m}"
    weibo.dependency 'GDShareModule/Core'
    weibo.dependency 'WeiboSDK', '~> 3.1.3'

  end

  s.subspec 'Manager' do |manager|

    manager.source_files = "GDShareModule/Manager/*.{h,m}"
    manager.dependency 'GDShareModule/Tencent'
    manager.dependency 'GDShareModule/WeChat'
    manager.dependency 'GDShareModule/Weibo'
    manager.resources = ['GDShareModule/Manager/SMShareManager.bundle','GDShareModule/Manager/SMShareView.xib']
  end

end
