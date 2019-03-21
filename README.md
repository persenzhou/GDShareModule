三方分享、登录、咨询！

1.info.plist 文件增加项

(1)Bundle display name   ${PRODUCT_NAME}

(2)URL types 复制（对应的 CFBundleURLSchemes 值根据注册的三方账号修改）

<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string></string>
<key>CFBundleURLSchemes</key>
<array>
<string>tencent101055478</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string></string>
<key>CFBundleURLSchemes</key>
<array>
<string>QQ0605FBF6</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>weixin</string>
<key>CFBundleURLSchemes</key>
<array>
<string>wx8baf1de2a92d60c4</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>com.weibo</string>
<key>CFBundleURLSchemes</key>
<array>
<string>wb1108795777</string>
</array>
</dict>
</array>



(3)LSApplicationQueriesSchemes

(复制)
<key>LSApplicationQueriesSchemes</key>
<array>
<string>wechat</string>
<string>weixin</string>
<string>sinaweibohd</string>
<string>sinaweibo</string>
<string>sinaweibosso</string>
<string>weibosdk</string>
<string>weibosdk2.5</string>
<string>mqqapi</string>
<string>mqq</string>
<string>mqqOpensdkSSoLogin</string>
<string>mqqconnect</string>
<string>mqqopensdkdataline</string>
<string>mqqopensdkgrouptribeshare</string>
<string>mqqopensdkfriend</string>
<string>mqqopensdkapi</string>
<string>mqqopensdkapiV2</string>
<string>mqqopensdkapiV3</string>
<string>mqqopensdkapiV4</string>
<string>mqzoneopensdk</string>
<string>wtloginmqq</string>
<string>wtloginmqq2</string>
<string>mqqwpa</string>
<string>mqzone</string>
<string>mqzonev2</string>
<string>mqzoneshare</string>
<string>wtloginqzone</string>
<string>mqzonewx</string>
<string>mqzoneopensdkapiV2</string>
<string>mqzoneopensdkapi19</string>
<string>mqzoneopensdkapi</string>
<string>mqqbrowser</string>
<string>mttbrowser</string>
</array>


（4）App Transport Security Settings（复制）

<key>NSAppTransportSecurity</key>
<dict>
<key>NSExceptionDomains</key>
<dict>
<key>sina.cn</key>
<dict>
<key>NSExceptionMinimumTLSVersion</key>
<string>TLSv1.0</string>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
<false/>
</dict>
<key>sina.com.cn</key>
<dict>
<key>NSExceptionMinimumTLSVersion</key>
<string>TLSv1.0</string>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
<true/>
<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
<false/>
</dict>
<key>sinaimg.cn</key>
<dict>
<key>NSExceptionMinimumTLSVersion</key>
<string>TLSv1.0</string>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
<true/>
<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
<false/>
</dict>
<key>sinajs.cn</key>
<dict>
<key>NSExceptionMinimumTLSVersion</key>
<string>TLSv1.0</string>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
<true/>
<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
<false/>
</dict>
<key>weibo.cn</key>
<dict>
<key>NSExceptionMinimumTLSVersion</key>
<string>TLSv1.0</string>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
<false/>
</dict>
<key>weibo.com</key>
<dict>
<key>NSExceptionMinimumTLSVersion</key>
<string>TLSv1.0</string>
<key>NSIncludesSubdomains</key>
<true/>
<key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
<true/>
<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
<false/>
</dict>
</dict>
</dict>


（5）Privacy - Camera Usage Description 、Privacy - Microphone Usage Description 、Privacy - Photo Library Usage Description

<key>NSCameraUsageDescription</key>
<string>是否允许此App使用你的相机？</string>
<key>NSMicrophoneUsageDescription</key>
<string>是否允许访问你的麦克风</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>是否允许此App访问你的相册</string>

