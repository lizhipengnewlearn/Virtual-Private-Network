//
//  VPHomeViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPHomeViewController.h"
#import "VPSelectRouteViewController.h"
#import <NetworkExtension/NetworkExtension.h>
#import "MBProgressHUD+Add.h"
@interface VPHomeViewController ()
{
    NSString *ipAddress;
}
@end

@implementation VPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString=@"HOME";
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.chooseLineButton];
    [self.view addSubview:self.countryImageView];
    [self.view addSubview:self.countryNameLabel];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
    [self.view addSubview:self.startButton];
    
}
- (UIButton *)chooseLineButton{
    if (!_chooseLineButton) {
        _chooseLineButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 78, 150, 45)];
        _chooseLineButton.backgroundColor=[UIColor clearColor];
        _chooseLineButton.layer.cornerRadius=22.5;
        _chooseLineButton.layer.borderColor=[UIColor whiteColor].CGColor;
        [_chooseLineButton setTitle:@"Choose Line" forState:UIControlStateNormal];
        _chooseLineButton.layer.borderWidth=1;
        [_chooseLineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_chooseLineButton addTarget:self action:@selector(chooseRoutLine) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseLineButton;
}
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 275)];
        _backImageView.image=[UIImage imageNamed:@"背景未连接"];
    }
    return _backImageView;
}

- (UIImageView *)countryImageView{
    if (!_countryImageView) {
        _countryImageView=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-119)/2, 59, 119, 73)];
    }
    return _countryImageView;
}

-(CustomLabel *)countryNameLabel{
    if (!_countryNameLabel) {
        _countryNameLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(0, _countryImageView.frame.size.height+_countryImageView.frame.origin.y+23, SCREEN_WIDTH, 25) andTextColor:[UIColor whiteColor] andSize:25];
        _countryNameLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _countryNameLabel;
}
- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton=[[UIButton alloc]initWithFrame:CGRectMake(_countryImageView.frame.origin.x-35, _countryImageView.frame.origin.y+26, 20, 20)];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"左"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(chooseRoutLine) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton=[[UIButton alloc]initWithFrame:CGRectMake(_countryImageView.frame.origin.x+_countryImageView.frame.size.width+15, _leftButton.frame.origin.y, 20, 20)];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(chooseRoutLine) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rightButton;
}
- (UIButton *)startButton{
    if (!_startButton) {
        _startButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-220)/2, SCREEN_HEIGHT-TABBAR_HEIGHT-119-80-NAVBAR_HEIGHT, 220, 80)];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(startConnct) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

#pragma mark 开始连接
- (void)startConnct{
    if (_countryNameLabel.text.length==0) {
        [MBProgressHUD showError:@"please select a route" toView:self.view];
        return;
    }
    NEVPNManager *manager = [NEVPNManager sharedManager];
    [manager loadFromPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
        else
        {
            NEVPNProtocolIKEv2* ikev = [[NEVPNProtocolIKEv2 alloc] init];
            ikev.certificateType = NEVPNIKEv2CertificateTypeRSA;
            ikev.authenticationMethod = NEVPNIKEAuthenticationMethodCertificate;
            ikev.useExtendedAuthentication = YES;
            
            ikev.username = @"huzhe";
            ikev.passwordReference = [self searchKeychainCopyMatching:@"VPN_PASSWORD"];
            ikev.serverAddress = ipAddress;
            ikev.remoteIdentifier = ipAddress;
//            ikev.identityReference =  使用iOS钥匙串(keyChain)存入的identity;
            
            [manager setEnabled:YES];
            [manager setProtocol:ikev];
            [manager setOnDemandEnabled:NO];
            [manager setLocalizedDescription:@"MyVPN"];
            [manager saveToPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
                if(error) {
                    NSLog(@"Save error: %@", error);
                }
                else {
                    NSLog(@"Saved!");
                }
            }];
        }
    }];
    NSError *startError;
    [[NEVPNManager sharedManager].connection startVPNTunnelAndReturnError:&startError];
    [[NEVPNManager sharedManager] loadFromPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"VPN load error->%@", error);
        }
        else
        {
            NSError *startError;
            [[NEVPNManager sharedManager].connection startVPNTunnelAndReturnError:&startError];
            
            if(startError) {
                NSLog(@"Start error: %@", startError.localizedDescription);
            } else {
                NSLog(@"Connection established!");
            }
        }
    }];
}
#pragma mark - KeyChain
static NSString * const serviceName = @"im.zorro.ipsec_demo.vpn_config";
- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(__bridge id)kSecAttrService];
    return searchDictionary;
}
- (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    // Add search return types
    // Must be persistent ref !!!!
    [searchDictionary setObject:@YES forKey:(__bridge id)kSecReturnPersistentRef];
    CFTypeRef result = NULL;
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, &result);
    return (__bridge_transfer NSData *)result;
}
- (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)dictionary);
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}
#pragma mark 选择线路
-(void)chooseRoutLine{
    VPSelectRouteViewController *selectRout=[[VPSelectRouteViewController alloc]init];
    [selectRout setSelectRouteBlock:^(RouteLine *routLineModel) {
       _countryNameLabel.text=routLineModel.countryName;
        [_countryImageView setImageWithURL:[NSURL URLWithString:routLineModel.homeCountryImageFile.url] options:YYWebImageOptionSetImageWithFadeAnimation];
        _chooseLineButton.hidden=YES;
        ipAddress=routLineModel.vpnIp;
    }];
    selectRout.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:selectRout animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
