//
//  SMTencentAction.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/29.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "SMTencentAction.h"

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import "SMActionParam.h"

#import "NSString+GDShareModule.h"

@implementation SMTencentAction

+ (SMActionResult)sendTencentActionWithType:(SMTencentActionType)acitonType param:(SMActionParam *)param
{
    switch (acitonType)
    {
        case SMTencentActionTypeShareText:
            return  [self shareTextMessageWithParam:param];
            break;
            
        case SMTencentActionTypeShareImage:
            return [self shareImageMessageWithParam:param];
            break;
            
        case SMTencentActionTypeShareLinkNewsNetThumbnail:
            return [self shareNewsMessageWithNetworkImageWithParan:param qqZone:NO];
            break;
            
        case SMTencentActionTypeShareQQZoneLinkNewsNetThumbnail:
            return [self shareNewsMessageWithNetworkImageWithParan:param qqZone:YES];
            break;
            
        case SMTencentActionTypeShareLinkNewsLocalThumbnail:
            return [self shareNewsMessageWithLocalImageWithParan:param qqZone:NO];
            break;
            
        case SMTencentActionTypeShareQQZoneLinkNewsLocalThumbnail:
            return [self shareNewsMessageWithLocalImageWithParan:param qqZone:YES];
            break;
            
        case SMTencentActionTypeShareLinkMusicLocalThumbnail:
            return [self shareAudioMessageWithParan:param qqZone:NO];
            break;
            
        case SMTencentActionTypeShareQQZoneLinkMusicLocalThumbnail:
            return [self shareAudioMessageWithParan:param qqZone:YES];
            break;
            
        case SMTencentActionTypeShareLinkMovieLocalThumbnail:
            return [self shareVideoMessageWithParan:param qqZone:NO];
            break;
            
        case SMTencentActionTypeShareQQZoneLinkMovieLocalThumbnail:
            return [self shareVideoMessageWithParan:param qqZone:YES];
            break;
            
        case SMTencentActionTypeShareLinkQQCollectNetThumbnail:
            return [self shareToQQFavoriteWithParan:param];
            break;
        case SMTencentActionTypeShareMyComputerLocalThumbnail:
            return [self shareToDatalineWithParan:param];
            break;
        case SMTencentActionTypeWPA:
            return [self openQQWPAWithParan:param];
            break;
        case SMTencentActionrTypeGroupWPA:
            return [self openGroupChatWithParan:param];
            break;
        case SMTencentActionTypePay:
            return SMActionResultUnKnow;
            break;
    }
}

+ (SMActionResult)shareTextMessageWithParam:(SMActionParam *)param
{
    
    if ([param.textMessage sm_emptyString])
    {
        return SMActionResultArgumentError;
    }
    
    QQApiTextObject* txtObj = [QQApiTextObject objectWithText:param.textMessage];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:txtObj];
    
    QQApiSendResultCode result = [QQApiInterface sendReq:req];
    
    return [self handleSendResult:result];
}

+ (SMActionResult)shareImageMessageWithParam:(SMActionParam *)param
{
    QQApiImageObject* img = [QQApiImageObject objectWithData:param.imageData previewImageData:param.thumbnailData title:param.title description:param.desc];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    return [self handleSendResult:sent];
}

+ (SMActionResult)shareNewsMessageWithNetworkImageWithParan:(SMActionParam *)param qqZone:(BOOL)qqZone
{
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:param.audioUrl title:param.title description:param.desc previewImageURL:param.previewUrl];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent;
    if (qqZone)
    {
        sent = [QQApiInterface SendReqToQZone:req];
    }
    else
    {
        sent = [QQApiInterface sendReq:req];
    }
    
    return [self handleSendResult:sent];
}

+ (SMActionResult)shareNewsMessageWithLocalImageWithParan:(SMActionParam *)param qqZone:(BOOL)qqZone
{
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:param.audioUrl title:param.title description:param.desc previewImageData:param.thumbnailData];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent;
    if (qqZone)
    {
        sent = [QQApiInterface SendReqToQZone:req];
    }
    else
    {
        sent = [QQApiInterface sendReq:req];
    }
    return [self handleSendResult:sent];
}

+ (SMActionResult)shareAudioMessageWithParan:(SMActionParam *)param qqZone:(BOOL)qqZone
{
    QQApiAudioObject* img = [QQApiAudioObject objectWithURL:param.audioUrl title:param.title description:param.desc previewImageData:param.thumbnailData];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent;
    if (qqZone)
    {
        sent = [QQApiInterface SendReqToQZone:req];
    }
    else
    {
        sent = [QQApiInterface sendReq:req];
    }
    return [self handleSendResult:sent];
}

+ (SMActionResult)shareVideoMessageWithParan:(SMActionParam *)param qqZone:(BOOL)qqZone
{
    QQApiNewsObject* img = [QQApiNewsObject objectWithURL:param.audioUrl title:param.title description:param.desc previewImageData:param.thumbnailData];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent;
    if (qqZone)
    {
        sent = [QQApiInterface SendReqToQZone:req];
    }
    else
    {
        sent = [QQApiInterface sendReq:req];
    }
    return [self handleSendResult:sent];
}

+ (SMActionResult)shareToQQFavoriteWithParan:(SMActionParam *)param
{
    QQApiNewsObject* imgObj = [QQApiNewsObject objectWithURL:param.audioUrl title:param.title description:param.desc previewImageURL:param.previewUrl];
    
    [imgObj setCflag:kQQAPICtrlFlagQQShareFavorites];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    return [self handleSendResult:sent];
}

+ (SMActionResult)shareToDatalineWithParan:(SMActionParam *)param
{
    QQApiImageObject* img = [QQApiImageObject objectWithData:param.imageData previewImageData:param.thumbnailData title:param.title description:param.desc];
    
    [img setCflag:kQQAPICtrlFlagQQShareDataline];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    return [self handleSendResult:sent];
}

+ (SMActionResult)openQQWPAWithParan:(SMActionParam *)param
{
    if ([param.serviceQQ sm_emptyString])
    {
        return SMActionResultArgumentError;
    }
    
    QQApiWPAObject *wpaObj = [QQApiWPAObject objectWithUin:param.serviceQQ];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:wpaObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    return [self handleSendResult:sent];
}

+ (SMActionResult)openGroupChatWithParan:(SMActionParam *)param
{
    if ([param.groupNum sm_emptyString])
    {
        return SMActionResultArgumentError;
    }
    
    QQApiGroupChatObject *wpaObj = [QQApiGroupChatObject objectWithGroup:param.groupNum];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:wpaObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    return [self handleSendResult:sent];
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
