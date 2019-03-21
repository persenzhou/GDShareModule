//
//  SMEnum.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#ifndef SMEnum_h
#define SMEnum_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,SMPlatformType){
    
    SMPlatformTypeUnknow,
    
    SMPlatformTypeQQ,
    SMPlatformTypeQQZone,// (不支持 文本和图片分享)
    SMPlatformTypeQQCollect,// (支持 SMShareTypeNewsNetThumbnail)
    
    SMPlatformTypeWXSession, //微信聊天界面
    SMPlatformTypeWXTimeline,//微信朋友圈
    SMPlatformTypeWXCollect,//微信收藏
    
    SMPlatformTypeWeibo,
};

typedef NS_ENUM(NSInteger, SMShareType){
    SMShareTypeMessage,// 文本分享
    SMShareTypeImage,// 图片分享
    SMShareTypeNewsNetThumbnail,//链接分享（网络图片）
    SMShareTypeNewsLocalThumbnail,//链接分享（本地图片）
    SMShareTypeMusic,//音乐分享
    SMShareTypeMovie,//视频分享
    SMShareTypeDataline,//本地数据分享（QQ 为 我的电脑  微信为分享文件）
};

typedef NS_ENUM(NSInteger,SMActionResult){
    SMActionResultSuccess,
    SMActionResultNotRegister,//App 未注册
    SMActionResultArgumentError,//发送参数错误
    SMActionResultNotInstalled,//您未安装应用
    SMActionResultNotSupport,//不支持此功能
    SMActionResultVersionOld,//当前版本太低
    SMActionResultFail,//发送失败
    SMActionResultUnKnow//未知错误
};


typedef NS_ENUM(NSInteger,SMWeChatActionType){
    SMWeChatActionTypeShareText,//分享文本消息
    SMWeChatActionTypeShareImage,//分享图片消息
    SMWeChatActionTypeShareLink,//分享链接消息
    SMWeChatActionTypeShareMusic,//分享音乐
    SMWeChatActionTypeShareMovie,//分享视频
    SMWeChatActionTypeShareGifFace,//分享gif表情
    SMWeChatActionTypeShareNonGifFace,//分享非gif表情
    SMWeChatActionTypeShareFile//分享文件消息
};


typedef NS_ENUM(NSInteger,SMTencentActionType)
{
    SMTencentActionTypeShareText,//分享文本消息
    SMTencentActionTypeShareImage,//分享图片消息
    
    
    SMTencentActionTypeShareLinkNewsNetThumbnail,//分享新闻链接消息(网络图片缩略图)
    SMTencentActionTypeShareQQZoneLinkNewsNetThumbnail,
    
    
    SMTencentActionTypeShareLinkNewsLocalThumbnail,//分享新闻链接消息(本地图片缩略图)
    SMTencentActionTypeShareQQZoneLinkNewsLocalThumbnail,
    
    SMTencentActionTypeShareLinkMusicLocalThumbnail,//分享音乐链接消息(本地图片缩略图)
    SMTencentActionTypeShareQQZoneLinkMusicLocalThumbnail,
    
    SMTencentActionTypeShareLinkMovieLocalThumbnail,//分享视频链接消息(本地图片缩略图)
    SMTencentActionTypeShareQQZoneLinkMovieLocalThumbnail,
    
    
    SMTencentActionTypeShareLinkQQCollectNetThumbnail,//发送链接到QQ收藏(网络图片缩略图)
    
    SMTencentActionTypeShareMyComputerLocalThumbnail,//发送图片到我的电脑(本地图片)
    
    SMTencentActionTypeWPA,//打开WPA临时会话
    SMTencentActionrTypeGroupWPA,//打开指定群会话
    SMTencentActionTypePay//手Q支付接口 （目前不支持）
};

typedef NS_ENUM(NSInteger,SMWeiboActionType){
    
    SMWeiboActionTypeText,
    SMWeiboActionTypeImage,
    SMWeiboActionTypeNewsNetThumbnail,
    SMWeiboActionTypeNewsLocalThumbnail,
    SMWeiboActionTypeMusic,
    SMWeiboActionTypeMovie,
    SMWeiboActionTypeDataline
};

#endif /* SMEnum_h */
