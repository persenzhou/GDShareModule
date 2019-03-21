//
//  TableViewController.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/30.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "TableViewController.h"
#import "SMShareManager.h"
#import "SMCounseler.h"
#import "SMActionParam.h"
#import "SMCounseler.h"
#import "SMUdeskUser.h"
#import "SMUdeskStyle.h"
#import "SMShareView.h"

#define kTencentAppID @"101055478"
#define kWeiXinAppKey @"wx8baf1de2a92d60c4"
#define kWeiXinAppSecret @"d4624c36b6795d1d99dcf0547af5443d"
#define kSinaRedirectURL @"http://www.gaodun.com/oauth/weibo/callback.php"
@interface TableViewController ()<SMShareManagerProtocol,UITableViewDelegate,UITableViewDataSource>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SMShareManager registerQQWithAppId:kTencentAppID delegate:self];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row)
    {
        case 0:
            [SMShareManager qqLogin];
            break;
            
        case 1:
            [SMCounseler counselWithQQServise:@"2355467337"];
            break;
        case 2:
        {
            SMActionParam *param = [[SMActionParam alloc]init];
            //title + desc + imageData + thumbnailData

            param.title = @"分享测试";
            param.desc = @"分享测试";
            param.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"1"]);
            param.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"2"]);
            
            [SMShareManager shareWithPlatformType:SMPlatformTypeQQ shareType:SMShareTypeImage param:param];
        }
            break;
        case 3:
            [SMShareManager wechatLoginWithOpenId:kWeiXinAppKey appSecret:kWeiXinAppSecret viewController:self delegate:self];
            break;
        case 4:
            
        {
            SMActionParam *param = [[SMActionParam alloc]init];
            //imageData + thumbnailData
            param.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"1"]);
            param.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"2"]);
            
            [SMShareManager shareWithPlatformType:SMPlatformTypeWXTimeline shareType:SMShareTypeImage param:param];
        }
           
            
            break;
        case 5:
            
        {
            SMActionParam *param = [[SMActionParam alloc]init];
            //imageData + thumbnailData
            param.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"1"]);
            param.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"2"]);
            
            [SMShareManager shareWithPlatformType:SMPlatformTypeWXSession shareType:SMShareTypeImage param:param];
        }
            
            
            break;
        case 6:
            
        {
            SMActionParam *param = [[SMActionParam alloc]init];
            //imageData + thumbnailData
            param.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"1"]);
            param.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"2"]);
            
            [SMShareManager shareWithPlatformType:SMPlatformTypeWXCollect shareType:SMShareTypeImage param:param];
        }
            
            break;
            
        case 7:
            
        {
            [SMShareManager weiboLoginWithRedirectURI:kSinaRedirectURL];
        }
            
            break;
        case 8:
            
        {
            SMActionParam *param = [[SMActionParam alloc]init];
            //imageData + thumbnailData
            param.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"1"]);
            param.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"2"]);
            param.redirectURI = kSinaRedirectURL;
            
            [SMShareManager shareWithPlatformType:SMPlatformTypeWeibo shareType:SMShareTypeImage param:param];
        }
            
            break;
        case 9:
        {
            SMUdeskUser *user = [[SMUdeskUser alloc] init];
            user.nickName = @"匿名";
            user.sdk_token = @"user_id";
            user.email = @"persen.zhou@gaodun.com";
            user.phoneNum = @"18879148448";
            user.desc = @"用户描述";
            [SMCounseler configUser:user];
            
            SMUdeskStyle *style = [[SMUdeskStyle alloc] init];
            style.navigationColor = [UIColor redColor];
            style.titleColor = [UIColor whiteColor];
            
            [SMCounseler counselUdskWithOpenType:SMUdeskOpenTypePresent viewController:self uiStyle:style completion:nil];
            
        }
            
            break;
        case 10:
        {
            // 弹出 分享 界面
            
            SMActionParam *param = [[SMActionParam alloc]init];
            //imageData + thumbnailData
            
            param.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"1"]);
            param.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"2"]);
            
            [SMShareManager showShareViewWithShareType:SMShareTypeImage shareParam:param];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - SMShareManagerProtocol

- (void)shareManagerNetworkFail
{
    NSLog(@"shareManagerNetworkFail");
}

- (void)shareManagerLoginFailWithCancel:(BOOL)cancel
{
    NSLog(@"shareManagerLoginFailWithCancel");
}

- (void)shareManagerLoginSuccessWithUserInfomation:(SMOauthUser *)infomation
{
    NSLog(@"shareManagerLoginSuccessWithUserInfomation");
}

- (void)shareManagerActionResult:(SMActionResult)result
{
    // 分享的回调
    NSLog(@"shareManagerActionResult");
}

@end
