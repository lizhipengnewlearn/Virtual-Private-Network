//
//  VPLoginViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPLoginViewController.h"
#import "VPRegisterViewController.h"
#import "MBProgressHUD+Add.h"
@interface VPLoginViewController ()

@end

@implementation VPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.usernameTextFiled];
    [self.view addSubview:self.firstLineView];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.secondLineView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.informationLabel];
    [self.view addSubview:self.secondInformatinLabel];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backButtonClick) name:loginSuccess object:nil];
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
        _passwordTextField.textAlignment=NSTextAlignmentCenter;
        _passwordTextField.secureTextEntry=YES;
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

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton=[[UIButton alloc]initWithFrame:CGRectMake(_usernameTextFiled.frame.origin.x, _secondLineView.frame.size.height+_secondLineView.frame.origin.y+32, _usernameTextFiled.frame.size.width, 44)];
        _loginButton.backgroundColor=HOMEGREEN_COLOR;
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.cornerRadius=22;
        _loginButton.layer.masksToBounds=YES;
        [_loginButton setTitle:@"login" forState:UIControlStateNormal];
    }
    return _loginButton;
}
- (void)loginButtonClick{
    
    if (_usernameTextFiled.text.length==0) {
        [MBProgressHUD showError:@"please input a username" toView:self.view];
        return;
    }
    if(_passwordTextField.text.length==0)
    {
        [MBProgressHUD showError:@"please input password" toView:self.view];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AVUser logInWithUsernameInBackground:_usernameTextFiled.text password:_passwordTextField.text block:^(AVUser * _Nullable user, NSError * _Nullable error) {
       if(user)
       {
           [MBProgressHUD hideHUDForView:self.view animated:YES];
           [[NSNotificationCenter defaultCenter]postNotificationName:loginSuccess object:nil];
           [self dismissViewControllerAnimated:YES completion:nil];
       }
       else if(error.code==210)
       {
           [MBProgressHUD hideHUDForView:self.view animated:YES];
           [MBProgressHUD showError:@"the username and password mismatch" toView:self.view];
       }
        else if(error.code==211)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

             [MBProgressHUD showError:@"could not find user" toView:self.view];
        }
        else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"login failed please check the password" toView:self.view];
        }

    
    }];
}

- (UIButton *)registerButton{
    
    if (!_registerButton) {
        _registerButton=[[UIButton alloc]initWithFrame:CGRectMake(_usernameTextFiled.frame.origin.x, _loginButton.frame.size.height+_loginButton.frame.origin.y+37, _usernameTextFiled.frame.size.width, 15)];
        [_registerButton setTitleColor:HOMEGREEN_COLOR forState:UIControlStateNormal];
        _registerButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitle:@"New user registeation" forState:UIControlStateNormal];
    }
    return _registerButton;
}

- (CustomLabel *)informationLabel{
    if (!_informationLabel) {
        _informationLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-40-40, SCREEN_WIDTH, 15) andTextColor:[UIColor colorWithHexString:@"999999"] andSize:14];
        _informationLabel.textAlignment=NSTextAlignmentCenter;
        _informationLabel.text=@"Please remember your username";
    }
    return _informationLabel;
}
-(CustomLabel *)secondInformatinLabel{
    if (!_secondInformatinLabel) {
        _secondInformatinLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, _informationLabel.bottom+10, SCREEN_WIDTH, 15) andTextColor:[UIColor colorWithHexString:@"999999"] andSize:14];
        _secondInformatinLabel.textAlignment=NSTextAlignmentCenter;
        _secondInformatinLabel.text=@"and password to restore the purchase";
    }
    return _secondInformatinLabel;
}

- (void)registerButtonClick{
    
    VPRegisterViewController *registerView=[[VPRegisterViewController alloc]init];
    [self presentViewController:registerView animated:YES completion:nil];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:loginSuccess object:nil];
    
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
