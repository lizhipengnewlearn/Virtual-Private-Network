//
//  NSString+Size.m
//  FangFang
//
//  Created by 叶俊文 on 2017/6/15.
//  Copyright © 2017年 王康欣. All rights reserved.
//

#import "NSString+Size.h"
#import "UILabel+Utils.h"
@implementation NSString (Size)

+ (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize string:(NSString *)string
{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}

+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    [label setText:text lineSpacing:lineSpacing];
    [label sizeToFit];
    return label.height;
}

@end
