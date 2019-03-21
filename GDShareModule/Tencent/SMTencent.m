//
//  SMTencent.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "SMTencent.h"
#import <TencentOpenAPI/TencentOAuth.h>

#import "SMTencentAction.h"

#import "SMOauthUser.h"

#import "NSString+GDShareModule.h"

#import <TencentOpenAPI/QQApiInterface.h>

typedef NS_ENUM(NSInteger,SMTencentHandleType){
    SMTencentHandleTypeAuthorize,
    SMTencentHandleTypeQQApi
};

@interface SMTencent ()<TencentSessionDelegate,QQApiInterfaceDelegate>
@property (nonatomic,strong) TencentOAuth *tencentOAuth;
@property (nonatomic,weak) id <SMShareManagerProtocol> delegate;

@property (nonatomic,assign) SMTencentHandleType handleType;
@end

@implementation SMTencent

#pragma mark -  Handle Open Url
+ (BOOL)validateOpenUrl:(NSURL *)url
{
    if (!url)
    {
        return NO;
    }
    
    NSString *urlString = url.absoluteString;
    
    return [urlString rangeOfString:@"tencent"].length > 0 || [urlString rangeOfString:@"QQ"].length > 0;
}

- (BOOL)handleOpenURL:(NSURL *)url delegate:(id <SMShareManagerProtocol>)delegate
{
    if (url)
    {
        BOOL handle;
        switch (_handleType)
        {
            case SMTencentHandleTypeQQApi:
                handle = [QQApiInterface handleOpenURL:url delegate:self];
                break;
            case SMTencentHandleTypeAuthorize:
                handle = [TencentOAuth HandleOpenURL:url];
                break;
        }
        
        return handle;
    }
    
    return NO;
}

#pragma mark - Register
- (BOOL)registerQQWithAppId:(NSString *)appId delegate:(id <SMShareManagerProtocol>)delegate;
{
    if ([appId sm_emptyString])
    {
        return NO;
    }
    
    TencentOAuth *tencent = [[TencentOAuth alloc] initWithAppId:appId andDelegate:self];
    tencent.redirectURI = @"www.qq.com";
    
    if (tencent)
    {
        _tencentOAuth = tencent;
        self.delegate = delegate;
        return YES;
    }
    
    return NO;
}

- (BOOL)authorize
{
    _handleType = SMTencentHandleTypeAuthorize;
    
    return [self.tencentOAuth authorize:@[
                                   kOPEN_PERMISSION_GET_INFO
                                   ]];
}

#pragma mark - Action
- (void)sendTencentActionWithType:(SMTencentActionType)acitonType param:(SMActionParam *)param
{
    _handleType = SMTencentHandleTypeQQApi;
    
    [SMTencentAction sendTencentActionWithType:acitonType param:param];
//    if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)])
//    {
//        [self.delegate shareManagerActionResult:result];
//    }
}

#pragma mark - TencentLoginDelegate
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin
{
    [self.tencentOAuth getUserInfo];
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
    {
        [self.delegate shareManagerLoginFailWithCancel:cancelled];
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork
{
    if ([self.delegate respondsToSelector:@selector(shareManagerNetworkFail)])
    {
        [self.delegate shareManagerNetworkFail];
    }
}

#pragma mark - TencentSessionDelegate

- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    [tencentOAuth incrAuthWithPermissions:permissions];
    
    return NO;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
    if (0 == [tencentOAuth.accessToken length])
    {
        if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
        {
            [self.delegate shareManagerLoginFailWithCancel:NO];
        }
    }
}

- (void)tencentFailedUpdate:(UpdateFailType)reason
{
    
    if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
    {
        [self.delegate shareManagerLoginFailWithCancel:NO];
    }
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    
    if (URLREQUEST_SUCCEED == response.retCode)
    {
        if ([self.delegate respondsToSelector:@selector(shareManagerLoginSuccessWithUserInfomation:)])
        {
            
            NSDictionary *dict = response.jsonResponse;
            
            NSString *nickname = [dict objectForKey:@"nickname"];
            NSString *iconImg = [dict objectForKey:@"figureurl_qq_2"];
            NSString *userId = _tencentOAuth.openId;
            NSString *token = _tencentOAuth.accessToken;
            
            SMOauthUser *user = [SMOauthUser oauthUserWithNickName:nickname iconUrl:iconImg userId:userId accessToken:token];
            
            [self.delegate shareManagerLoginSuccessWithUserInfomation:user];
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(shareManagerLoginFailWithCancel:)])
        {
            [self.delegate shareManagerLoginFailWithCancel:NO];
        }
    }
}

- (void)addShareResponse:(APIResponse*) response
{
//    if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)]) {
//        
//        SMActionResult result = URLREQUEST_SUCCEED == response.retCode?SMActionResultSuccess:SMActionResultFail;
//        
//        [self.delegate shareManagerActionResult:result];
//    }
}


#pragma mark - QQApiInterfaceDelegate

/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req
{
    
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp
{
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            if ([self.delegate respondsToSelector:@selector(shareManagerActionResult:)]) {
                
                SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
                
                QQApiSendResultCode code = (QQApiSendResultCode) [sendResp.result integerValue];
                
                SMActionResult result = [SMTencent handleSendResult:code];
                
                [self.delegate shareManagerActionResult:result];
            }
        }
            break;
            
        default:
        {
            break;
        }
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response
{
    
}

+ (SMActionResult)handleSendResult:(QQApiSendResultCode)result
{
    switch (result)
    {
        case EQQAPISENDSUCESS:
            return SMActionResultSuccess;
            break;
            
        case EQQAPIAPPNOTREGISTED:
            return SMActionResultNotRegister;
            break;
            
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
            return SMActionResultArgumentError;
            break;
            
        case EQQAPIQQNOTINSTALLED:
            return SMActionResultNotInstalled;
            break;
            
        case EQQAPISENDFAILD:
            return SMActionResultFail;
            break;
            
        case EQQAPIQQNOTSUPPORTAPI:
            return SMActionResultNotSupport;
            break;
            
        case EQQAPIVERSIONNEEDUPDATE:
            return SMActionResultVersionOld;
            break;

        default:
            return SMActionResultFail;
            break;
    }
}
@end
