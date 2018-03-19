//
//  VPBaseViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPBaseViewController.h"
#import "CustomLabel.h"
@interface VPBaseViewController ()

@end

@implementation VPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }else{
        if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
    }
}

- (void)setTitleString:(NSString *)titleString{
    CustomLabel *titleLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)andTextColor:HOMETITLE_COLOR andSize:TITLE_SIZE];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.text=titleString;
    self.navigationItem.titleView=titleLabel;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (BOOL)gestureRecognizerShouldBegin{
    return YES;
}

-(NSString *)backItemImageName{
    return @"返回";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
