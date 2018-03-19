//
//  VPHomeViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPHomeViewController.h"
#import "VPSelectRouteViewController.h"
@interface VPHomeViewController ()

@end

@implementation VPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString=@"HOME";
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.chooseLineButton];
    [self.view addSubview:self.countryImageView];
    [self.view addSubview:self.countryNameLabel];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
    [self.view addSubview:self.startButton];
    
}
- (UIButton *)chooseLineButton{
    if (!_chooseLineButton) {
        _chooseLineButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 78, 150, 45)];
        _chooseLineButton.backgroundColor=[UIColor clearColor];
        _chooseLineButton.layer.cornerRadius=22.5;
        _chooseLineButton.layer.borderColor=[UIColor whiteColor].CGColor;
        [_chooseLineButton setTitle:@"Choose Line" forState:UIControlStateNormal];
        _chooseLineButton.layer.borderWidth=1;
        [_chooseLineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_chooseLineButton addTarget:self action:@selector(chooseRoutLine) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseLineButton;
}
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 275)];
        _backImageView.image=[UIImage imageNamed:@"背景未连接"];
    }
    return _backImageView;
}

- (UIImageView *)countryImageView{
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
        [_leftButton addTarget:self action:@selector(chooseRoutLine) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton=[[UIButton alloc]initWithFrame:CGRectMake(_countryImageView.frame.origin.x+_countryImageView.frame.size.width+35, _leftButton.frame.origin.y, 20, 20)];
        [_rightButton addTarget:self action:@selector(chooseRoutLine) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rightButton;
}
- (UIButton *)startButton{
    if (!_startButton) {
        _startButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-220)/2, SCREEN_HEIGHT-TABBAR_HEIGHT-119-80-NAVBAR_HEIGHT, 220, 80)];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(startConnct) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

#pragma mark 开始连接
- (void)startConnct{
    
}
#pragma mark 选择线路
-(void)chooseRoutLine{
    VPSelectRouteViewController *selectRout=[[VPSelectRouteViewController alloc]init];
    selectRout.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:selectRout animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
