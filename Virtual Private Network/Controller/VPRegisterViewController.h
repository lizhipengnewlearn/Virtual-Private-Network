//
//  VPRegisterViewController.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPBaseViewController.h"

@interface VPRegisterViewController : VPBaseViewController
@property (nonatomic, strong)UITextField *usernameTextFiled;
@property (nonatomic, strong)UITextField *passwordTextField;
@property (nonatomic, strong)UIButton *regiterButton;
@property (nonatomic, strong)UIView *firstLineView;
@property (nonatomic, strong)UIView *secondLineView;
@property (nonatomic, strong)UIButton *backButton;
@end
