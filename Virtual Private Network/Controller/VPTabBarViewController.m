//
//  VPTabBarViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPTabBarViewController.h"
#import "VPBaseNavigationController.h"
@interface VPTabBarViewController ()

@end

@implementation VPTabBarViewController

static VPTabBarViewController* _instance=nil;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc]init];
    });
    return _instance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makerootViewcontroller:self.homeView andTitle:@"" andImage:@"首页未选" andSelectImage:@"首页已选"];
    [self makerootViewcontroller:self.memberView andTitle:@"" andImage:@"购买未选" andSelectImage:@"购买已选"];
    [self makerootViewcontroller:self.myView andTitle:@"" andImage:@"我的未选" andSelectImage:@"我的已选"];
    
}

-(VPHomeViewController *)homeView{
    if (!_homeView) {
        _homeView=[[VPHomeViewController alloc]init];
    }
    return _homeView;
}
- (VPMemberViewController *)memberView{
    if (!_memberView) {
        _memberView=[[VPMemberViewController alloc]init];
    }
    return _memberView;
}
- (VPMyViewController *)myView{
    if (!_myView) {
        _myView=[[VPMyViewController alloc]init];
    }
    return _myView;
}

- (void)makerootViewcontroller:(UIViewController*)rootView andTitle:(NSString *)title andImage:(NSString *)image andSelectImage:(NSString*)selectImage{
   
    VPBaseNavigationController *navigation=[[VPBaseNavigationController alloc]initWithRootViewController:rootView];
    navigation.tabBarItem.title=title;
    navigation.tabBarItem.image=[UIImage imageNamed:image];
    navigation.tabBarItem.selectedImage=[[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //创建修改字体颜色的字典，同时可以设置字体的内边距；
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:1];
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [navigation.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [navigation.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    [self addChildViewController:navigation];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
