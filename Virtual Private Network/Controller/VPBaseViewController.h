//
//  VPBaseViewController.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPBaseViewController : UIViewController
@property (nonatomic, assign) BOOL isHideBackItem;
@property (nonatomic, copy)NSString *titleString;
- (BOOL)gestureRecognizerShouldBegin;
-(NSString *)backItemImageName;

@end
