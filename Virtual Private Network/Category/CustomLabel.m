//
//  CustomLabel.m
//  wanted
//
//  Created by mac on 2017/12/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel
- (CustomLabel *)initWithFrame:(CGRect)frame andTextColor:(UIColor *)textColor andSize:(float)fontSize{
    
    self=[super initWithFrame:frame];
    if(self)
    {
        self.textColor=textColor;
        self.font=[UIFont systemFontOfSize:fontSize];
    }
    return self;
}
@end
