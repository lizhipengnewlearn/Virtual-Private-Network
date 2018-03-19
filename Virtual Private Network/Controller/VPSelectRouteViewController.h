//
//  VPSelectRouteViewController.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPBaseViewController.h"
#import "RouteLine.h"
typedef void(^SelectRouteBlock)(RouteLine*routLineModel);
@interface VPSelectRouteViewController : VPBaseViewController
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, copy )SelectRouteBlock selectRouteBlock;
-(void)returnRouteName:(SelectRouteBlock)block;
@end
