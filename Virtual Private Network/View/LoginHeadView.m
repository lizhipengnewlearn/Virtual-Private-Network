//
//  LoginHeadView.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LoginHeadView.h"

@implementation LoginHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImageView];
        [self addSubview:self.usernameLabel];
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

- (CustomLabel *)usernameLabel{
    
    if (!_usernameLabel) {
        _usernameLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(_headImageView.frame.size.width+_headImageView.frame.origin.x+25, _headImageView.frame.origin.y+8, 150, 38.5)];
    }
    return _usernameLabel;
}
@end
