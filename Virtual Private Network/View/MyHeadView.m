//
//  MyHeadView.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MyHeadView.h"

@implementation MyHeadView


- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImageView];
        [self addSubview:self.loginButton];
    }
    return self;
}


- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(25, 83, 55, 55)];
        _headImageView.image=[UIImage imageNamed:@"头像"];
    }
    return _headImageView;
}

- (UIButton *)loginButton{
    
    if (!_loginButton) {
        _loginButton=[[UIButton alloc]initWithFrame:CGRectMake(_headImageView.frame.size.width+_headImageView.frame.origin.x+25, _headImageView.frame.origin.y+8, 82, 38.5)];
        _loginButton.backgroundColor=[UIColor colorWithHexString:@"31cd40"];
        _loginButton.layer.cornerRadius=19;
        _loginButton.layer.masksToBounds=YES;
        [_loginButton setTitle:@"login" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _loginButton;
}

@end
