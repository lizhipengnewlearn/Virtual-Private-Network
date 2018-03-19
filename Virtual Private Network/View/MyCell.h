//
//  MyCell.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
@interface MyCell : UITableViewCell
@property(nonatomic, strong)CustomLabel *titleLabel;
@property(nonatomic, strong)CustomLabel *contentLabel;
@property(nonatomic, strong)UIImageView *rightImagView;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UIView *greenLineView;
@end
