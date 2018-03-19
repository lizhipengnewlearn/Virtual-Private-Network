//
//  VPHomeViewController.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
#import "VPBaseViewController.h"
@interface VPHomeViewController : VPBaseViewController
@property (nonatomic, strong)UIImageView *backImageView;

@property (nonatomic, strong)UIButton *chooseLineButton;

@property (nonatomic, strong)UIButton *startButton;

@property (nonatomic, strong)CustomLabel *countryNameLabel;

@property (nonatomic, strong)UIImageView *countryImageView;

@property (nonatomic, strong)UIButton *leftButton;

@property (nonatomic, strong)UIButton *rightButton;


@end
