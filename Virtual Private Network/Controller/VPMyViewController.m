//
//  VPMyViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPMyViewController.h"
#import "MyCell.h"
#import "VPAgreementViewController.h"
#import "VPAboutUsViewController.h"
#import "VPLoginViewController.h"
#import "PurchaseOrder.h"
#import "DateManager.h"
@interface VPMyViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@end

@implementation VPMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData];
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:loginSuccess object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:purchSuccess object:nil];

}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(BOOL)shouldAutorotate{
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=NO;
        _tableView.backgroundColor=[UIColor whiteColor];
        //_tableView.tableHeaderView=self.myHeadView;
    }
    return _tableView;
}
- (void)refreshData{
    if([AVUser currentUser])
    {
        _dataArray=@[@"Due to the time",@"The terms of service",@"Privacy policy",@"About us",@"logout"];
        AVQuery *query=[AVQuery queryWithClassName:@"PurchaseOrder"];
        [query whereKey:@"user" equalTo:[AVUser currentUser]];
        [query orderByDescending:@"endDate"];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count>0) {
                PurchaseOrder *purchaseOrder=[objects firstObject];
                NSString *endDateString=[DateManager stringToDayFromDate:purchaseOrder.endDate];
                MyCell *cell=(MyCell*)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                cell.contentLabel.text=endDateString;

            }
            else
                {
                    MyCell *cell=(MyCell*)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                    cell.contentLabel.text=@"";
                }
        }];
        [_tableView reloadData];

    }
    else
    {
        _dataArray=@[@"Due to the time",@"The terms of service",@"Privacy policy",@"About us"];
        MyCell *cell=(MyCell*)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.contentLabel.text=@"";
        [_tableView reloadData];


    }
    
}

- (MyHeadView *)myHeadView{
    if (!_myHeadView) {
        _myHeadView= [[MyHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 172)];
        _myHeadView.backgroundColor=[UIColor whiteColor];
        [_myHeadView.loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myHeadView;
}
- (LoginHeadView *)loginHeadView{
    if (!_loginHeadView) {
        _loginHeadView=[[LoginHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 172)];
        _loginHeadView.backgroundColor=[UIColor whiteColor];
    }
    return _loginHeadView;
}
- (void)loginButtonClick{
 
    VPLoginViewController *loginView=[[VPLoginViewController alloc]init];
    [self.navigationController presentViewController:loginView animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"MyCell";
    MyCell *cell=(MyCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.titleLabel.text=_dataArray[indexPath.row];
    if (indexPath.row==0||indexPath.row==3) {
        cell.rightImagView.hidden=YES;
    }
    else
    {
        cell.rightImagView.hidden=NO;
    }
    if (indexPath.row==3) {
        cell.contentLabel.text=@"V1.0.0";
    }
    
    cell.selectionStyle=NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if([AVUser currentUser])
    {
        self.loginHeadView.usernameLabel.text=[AVUser currentUser].username;
        return _loginHeadView;
    }
    else
    {
        return self.myHeadView;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 172;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==1) {
        VPAgreementViewController *agreementView=[[VPAgreementViewController alloc]init];
        agreementView.agreementType=VPAgreementTypePolicy;
        agreementView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:agreementView animated:YES];
    }
    else if (indexPath.row==2)
    {
        VPAgreementViewController *agreementView=[[VPAgreementViewController alloc]init];
        agreementView.agreementType=VPAgreementTypeService;
        agreementView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:agreementView animated:YES];
    }
    else if(indexPath.row==3)
    {
        VPAboutUsViewController *aboutUsView=[[VPAboutUsViewController alloc]init];
        aboutUsView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:aboutUsView animated:YES];
    }
    else if(indexPath.row==4)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"waring" message:@"logot?" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"yes", nil];
        [alertView show];
      
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        [AVUser logOut];
        [self refreshData];
        [[NSNotificationCenter defaultCenter]postNotificationName:loginSuccess object:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:loginSuccess object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:purchSuccess object:nil];

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
