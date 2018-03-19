//
//  VPAgreementViewController.h
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPBaseViewController.h"
typedef enum {
    VPAgreementTypePolicy=0,
    VPAgreementTypeService
}VPagreementType;
@interface VPAgreementViewController : VPBaseViewController
@property (nonatomic, assign)VPagreementType agreementType;
@end
