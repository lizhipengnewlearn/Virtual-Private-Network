//
//  VPAgreementViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPAgreementViewController.h"

@interface VPAgreementViewController ()

@end

@implementation VPAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH-80, SCREEN_HEIGHT-NAVBAR_HEIGHT)];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, scrollView.frame.size.width, 15)];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:contentLabel];
    [self.view addSubview:scrollView];
    if (self.agreementType==VPAgreementTypeService)
    {
        self.titleString=@"The terms of service";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"服务" ofType:@".txt"];
        contentLabel.text=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    }
    else
    {
        self.titleString=@"Privacy policy";
        NSString *path = [[NSBundle mainBundle] pathForResource:@"隐私" ofType:@".txt"];
        contentLabel.text=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

       
    }
     CGSize contentSize =[contentLabel.text sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(scrollView.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    float contentHeight = [NSString text:contentLabel.text heightWithFontSize:15 width:scrollView.width lineSpacing:1];
    contentLabel.frame = CGRectMake(0, 50, scrollView.frame.size.width, contentSize.height);
    if (contentLabel.frame.size.height + 50 > scrollView.height)
    {
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH-80, contentLabel.frame.size.height+contentLabel.frame.origin.y + 50);
    }
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
