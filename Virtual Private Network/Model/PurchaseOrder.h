//
//  PurchaseOrder.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface PurchaseOrder : AVObject<AVSubclassing>
@property (nonatomic, strong)AVUser *user;
@property (nonatomic, strong)NSDate *benginDate;
@property (nonatomic, strong)NSDate *endDate;

@end
