//
//  VPMyViewController.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPBaseViewController.h"
@interface VPMyViewController : VPBaseViewController
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArray;
@end
