//
//  VPSelectRouteViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPSelectRouteViewController.h"
#import "RouteLine.h"
#import "RoutLineCell.h"
#import "PurchaseOrder.h"
#import "DateManager.h"
#import "VPLoginViewController.h"
@interface VPSelectRouteViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation VPSelectRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.titleString=@"LINE";
    [self loadData];
    
}
- (void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AVQuery *query=[AVQuery queryWithClassName:@"RouteLine"];
    [query orderByDescending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.dataArray=[NSMutableArray arrayWithArray:objects];
        [self.tableView reloadData];
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HEIGHT-TABBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=NO;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"RoutLineCell";
    RoutLineCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[RoutLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle=NO;
    RouteLine *routlineModel=_dataArray[indexPath.row];
    [cell setcontentWithModel:routlineModel];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectRouteBlock!=nil) {
        self.selectRouteBlock(_dataArray[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
//    if ([AVUser currentUser])
//    {
//            AVQuery *query=[AVQuery queryWithClassName:@"PurchaseOrder"];
//            [query whereKey:@"user" equalTo:[AVUser currentUser]];
//            [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//                if (objects.count>0) {
//                    PurchaseOrder *purchOrder=objects[0];
//                    NSString *endDateString=[DateManager stringFromDate:purchOrder.endDate];
//                    NSString *nowDateString=[DateManager stringFromDate:[NSDate date]];
//                    if ([self firstString:endDateString andSecondString:nowDateString]==YES) {//会员未到期
//                        if (self.selectRouteBlock!=nil) {
//                            self.selectRouteBlock(_dataArray[indexPath.row]);
//                        }
//                    }
//                }
//                else
//                {
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"This line is VIP line, please purchase VIP to try to connect" delegate:self cancelButtonTitle:@"Try later" otherButtonTitles:@"Buy now", nil];
//                    [alertView show];
//                }
//            }];
//    }
//    else
//    {
//        VPLoginViewController *loginView=[[VPLoginViewController alloc]init];
//        [self presentViewController:loginView animated:YES completion:nil];
//    }
    
}
-(BOOL)firstString:(NSString *)firstString andSecondString:(NSString*)secondString{
    int result=[firstString compare:secondString];
    if(result==NSOrderedDescending)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)returnRouteName:(SelectRouteBlock)block{
    self.selectRouteBlock = block;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
