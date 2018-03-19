//
//  VPAboutUsViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPAboutUsViewController.h"
#import "NSString+Size.h"
#import "UILabel+Utils.h"
@interface VPAboutUsViewController ()

@end

@implementation VPAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HEIGHT-BOTTOM_HEIGHT)];
    scrollView.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [self.view addSubview:scrollView];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-105)/2, 60, 105, 105)];
    logoImageView.image = [UIImage imageNamed:@"LOGO"];
    [scrollView addSubview:logoImageView];
    NSString *descString=@"Speed accelerator, unlimited flow, no need to register!\nProvide a variety of quality routes, experience super fast, smooth!\nOne key connection, use immediately, high speedstability not drop line!";
    
    float height = [NSString text:descString heightWithFontSize:15 width:SCREEN_WIDTH-28 lineSpacing:10];
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, logoImageView.bottom + 30, SCREEN_WIDTH-28, height)];
    descLabel.font = [UIFont systemFontOfSize:15];
    descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descLabel.numberOfLines = 0;
    descLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [descLabel setText:descString lineSpacing:10];
    [scrollView addSubview:descLabel];
    
    if (descLabel.bottom + 30 > scrollView.height)
    {
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH-28, descLabel.bottom + 30);
    }
    self.titleString=@"About us";
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

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
