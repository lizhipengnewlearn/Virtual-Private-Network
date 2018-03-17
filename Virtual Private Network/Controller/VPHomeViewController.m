//
//  VPHomeViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPHomeViewController.h"

@interface VPHomeViewController ()

@end

@implementation VPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 275)];
        _backImageView.image=[UIImage imageNamed:@"背景未连接"];
    }
    return _backImageView;
}

- (CustomLabel *)countryImageView{
    if (!_countryImageView) {
        _countryImageView=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-119)/2, 59, 119, 73)];
    }
    return _countryImageView;
}

-(CustomLabel *)countryNameLabel{
    if (!_countryNameLabel) {
        _countryNameLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, _countryImageView.frame.size.height+_countryNameLabel.frame.origin.y+23, SCREEN_WIDTH, 25) andTextColor:[UIColor whiteColor] andSize:25];
    }
    return _countryNameLabel;
}
- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton=[[UIButton alloc]initWithFrame:CGRectMake(_countryImageView.frame.origin.x-35, _countryImageView.frame.origin.y+26, 20, 20)];
    }
    return _leftButton;
}

- ()
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
