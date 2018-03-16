//
//  RouteLine.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface RouteLine : AVObject<AVSubclassing>
@property (nonatomic, strong)AVFile *homeCountryImageFile;
@property (nonatomic, strong)AVFile *countryImageFile;
@property (nonatomic, copy)NSString *countryName;
@property (nonatomic, copy)NSString *englishName;
@property (nonatomic, copy)NSString *vpnIp;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, strong)NSNumber *order;



@end
