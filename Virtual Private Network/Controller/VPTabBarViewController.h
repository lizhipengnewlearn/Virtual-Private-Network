//
//  VPTabBarViewController.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPHomeViewController.h"
#import "VPMemberViewController.h"
#import "VPMyViewController.h"
@interface VPTabBarViewController : UITabBarController
@property (nonatomic, strong)VPHomeViewController *homeView;
@property (nonatomic, strong)VPMemberViewController *memberView;
@property (nonatomic, strong)VPMyViewController *myView;
+(instancetype)shareInstance;
@end
