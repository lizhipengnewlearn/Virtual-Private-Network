//
//  Macro.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define COLOR(x,y,z) [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:1.0f]
#define kBarTinColor [UIColor whiteColor]
// 屏幕适配
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCALE_WIDTH SCREEN_WIDTH/375

#define STATUSTBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#define SYSTEMNAV_HEIGHT 44.0

#define NAVBAR_HEIGHT STATUSTBAR_HEIGHT+SYSTEMNAV_HEIGHT

#define TABBAR_HEIGHT (SCREEN_HEIGHT==812.0 ? 83 : 49)

#define BOTTOM_HEIGHT (SCREEN_HEIGHT==812.0 ? 34 : 0)

//颜色
#define HOMETITLE_COLOR COLOR(51,51,51)
#define HOMEGREEN_COLOR COLOR(49,205,64)


#define LINE_COLOR COLOR(229,229,229)
#define TITLE_SIZE 16
#define  loginSuccess @"loginSuccess"
#define  purchSuccess @"purchSuccess"


#endif /* Macro_h */
