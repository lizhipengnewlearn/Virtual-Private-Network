//
//  VPLoginViewController.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPBaseViewController.h"
#import "CustomLabel.h"
@interface VPLoginViewController : VPBaseViewController
@property (nonatomic, strong)UITextField *usernameTextFiled;
@property (nonatomic, strong)UITextField *passwordTextField;
@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIView *firstLineView;
@property (nonatomic, strong)UIView *secondLineView;
@property (nonatomic, strong)UIButton *backButton;
@property (nonatomic, strong)UIButton *registerButton;
@property (nonatomic, strong)CustomLabel *informationLabel;
@property (nonatomic, strong)CustomLabel *secondInformatinLabel;

@end
