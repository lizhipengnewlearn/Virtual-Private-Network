//
//  VPRegisterViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPRegisterViewController.h"
#import "MBProgressHUD+Add.h"
@interface VPRegisterViewController ()

@end

@implementation VPRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.backButton];
    [self.view addSubview:self.usernameTextFiled];
    [self.view addSubview:self.firstLineView];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.secondLineView];
    [self.view addSubview:self.regiterButton];
}
- (UIButton *)backButton{
    if (!_backButton) {
        _backButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-22-30, 42, 30, 30)];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"dissback"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
- (void)backButtonClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (UITextField *)usernameTextFiled{
    if (!_usernameTextFiled) {
        _usernameTextFiled=[[UITextField alloc]initWithFrame:CGRectMake(15, 143, SCREEN_WIDTH-30, 53)];
        _usernameTextFiled.placeholder=@"username";
        _usernameTextFiled.textAlignment=NSTextAlignmentCenter;
    }
    return _usernameTextFiled;
}
- (UIView *)firstLineView{
    if (!_firstLineView) {
        _firstLineView=[[UIView alloc]initWithFrame:CGRectMake(_usernameTextFiled.frame.origin.x, _usernameTextFiled.frame.size.height+_usernameTextFiled.frame.origin.y, _usernameTextFiled.frame.size.width, 0.5)];
        _firstLineView.backgroundColor=LINE_COLOR;
    }
    return _firstLineView;
}
- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(15, _firstLineView.frame.size.height+_firstLineView.frame.origin.y, _usernameTextFiled.frame.size.width, _usernameTextFiled.frame.size.height)];
        _passwordTextField.secureTextEntry=YES;
        _passwordTextField.textAlignment=NSTextAlignmentCenter;
        _passwordTextField.placeholder=@"password";
    }
    return _passwordTextField;
}
- (UIView *)secondLineView{
    if (!_secondLineView) {
        _secondLineView=[[UIView alloc]initWithFrame:CGRectMake(_passwordTextField.frame.origin.x, _passwordTextField.frame.size.height+_passwordTextField.frame.origin.y, _passwordTextField.frame.size.width, 0.5)];
        _secondLineView.backgroundColor=LINE_COLOR;
    }
    return _secondLineView;
}

- (UIButton *)regiterButton{
    if (!_regiterButton) {
        _regiterButton=[[UIButton alloc]initWithFrame:CGRectMake(_usernameTextFiled.frame.origin.x, _secondLineView.frame.size.height+_secondLineView.frame.origin.y+32, _usernameTextFiled.frame.size.width, 44)];
        _regiterButton.backgroundColor=HOMEGREEN_COLOR;
        [_regiterButton addTarget:self action:@selector(regiterButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_regiterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _regiterButton.layer.cornerRadius=22;
        _regiterButton.layer.masksToBounds=YES;
        [_regiterButton setTitle:@"Regiteration" forState:UIControlStateNormal];
    }
    return _regiterButton;
}

- (void)regiterButtonClick{
    if (_usernameTextFiled.text.length==0) {
        [MBProgressHUD showError:@"please input a username" toView:self.view];
        return;
    }
    if (_passwordTextField.text.length==0) {
        [MBProgressHUD showError:@"please input password" toView:self.view];
    }
    
    AVUser *user=[[AVUser alloc]init];
    [user setUsername:_usernameTextFiled.text];
    [user setPassword:_passwordTextField.text];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (succeeded) {
            [MBProgressHUD showError:@"reigster success" toView:self.view];
            [self performSelector:@selector(dismissLastView) withObject:self afterDelay:0.5];

        }
        else
        {
            [MBProgressHUD showError:@"register failed" toView:self.view];
            
        }
    }];
}
- (void)dismissLastView{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:loginSuccess object:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
