//
//  NSString+Size.h
//  FangFang
//
//  Created by 叶俊文 on 2017/6/15.
//  Copyright © 2017年 王康欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

// 计算字符串的size
+ (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize string:(NSString *)string;
+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;
@end
