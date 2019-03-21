//
//  SMShareView.m
//  ShareModuleProject
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 SM. All rights reserved.
//

#import "SMShareView.h"
#import "NSBundle+GDShareModule.h"

#import "SMShareManager.h"

#import "SMEnum.h"

@interface SMShareView()

@property (nonatomic,assign) SMShareType shareType;
@property (nonatomic,strong) SMActionParam *shareParam;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *shareButtons;

@end

@implementation SMShareView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupButtonImage];
}

#pragma mark - Public
+ (instancetype)shareViewWithShareType:(SMShareType)shareType shareParam:(SMActionParam *)param
{
    Class class = [SMShareView class];
    SMShareView *shareView = [[[NSBundle bundleForClass:class] loadNibNamed:NSStringFromClass(class) owner:nil options:nil] lastObject];
    shareView.frame = [UIScreen mainScreen].bounds;
    
    shareView.shareType = shareType;
    shareView.shareParam = param;
    
    return shareView;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss
{
    [self dismiss:nil];
}

#pragma mark - Actions
- (IBAction)shareAction:(UIButton *)sender {
    
    SMPlatformType platformType;
    switch (sender.tag)
    {
        case 0:
            platformType = SMPlatformTypeWXSession;
            break;
            
        case 1:
            platformType = SMPlatformTypeWXTimeline;
            break;
            
        case 2:
            platformType = SMPlatformTypeWXCollect;
            break;
            
        case 3:
            platformType = SMPlatformTypeWeibo;
            break;
            
        case 4:
            platformType = SMPlatformTypeQQ;
            break;
            
        case 5:
            platformType = SMPlatformTypeQQZone;
            break;
            
        default:
            break;
    }
    
    [SMShareManager shareWithPlatformType:platformType shareType:_shareType param:_shareParam];
    
    [self dismiss:nil];
    
}

- (IBAction)dismiss:(UIControl *)sender
{
    [self removeFromSuperview];
}


#pragma mark - Private

- (void)setupButtonImage
{
    for (UIButton *button in _shareButtons)
    {
        NSString *imageName;
        switch (button.tag)
        {
            case 0:
                imageName = @"sm_wx";
                break;
            case 1:
                imageName = @"sm_friendcircle";
                break;
            case 2:
                imageName = @"sm_wxcollection";
                break;
            case 3:
                imageName = @"sm_sina";
                break;
            case 4:
                imageName = @"sm_qq";
                break;
            case 5:
                imageName = @"sm_qqspace";
                break;
                
            default:
                break;
        }

        imageName = [NSString stringWithFormat:@"SMShareManager.bundle/%@",imageName];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
}
@end
