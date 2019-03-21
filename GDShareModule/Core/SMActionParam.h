//
//  SMActionParam.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/29.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMActionParam : NSObject

/* 
 分享类型
 SMShareTypeMessage,// 文本分享
 SMShareTypeImage,// 图片分享
 SMShareTypeNewsNetThumbnail,//链接分享（网络图片）
 SMShareTypeNewsLocalThumbnail,//链接分享（本地图片）
 SMShareTypeMusic,//音乐分享
 SMShareTypeMovie,//视频分享
 SMShareTypeDataline,//数据分享（QQ 为 我的电脑  微信为分享文件 微博为视频流）
 
 各个平台 枚举对应的Param 参数
 
 QQ 分享
 注释 ： 分享文本 和 分享图片 只支持QQ客户端
 
 SMShareTypeMessage testMessage
 SMShareTypeImage title + desc + imageData + thumbnailData
 MShareTypeNewsNetThumbnail title + desc + audioUrl + previewUrl
 SMShareTypeNewsLocalThumbnail title + desc + audioUrl + thumbnailData
 SMShareTypeMusic title + desc + audioUrl + thumbnailData
 SMShareTypeMovie title + desc + audioUrl(h5地址) + thumbnailData
 SMShareTypeDataline title + desc + imageData + thumbnailData
 
 加 + 发送链接到QQ收藏(网络图片缩略图) title + desc + audioUrl + previewUrl
 
 
 
 微信分享
 
 SMShareTypeMessage testMessage
 SMShareTypeImage thumbnailData + imageData
 MShareTypeNewsNetThumbnail title + desc + audioUrl(web url) + thumbnailData
 SMShareTypeNewsLocalThumbnail title + desc + audioUrl(web url) + thumbnailData
 SMShareTypeMusic  title + desc + thumbnailData + audioUrl（data url）+ musicUrl
 SMShareTypeMovie  title + desc + thumbnailData + audioUrl (web url)
 SMShareTypeDataline（文件分享） title + desc + thumbnailData + fileData + fileExtension
 
 微博分享
 
 SMShareTypeMessage textMessage + redirectURI
 SMShareTypeImage textMessage +  imageData + redirectURI
 SMShareTypeMovie textMessage +  title + desc + thumbnailData + audioUrl(data url) + previewUrl(web url) + redirectURI
 SMShareTypeMusic  textMessage +  title + desc + thumbnailData + audioUrl（data url） + previewUrl(web url) + redirectURI
 
 MShareTypeNewsNetThumbnail textMessage +  title + desc + thumbnailData + audioUrl(web url) + redirectURI
 
 SMShareTypeNewsLocalThumbnail textMessage +  title + desc + thumbnailData + audioUrl(web url) + redirectURI
 
 SMShareTypeDataline(视频流) textMessage +  title + desc + thumbnailData + audioUrl（stream url） + previewUrl + redirectURI

 */



// 分享文本
@property (nonatomic, copy) NSString *textMessage;

// 分享图片
@property (nonatomic, copy) NSString *title;//分享标题
@property (nonatomic, copy) NSString *desc;//分享的描述
@property (nonatomic,strong)  NSData *imageData;// 图片数据
@property (nonatomic,strong)  NSData *thumbnailData;//用于预览的图片数据

// 分享音视频
@property (nonatomic,strong) NSURL *audioUrl;//音视频内容的目标URL
@property (nonatomic,strong) NSURL *previewUrl;//分享内容的预览图像URL


@property (nonatomic,strong)  NSData *fileData;// 文件数据
@property (nonatomic,copy)  NSString *fileExtension;// 文件缀

@property (nonatomic,strong) NSURL *musicUrl;//分享音乐url 微信使用


// QQWPA
@property (nonatomic, copy) NSString *serviceQQ;

// QQ群会话
@property (nonatomic, copy) NSString *groupNum;

// 微博分享 需要传的参数
@property (nonatomic, copy) NSString *redirectURI;

@end
