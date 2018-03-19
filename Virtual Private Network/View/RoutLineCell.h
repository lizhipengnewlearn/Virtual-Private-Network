//
//  RoutLineCell.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
#import "RouteLine.h"
@interface RoutLineCell : UITableViewCell
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) CustomLabel *titleLabel;
@property (nonatomic, strong) CustomLabel *descLabel;
@property (nonatomic, strong) UIView *lineView;
- (void)setcontentWithModel:(RouteLine*)routLineModel;
@end
