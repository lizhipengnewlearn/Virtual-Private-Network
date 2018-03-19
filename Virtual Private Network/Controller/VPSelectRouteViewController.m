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
    
    AVQuery *query=[AVQuery queryWithClassName:@"RouteLine"];
    [query orderByDescending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
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
    RouteLine *routlineModel=_dataArray[indexPath.row];
    [cell setcontentWithModel:routlineModel];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([AVUser currentUser])
    {
        
        if([AVUser currentUser])
        {
            
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"This line is VIP line, please purchase VIP to try to connect" delegate:self cancelButtonTitle:@"Try later" otherButtonTitles:@"Buy now", nil];
            [alertView show];
        }
        
    }
else
{
    
}
    
}
- (void)returnRouteName:(SelectRouteBlock)block{
    self.selectRouteBlock = block;
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
