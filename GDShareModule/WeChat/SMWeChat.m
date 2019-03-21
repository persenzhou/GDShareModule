//
//  SMWeChat.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "SMWeChat.h"
#import "SMWeChatAction.h"
#import "SMOauthUser.h"
#import "WXApi.h"
#import "NSString+GDShareModule.h"
@interface SMWeChat()<WXApiDelegate>
@property (nonatomic,weak) id<SMShareManagerProtocol> delegate;
@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *appSecret;
@end

@implementation SMWeChat

// 注册
+ (BOOL)registerAppWithAppId:(NSString *)appId
{
    BOOL status =  [WXApi registerApp:appId withDescription:@"SMShareManager"];
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];

    return status;
}

// Handle Open URL
+ (BOOL)validateOpenUrl:(NSURL *)url
{
    NSString *urlString = url.absoluteString;
    return [urlString rangeOfString:@"wx"].length>0;
}

- (BOOL)handleOpenURL:(NSURL *)url delegate:(id <SMShareManagerProtocol>)delegate
{
    self.delegate = delegate;
    return [WXApi handleOpenURL:url delegate:self];
}

// 授权登录
- (BOOL)authorizeWithOpenId:(NSString *)openId appSecret:(NSString *)appSecret viewController:(UIViewController*)viewController delegate:(id<SMShareManagerProtocol>)delegate
{
    
    self.delegate = delegate;
    self.openId = openId;
    self.appSecret = appSecret;
    
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";// @"post_timeline,sns"
    req.state = @"authorize";
    req.openID = openId;
    
    return [WXApi sendAuthReq:req
               viewController:viewController
                     delegate:self];
}

// 分享
- (void)sendWeChatActionType:(SMWeChatActionType)acitonType platform:(SMPlatformType)platformType param:(SMActionParam *)param
{
    [SMWeChatAction sendWeChatActionType:acitonType platform:platformType param:param];
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        [self sendMessageHandleSendRespCode:resp.errCode];
    }
    else if ([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *response = (SendAuthResp *)resp;
        NSLog(@"%@,%d",response.code,response.errCode);
        [self sendAuthHandleWithHandleSendRespCode:response];
        
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        // 添加卡券结果
    } else if ([resp isKindOfClass:[WXChooseCardResp class]]) {
        //选择卡券结果
    }
}

- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
        //微信终端向第三方程序请求提供内容，第三方程序调用sendResp向微信终端返回一个GetMessageFromWXResp消息结构体。
    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        //第三方程序处理完内容后调用sendResp向微信终端发送ShowMessageFromWXResp。
    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        //微信终端打开第三方程序携带的消息结构体.不需要返回，
    }
}

#pragma mark - 回调
- (void)sendMessageHandleSendRespCode:(NSInteger)errCode{
    switch (errCode)
    {
        case WXSuccess:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultSuccess];
            }
            
            break;
        case WXErrCodeCommon:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultFail];
            }
            
            break;
        case WXErrCodeUserCancel:
            if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
            {
                [self.delegate shareManagerLoginFailWithCancel:YES];
            }
            break;
        case WXErrCodeSentFail:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultFail];
            }
            
            break;
        case WXErrCodeAuthDeny:
            if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
            {
                [self.delegate shareManagerLoginFailWithCancel:NO];
            }
            break;
        case WXErrCodeUnsupport:
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultNotSupport];
            }
            break;
            
        default:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultUnKnow];
            }
            break;
    }
}

- (void)sendAuthHandleWithHandleSendRespCode:(SendAuthResp *)resp{
    
    switch (resp.errCode)
    {
        case WXSuccess:
        {
            [self requestAccessTokenWithCode:resp.code];
        }
            break;
        case WXErrCodeCommon:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
            {
                [self.delegate shareManagerLoginFailWithCancel:NO];
            }
            
            break;
        case WXErrCodeUserCancel:
            if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
            {
                [self.delegate shareManagerLoginFailWithCancel:YES];
            }
            break;
        case WXErrCodeSentFail:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
            {
                [self.delegate shareManagerLoginFailWithCancel:NO];
            }
            
            break;
        case WXErrCodeAuthDeny:
            if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
            {
                [self.delegate shareManagerLoginFailWithCancel:NO];
            }
            break;
        case WXErrCodeUnsupport:
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultNotSupport];
            }
            break;
            
        default:
            
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
            {
                [self.delegate shareManagerActionResult:SMActionResultUnKnow];
            }
            break;
    }
}

#pragma mark - Auth Request
- (void)requestUserInfoWithAccessToken:(NSString *)accessToken openId:(NSString *)openId
{
    //access_token openid
    NSString *userInfoUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    
    userInfoUrl = [userInfoUrl utf8String];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:userInfoUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error)
        {
            NSError *jsonError;
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (!jsonError)
            {
                NSString *openId = [json objectForKey:@"openid"];
                if (openId.length > 0)
                {
                    NSString *nickName = [json objectForKey:@"nickname"];
                    NSString *iconImg = [json objectForKey:@"headimgurl"];
                    
                    
                    SMOauthUser *user = [SMOauthUser oauthUserWithNickName:nickName iconUrl:iconImg userId:openId accessToken:accessToken];
                    
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
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(shareManagerNetworkFail)])
            {
                [self.delegate shareManagerNetworkFail];
            }
        }
        
    }] resume];
}

- (void)requestAccessTokenWithCode:(NSString *)code
{
    
    NSString *accessTokenString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",_openId,self.appSecret,code];
    
    accessTokenString = [accessTokenString utf8String];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:accessTokenString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error)
        {
            NSError *jsonError;
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (!jsonError)
            {
                NSString *accesstoken = [json objectForKey:@"access_token"];
                NSString *openId = [json objectForKey:@"openid"];
                if (accesstoken.length > 0)
                {
                    [self requestUserInfoWithAccessToken:accesstoken openId:openId];
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
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(shareManagerNetworkFail)])
            {
                [self.delegate shareManagerNetworkFail];
            }
            
        }
    }] resume];
}

@end
