//
//  SMWeChatAction.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/30.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "SMWeChatAction.h"
#import "WXApiObject.h"
#import "SMActionParam.h"
#import "WXApiRequestHandler.h"
@implementation SMWeChatAction
+ (SMActionResult)sendWeChatActionType:(SMWeChatActionType)acitonType platform:(SMPlatformType)platformType param:(SMActionParam *)param
{
    enum WXScene scene;
    switch (platformType)
    {
        case SMPlatformTypeWXSession:
            scene = WXSceneSession;
            break;
        case SMPlatformTypeWXTimeline:
            scene = WXSceneTimeline;
            break;
        case SMPlatformTypeWXCollect:
            scene = WXSceneFavorite;
            break;
            
        default:
            return SMActionResultArgumentError;
            break;
    }
    
    switch (acitonType) {
            
        case SMWeChatActionTypeShareText:
            return [self sendTextWithScene:scene param:param];
            break;
            
        case SMWeChatActionTypeShareImage:
            return [self sendImageWithScene:scene param:param];
            break;
            
        case SMWeChatActionTypeShareLink:
            return [self sendLinkWithScene:scene param:param];
            break;
            
        case SMWeChatActionTypeShareMusic:
            return [self sendMusicWithScene:scene param:param];
            break;
            
        case SMWeChatActionTypeShareMovie:
            return [self sendMovieWithScene:scene param:param];
            break;
            
        case SMWeChatActionTypeShareGifFace:
            return [self sendFaceGifWithScene:scene param:param];
            break;
            
        case SMWeChatActionTypeShareNonGifFace:
            return [self sendFaceNoGifWithScene:scene param:param];
            break;
            
        case SMWeChatActionTypeShareFile:
            return [self sendFileWithScene:scene param:param];
            break;
    }
}

+ (SMActionResult)sendTextWithScene:(enum WXScene)scene param:(SMActionParam *)param
{
    BOOL status = [WXApiRequestHandler sendText:param.textMessage
                          InScene:scene];
    
    return status?SMActionResultSuccess:SMActionResultFail;
}

+ (SMActionResult)sendImageWithScene:(enum WXScene)scene param:(SMActionParam *)param
{
    BOOL status = [WXApiRequestHandler sendImageData:param.imageData
                               TagName:@"WECHAT_TAG_JUMP_APP"
                            MessageExt:@"发送图片"
                                Action:@"<action>dotalist</action>"
                            ThumbImage:[UIImage imageWithData:param.thumbnailData]
                               InScene:scene];
    return status?SMActionResultSuccess:SMActionResultFail;
}

+ (SMActionResult)sendLinkWithScene:(enum WXScene)scene param:(SMActionParam *)param
{
    BOOL status = [WXApiRequestHandler sendLinkURL:param.audioUrl.absoluteString
                             TagName:@"WECHAT_TAG_JUMP_SHOWRANK"
                               Title:param.title
                         Description:param.desc
                          ThumbImage:[UIImage imageWithData:param.thumbnailData]
                             InScene:scene];
    return status?SMActionResultSuccess:SMActionResultFail;
}

+ (SMActionResult)sendMusicWithScene:(enum WXScene)scene param:(SMActionParam *)param
{
    BOOL status = [WXApiRequestHandler sendMusicURL:param.musicUrl.absoluteString
                              dataURL:param.audioUrl.absoluteString
                                Title:param.title
                          Description:param.desc
                           ThumbImage:[UIImage imageWithData:param.thumbnailData]
                              InScene:scene];
    return status?SMActionResultSuccess:SMActionResultFail;
}

+ (SMActionResult)sendMovieWithScene:(enum WXScene)scene param:(SMActionParam *)param
{
    BOOL status = [WXApiRequestHandler sendVideoURL:param.audioUrl.absoluteString
                                Title:param.title
                          Description:param.desc
                           ThumbImage:[UIImage imageWithData:param.thumbnailData]
                              InScene:scene];
    return status?SMActionResultSuccess:SMActionResultFail;
}

+ (SMActionResult)sendFaceNoGifWithScene:(enum WXScene)scene param:(SMActionParam *)param
{
    BOOL status = [WXApiRequestHandler sendEmotionData:param.imageData
                              ThumbImage:[UIImage imageWithData:param.thumbnailData]
                                 InScene:scene];
    return status?SMActionResultSuccess:SMActionResultFail;
}

+ (SMActionResult)sendFaceGifWithScene:(enum WXScene)scene param:(SMActionParam *)param
{
    BOOL status = [WXApiRequestHandler sendEmotionData:param.imageData
                              ThumbImage:[UIImage imageWithData:param.thumbnailData]
                                 InScene:scene];
    return status?SMActionResultSuccess:SMActionResultFail;
}

+ (SMActionResult)sendFileWithScene:(enum WXScene)scene param:(SMActionParam *)param
{
    BOOL status = [WXApiRequestHandler sendFileData:param.fileData
                        fileExtension:param.fileExtension
                                Title:param.title
                          Description:param.desc
                           ThumbImage:[UIImage imageWithData:param.thumbnailData]
                              InScene:scene];
    return status?SMActionResultSuccess:SMActionResultFail;
}

@end
