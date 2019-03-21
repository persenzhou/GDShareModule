//
//  SMWeiboAction.m
//  GDShareModuleProject
//
//  Created by Apple on 2017/1/3.
//  Copyright © 2017年 SM. All rights reserved.
//

#import "SMWeiboAction.h"
#import "WeiboSDK.h"
#import "SMActionParam.h"


@implementation SMWeiboAction

+ (SMActionResult)sendWeiboActionType:(SMWeiboActionType)actionType param:(SMActionParam *)param accessToken:(NSString *)accessToken
{
    WBMessageObject *message = [self messageWithActionType:actionType param:param];
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:[self authInfoWithRedirectURI:param.redirectURI] access_token:accessToken];
    
    request.userInfo = @{@"Methoe":@"ShareAction"};
    
    BOOL success = [WeiboSDK sendRequest:request];
    
    SMActionResult result = success?SMActionResultSuccess:SMActionResultFail;
    
    return result;
}

+ (WBAuthorizeRequest *)authInfoWithRedirectURI:(NSString *)redirectURI
{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = redirectURI;
    authRequest.scope = @"all";

    return authRequest;
}

+ (WBMessageObject *)messageWithActionType:(SMWeiboActionType)actionType param:(SMActionParam *)param
{
    switch (actionType) {
            
        case SMWeiboActionTypeText:
            return [self textMessageWithParam:param];
            break;
            
        case SMWeiboActionTypeImage:
            return [self imageMessageWithParam:param];
            break;

        case SMWeiboActionTypeMovie:
            return [self movieMessageWithParam:param];
            break;
            
        case SMWeiboActionTypeMusic:
            return [self musicMessageWithParam:param];
            break;
            
        case SMWeiboActionTypeNewsNetThumbnail:
            return [self webpageMessageWithParam:param];
            break;
            
        case SMWeiboActionTypeNewsLocalThumbnail:
            return [self webpageMessageWithParam:param];
            break;
            
        case SMWeiboActionTypeDataline:
            return [self movieStreamMessageWithParam:param];
            break;
    }
}

+ (WBMessageObject *)textMessageWithParam:(SMActionParam *)param
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = param.textMessage;
    
    return message;
}

+ (WBMessageObject *)imageMessageWithParam:(SMActionParam *)param
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = param.textMessage;
    
    WBImageObject *imageObject = [WBImageObject object];
    imageObject.imageData = param.imageData;
    
    message.imageObject = imageObject;
    
    return message;
}

+ (WBMessageObject *)movieMessageWithParam:(SMActionParam *)param
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = param.textMessage;
    
    WBVideoObject *mediaObject = [WBVideoObject object];
    mediaObject.objectID = [NSDate date].description;
    mediaObject.title = param.title;
    mediaObject.description = param.desc;
    mediaObject.thumbnailData = param.thumbnailData;
    mediaObject.videoUrl = param.audioUrl.absoluteString;
    mediaObject.videoLowBandUrl = param.previewUrl.absoluteString;
    
    message.mediaObject = mediaObject;
    
    return message;
}

+ (WBMessageObject *)movieStreamMessageWithParam:(SMActionParam *)param
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = param.textMessage;
    
    WBVideoObject *mediaObject = [WBVideoObject object];
    mediaObject.objectID = [NSDate date].description;
    mediaObject.title = param.title;
    mediaObject.description = param.desc;
    mediaObject.thumbnailData = param.thumbnailData;
    mediaObject.videoStreamUrl = param.audioUrl.absoluteString;
    mediaObject.videoLowBandStreamUrl = param.previewUrl.absoluteString;
    
    message.mediaObject = mediaObject;
    
    return message;
}

+ (WBMessageObject *)musicMessageWithParam:(SMActionParam *)param
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = param.textMessage;
    
    WBVideoObject *mediaObject = [WBVideoObject object];
    mediaObject.objectID = [NSDate date].description;
    mediaObject.title = param.title;
    mediaObject.description = param.desc;
    mediaObject.thumbnailData = param.thumbnailData;
    mediaObject.videoUrl = param.audioUrl.absoluteString;
    mediaObject.videoLowBandUrl = param.previewUrl.absoluteString;
    
    message.mediaObject = mediaObject;
    
    return message;
}

+ (WBMessageObject *)webpageMessageWithParam:(SMActionParam *)param
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = param.textMessage;
    
    WBWebpageObject *mediaObject = [WBWebpageObject object];
    mediaObject.objectID = [NSDate date].description;
    mediaObject.title = param.title;
    mediaObject.description = param.desc;
    mediaObject.thumbnailData = param.thumbnailData;
    mediaObject.webpageUrl = param.audioUrl.absoluteString;

    message.mediaObject = mediaObject;
    
    return message;
}

@end
