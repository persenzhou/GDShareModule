//
//  SMWeibo.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "SMWeibo.h"
#import "WeiboSDK.h"
#import "SMOauthUser.h"
#import "SMWeiboAction.h"
#import <WeiboUser.h>
@interface SMWeibo()<WeiboSDKDelegate>

@property (nonatomic,weak) id <SMShareManagerProtocol> delegate;

@property (nonatomic, copy) NSString *accessToken;

@end

@implementation SMWeibo

// 注册
+ (BOOL)registerAppWithAppId:(NSString *)appId
{
    [WeiboSDK enableDebugMode:YES];
    return [WeiboSDK registerApp:appId];
}

// Handle Open URL
+ (BOOL)validateOpenUrl:(NSURL *)url
{
    NSString *urlString = url.absoluteString;
    return [urlString rangeOfString:@"wb"].length>0;
}

- (BOOL)handleOpenURL:(NSURL *)url delegate:(id <SMShareManagerProtocol>)delegate
{
    self.delegate = delegate;
    
    return [WeiboSDK handleOpenURL:url delegate:self ];
}

// 授权登录
- (BOOL)authorizeWithRedirectURI:(NSString *)redirectURI;
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = redirectURI;
    request.scope = @"all";
    request.userInfo = @{@"Method": @"Login"};

    return [WeiboSDK sendRequest:request];
}

// 分享
- (void)sendWeChatActionType:(SMWeiboActionType)acitonType param:(SMActionParam *)param
{
    [SMWeiboAction sendWeiboActionType:acitonType param:param accessToken:_accessToken];
}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    //Message Response
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {

        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        _accessToken = accessToken;
        
        [self sendMessageHandleStatusCode:response.statusCode];
        
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])//Authorize Response
    {
        [self sendAuthHandleWithWeiboResponse:response];
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
        {
            [self.delegate shareManagerActionResult:SMActionResultNotSupport];
        }
    }
    else if([response isKindOfClass:WBSDKAppRecommendResponse.class])
    {
        if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
        {
            [self.delegate shareManagerActionResult:SMActionResultNotSupport];
        }
        
    }
}

- (void)sendMessageHandleStatusCode:(WeiboSDKResponseStatusCode)statusCode
{
    switch (statusCode)
    {
        case WeiboSDKResponseStatusCodeSuccess:
        {
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)]) {
                
                [self.delegate shareManagerActionResult:SMActionResultSuccess];
            }
        }
            
            break;
            
        case WeiboSDKResponseStatusCodeUserCancel:
        case WeiboSDKResponseStatusCodeSentFail:
        case WeiboSDKResponseStatusCodeAuthDeny:
        case WeiboSDKResponseStatusCodePayFail:
        case WeiboSDKResponseStatusCodeShareInSDKFailed:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultFail];
            }
            
            break;
        case WeiboSDKResponseStatusCodeUserCancelInstall:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultNotInstalled];
            }
            
            break;
            
        case WeiboSDKResponseStatusCodeUnsupport:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultNotSupport];
            }
            
            break;
        case WeiboSDKResponseStatusCodeUnknown:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultUnKnow];
            }
            
            break;
    }
}

- (void)sendAuthHandleWithWeiboResponse:(WBBaseResponse *)response
{
    switch (response.statusCode)
    {
        case WeiboSDKResponseStatusCodeSuccess:
        {
            NSString *accessToken = [(WBAuthorizeResponse *)response accessToken];
            NSString *userId = [(WBAuthorizeResponse *)response userID];
            
            _accessToken = accessToken;
            
            // 登录授权请求用户信息
            if ([[response.requestUserInfo valueForKey:@"Method"] isEqualToString:@"Login"])
            {
                [self requestUserInfoWithUserId:userId accessToken:accessToken];
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)]) {
                    
                    [self.delegate shareManagerActionResult:SMActionResultSuccess];
                }
            }
        }
            
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
            {
                [self.delegate shareManagerLoginFailWithCancel:YES];
            }
            
            break;
            
        case WeiboSDKResponseStatusCodeSentFail:
        case WeiboSDKResponseStatusCodeAuthDeny:
        case WeiboSDKResponseStatusCodePayFail:
        case WeiboSDKResponseStatusCodeShareInSDKFailed:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
            {
                [self.delegate shareManagerLoginFailWithCancel:NO];
            }
            
            break;
        case WeiboSDKResponseStatusCodeUserCancelInstall:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultNotInstalled];
            }
            
            break;
            
        case WeiboSDKResponseStatusCodeUnsupport:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultNotSupport];
            }
            
            break;
        case WeiboSDKResponseStatusCodeUnknown:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultUnKnow];
            }
            
            break;
    }
}

#pragma mark - Request
- (void)requestUserInfoWithUserId:(NSString *)userId accessToken:(NSString *)accessToken
{
    //  发送一个请求 （用户信息）;
    [WBHttpRequest requestForUserProfile:userId withAccessToken:accessToken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        if (!error)
        {
            WeiboUser *user = (WeiboUser *)result;
            BOOL success =  [user.userID integerValue] > 0;
            if (success)
            {
                NSString *nickName = user.name;
                NSString *iconUrl = user.profileImageUrl;
                
                SMOauthUser *user = [SMOauthUser oauthUserWithNickName:nickName iconUrl:iconUrl userId:userId accessToken:accessToken];
                [self.delegate shareManagerLoginSuccessWithUserInfomation:user];
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(shareManagerNetworkFail)])
                {
                    [self.delegate shareManagerNetworkFail];
                }
            }
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(shareManagerNetworkFail)])
            {
                [self.delegate shareManagerNetworkFail];
            }
        }
    }];
}
@end
