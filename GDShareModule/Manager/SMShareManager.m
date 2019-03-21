//
//  SMShareManager.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "SMShareManager.h"

#import "SMTencent.h"
#import "SMWeChat.h"
#import "SMWeibo.h"

#import "NSString+GDShareModule.h"

#import "SMShareView.h"

static SMShareManager *instance_;

@interface SMShareManager ()

@property (nonatomic,strong) SMTencent *tencent;
@property (nonatomic,strong) SMWeChat *wechat;
@property (nonatomic,strong) SMWeibo *weibo;

@end

@implementation SMShareManager


+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[SMShareManager alloc] init];
    });
    
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    
    return instance_;
}

+ (void)clearUp
{
    SMShareManager *manager = [SMShareManager shareManager];
    manager.tencent = nil;
    manager.wechat = nil;
    manager.weibo = nil;
}

#pragma mark - Register
+ (BOOL)registerQQWithAppId:(NSString *)appId delegate:(id <SMShareManagerProtocol>)delegate;
{
    if ([appId sm_emptyString])
    {
        return NO;
    }
    
    return [[SMShareManager shareManager].tencent registerQQWithAppId:appId delegate:delegate];
}

+ (BOOL)registerWeiboWithAppId:(NSString *)appId
{
    if ([appId sm_emptyString])
    {
        return NO;
    }
    return [SMWeibo registerAppWithAppId:appId];
}

+ (BOOL)registerWeChatWithAppId:(NSString *)appId
{
    if ([appId sm_emptyString])
    {
        return NO;
    }
    return [SMWeChat registerAppWithAppId:appId];
}

#pragma mark - Handle Open Url
+ (SMPlatformType)validateOpenUrl:(NSURL *)url
{
    if ([SMWeibo validateOpenUrl:url])
    {
        return SMPlatformTypeWeibo;
        
    }else if([SMTencent validateOpenUrl:url])
    {
        return SMPlatformTypeQQ;
        
    }else if([SMWeChat validateOpenUrl:url])
    {
        return SMPlatformTypeWXSession;
    }
    
    return SMPlatformTypeUnknow;
}

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id <SMShareManagerProtocol>)delegate shareType:(SMPlatformType)shareType
{
    switch (shareType) {
       
        case SMPlatformTypeQQCollect:
        case SMPlatformTypeQQZone:
        case SMPlatformTypeQQ:
        {
            return [[SMShareManager shareManager].tencent handleOpenURL:url delegate:delegate];
        }
            break;
            
        case SMPlatformTypeWXSession:
        case SMPlatformTypeWXTimeline:
        case SMPlatformTypeWXCollect:
            
        {
            return [[SMShareManager shareManager].wechat handleOpenURL:url delegate:delegate];
        }
        
            break;
            
        case SMPlatformTypeWeibo:
            
            
            return [[SMShareManager shareManager].weibo handleOpenURL:url delegate:delegate];
            
            break;
            
        case SMPlatformTypeUnknow:
            
            return NO;
            
            break;
    }
}

#pragma mark - Login
+ (void)qqLogin
{
    [[SMShareManager shareManager].tencent authorize];
}

+ (void)wechatLoginWithOpenId:(NSString *)openId appSecret:(NSString *)appSecret viewController:(UIViewController*)viewController delegate:(id<SMShareManagerProtocol>)delegate
{
    [[SMShareManager shareManager].wechat authorizeWithOpenId:openId appSecret:appSecret viewController:viewController delegate:delegate];
}

+ (void)weiboLoginWithRedirectURI:(NSString *)redirectURI
{
    [[SMShareManager shareManager].weibo authorizeWithRedirectURI:redirectURI];
}

#pragma mark - Share
+ (void)showShareViewWithShareType:(SMShareType)shareType shareParam:(SMActionParam *)param
{
    SMShareView *shareView = [SMShareView shareViewWithShareType:shareType shareParam:param];
    
    [shareView show];
}

+ (void)shareWithPlatformType:(SMPlatformType)platformType  shareType:(SMShareType)shareType param:(SMActionParam *)param
{
    switch (platformType)
    {
        case SMPlatformTypeQQCollect:
             [self shareToQQCollectWithParam:param];
            break;
           
        case SMPlatformTypeQQ:
            [self shareToQQWithShareType:shareType param:param];
            break;
            
        case SMPlatformTypeQQZone:
            [self shareToQQZoneWithShareType:shareType param:param];
            break;
 
        case SMPlatformTypeWXSession:
        case SMPlatformTypeWXTimeline:
        case SMPlatformTypeWXCollect:
            
            [self shareToWeChatWithPlatform:platformType shareType:shareType param:param];
            
            break;
            
        case SMPlatformTypeWeibo:
            
            [self shareToWeiboShareType:shareType param:param];
            
            break;
            
        case SMPlatformTypeUnknow:
#warning TODO - unknow
            break;

    }
}

#pragma mark - Weibo Share
+ (void)shareToWeiboShareType:(SMShareType)shareType param:(SMActionParam *)param
{
    SMWeiboActionType actionType;
    switch (shareType)
    {
        case SMShareTypeMessage:
            actionType = SMWeiboActionTypeText;
            break;
            
        case SMShareTypeImage:
            actionType = SMWeiboActionTypeImage;
            break;
            
        case SMShareTypeNewsNetThumbnail:
            actionType = SMWeiboActionTypeNewsNetThumbnail;
            break;
            
        case SMShareTypeNewsLocalThumbnail:
            actionType = SMWeiboActionTypeNewsLocalThumbnail;
            break;
            
        case SMShareTypeMusic:
            actionType = SMWeiboActionTypeMusic;
            break;
            
        case SMShareTypeMovie:
            actionType = SMWeiboActionTypeMovie;
            break;
            
        case SMShareTypeDataline:
            actionType = SMWeiboActionTypeDataline;
            break;
            
    }
    
    [[SMShareManager shareManager].weibo sendWeChatActionType:actionType param:param];
}

#pragma mark - WeChat Share
+ (void)shareToWeChatWithPlatform:(SMPlatformType)platformType shareType:(SMShareType)shareType param:(SMActionParam *)param
{
    SMWeChatActionType actionType;
    switch (shareType)
    {
        case SMShareTypeMessage:
            actionType = SMWeChatActionTypeShareText;
            break;
            
        case SMShareTypeImage:
            actionType = SMWeChatActionTypeShareImage;
            break;
            
        case SMShareTypeNewsNetThumbnail:
            actionType = SMWeChatActionTypeShareLink;
            break;
            
        case SMShareTypeNewsLocalThumbnail:
            actionType = SMWeChatActionTypeShareLink;
            break;
            
        case SMShareTypeMusic:
            actionType = SMWeChatActionTypeShareMusic;
            break;
            
        case SMShareTypeMovie:
            actionType = SMWeChatActionTypeShareMovie;
            break;
            
        case SMShareTypeDataline:
            actionType = SMWeChatActionTypeShareFile;
            break;
            
    }
    
    [[SMShareManager shareManager].wechat sendWeChatActionType:actionType platform:platformType param:param];
}

#pragma mark - QQCollectShare
+ (void)shareToQQCollectWithParam:(SMActionParam *)param
{
    [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareLinkQQCollectNetThumbnail param:param];
}

#pragma mark - QQ Share
+ (void)shareToQQWithShareType:(SMShareType)shareType param:(SMActionParam *)param
{
    switch (shareType)
    {
        case SMShareTypeMessage:
             [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareText param:param];
            break;
            
        case SMShareTypeImage:
             [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareImage param:param];
            break;
            
        case SMShareTypeNewsNetThumbnail:
            [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareLinkNewsNetThumbnail param:param];
            break;
            
        case SMShareTypeNewsLocalThumbnail:
            [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareLinkNewsLocalThumbnail param:param];
            break;
            
        case SMShareTypeMusic:
             [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareLinkMusicLocalThumbnail param:param];
            break;
            
        case SMShareTypeMovie:
            [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareLinkMovieLocalThumbnail param:param];
            break;
            
        case SMShareTypeDataline:
            [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareMyComputerLocalThumbnail param:param];
            break;
    }
}

#pragma mark - QQZone Share
+ (void)shareToQQZoneWithShareType:(SMShareType)shareType param:(SMActionParam *)param
{
    switch (shareType)
    {
 
        case SMShareTypeNewsNetThumbnail:
            [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareQQZoneLinkNewsNetThumbnail param:param];
            break;
            
        case SMShareTypeNewsLocalThumbnail:
            [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareQQZoneLinkNewsLocalThumbnail param:param];
            break;
            
        case SMShareTypeMusic:
            [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareQQZoneLinkMusicLocalThumbnail param:param];
            break;
            
        case SMShareTypeMovie:
            [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareQQZoneLinkMovieLocalThumbnail param:param];
            break;
            
        default:
            
            // 不支持，将报参数错误
            [[SMShareManager shareManager].tencent sendTencentActionWithType:SMTencentActionTypeShareText param:nil];
            
            break;
    }
}

#pragma mark - Setter & Getter
- (SMTencent *)tencent
{
    if (!_tencent)
    {
        _tencent = [[SMTencent alloc] init];
    }
    
    return _tencent;
}

- (SMWeChat *)wechat
{
    if (!_wechat)
    {
        _wechat = [[SMWeChat alloc] init];
    }
    return _wechat;
}

- (SMWeibo *)weibo
{
    if (!_weibo)
    {
        _weibo = [[SMWeibo alloc] init];
    }
    
    return _weibo;
}

@end
