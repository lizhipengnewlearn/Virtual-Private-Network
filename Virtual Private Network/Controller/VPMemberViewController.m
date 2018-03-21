//
//  VPMemberViewController.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "VPMemberViewController.h"
#import "ItemsButton.h"
#import "CustomLabel.h"
#import "PurchaseOrder.h"
#import "DateManager.h"
#import "VPLoginViewController.h"
#import <StoreKit/StoreKit.h>
#import "MBProgressHUD+Add.h"
#import "VPAgreementViewController.h"
@interface VPMemberViewController ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
{
    NSString *productIdString;
    NSInteger flag;
}
@end

@implementation VPMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
  
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // 添加观察者
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 移除观察者
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)creatUI{
    CustomLabel *vipLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(59, 110, 50, 32) andTextColor:HOMETITLE_COLOR andSize:31];
    vipLabel.text=@"VIP";
    [self.view addSubview:vipLabel];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(vipLabel.frame.origin.x+vipLabel.frame.size.width+3, vipLabel.frame.origin.y, 36, 36)];
    imageView.image=[UIImage imageNamed:@"VIP"];
    [self.view addSubview:imageView];
    NSArray *timeArray=@[@"7 days",@"A month",@"3 month",@"A year"];
    NSArray *moneyArray=@[@"$2.99",@"$4.99",@"$10.99",@"$25.99"];
    for (int i=0; i<timeArray.count; i++) {
        ItemsButton *button=[[ItemsButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-308)/2, vipLabel.bottom+22+(57+15)*i, 308, 57) withFirstTitle:timeArray[i] withSecTitle:moneyArray[i]];
        button.tag=100+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    UIButton *purchaseInfoButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-174)/2, vipLabel.frame.size.height+vipLabel.frame.origin.y+(57+15)*4+89, 174, 35)];
    purchaseInfoButton.layer.cornerRadius=17.5;
    purchaseInfoButton.layer.masksToBounds=YES;
    [purchaseInfoButton setTitle:@"Purchase information" forState:UIControlStateNormal];
    purchaseInfoButton.backgroundColor=[UIColor colorWithHexString:@"efefef"];
    purchaseInfoButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [purchaseInfoButton setTitleColor:HOMEGREEN_COLOR forState:UIControlStateNormal];
    [purchaseInfoButton addTarget:self action:@selector(purchaseInfoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:purchaseInfoButton];
    
}

- (void)purchaseInfoButtonClick{
    VPAgreementViewController *agreementView=[[VPAgreementViewController alloc]init];
    agreementView.agreementType=VPAgreementTypePurchase;
    agreementView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:agreementView animated:YES];
}

- (void)buttonClick:(UIButton*)button{
    
    flag=button.tag;
    if ([AVUser currentUser])
    {
        AVQuery *query=[AVQuery queryWithClassName:@"PurchaseOrder"];
        [query whereKey:@"user" equalTo:[AVUser currentUser]];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects.count>0)
            {
                //之前买过会员
                PurchaseOrder *purchOrderModel=objects[0];
                NSString *endDateString=[DateManager stringFromDate:purchOrderModel.endDate];
                NSString *nowDateStrig=[DateManager stringFromDate:[NSDate date]];
                if([DateManager firstString:endDateString andSecondString:nowDateStrig]==YES)
                {
                    
                }
                else
                {
                    
                }
            }
            else
            {
                if([SKPaymentQueue canMakePayments]){
                    
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    // productID就是你在创建购买项目时所填写的产品ID
                    productIdString=ids[button.tag-100];
                    [self requestProductID:productIdString];
                    
                }
                else
                {
                    // NSLog(@"不允许程序内付费");
                    UIAlertView *alertError = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                         message:@"请先开启应用内付费购买功能。"
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles: nil];
                    [alertError show];
                }
            }
        }];
    }
}
#pragma mark 1.请求所有的商品ID
-(void)requestProductID:(NSString*)productId{
    NSArray *productIdArray=[[NSArray alloc]initWithObjects:productId, nil];
    NSSet *sets=[[NSSet alloc]initWithArray:productIdArray];
    SKProductsRequest *sKProductsRequest=[[SKProductsRequest alloc]initWithProductIdentifiers:sets];
    sKProductsRequest.delegate=self;
    [sKProductsRequest start];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error:%@",error);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showError:@"load failure" toView:self.view];
}
#pragma mark 2.苹果那边的内购监听
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"没有商品");
        return;
    }
    for (SKProduct *sKProduct in product){
        if([sKProduct.productIdentifier isEqualToString:productIdString]){
            [self buyProduct:sKProduct];
            break;
            
        }else{
            
            NSLog(@"不不不相同");
        }
    }
}
#pragma mark 内购的代码调用
-(void)buyProduct:(SKProduct *)product{
    SKPayment *skpayment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:skpayment];
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:{
                
                NSLog(@"正在购买");
            }break;
            case SKPaymentTransactionStatePurchased:{
                
                
                NSLog(@"购买成功");
                [MBProgressHUD showSuccess:@"purchase success" toView:self.view];
                
                // 购买后告诉交易队列，把这个成功的交易移除掉
                [queue finishTransaction:transaction];
                [self buyAppleStoreProductSucceedWithPaymentTransactionp:transaction];
                AVQuery *query=[AVQuery queryWithClassName:@"PurchaseOrder"];
                [query whereKey:@"user" equalTo:[AVUser currentUser]];
                [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                    if (objects.count>0) {
                        //之前买过会员
                        PurchaseOrder *purchOrderModel=objects[0];
                        NSString *endDateString=[DateManager stringFromDate:purchOrderModel.endDate];
                        NSString *nowDateStrig=[DateManager stringFromDate:[NSDate date]];
                        if([DateManager firstString:endDateString andSecondString:nowDateStrig]==YES)//如果会员没有过期
                        {
                            [purchOrderModel setObject:[NSDate date] forKey:@"beginDate"];
                            [purchOrderModel setObject:[AVUser currentUser] forKey:@"user"];
                            int days;
                            if (flag==100) {
                                days=7;
                            }
                            else if(flag==101){
                                days=30;
                            }
                            else if (flag==102){
                                days=90;
                            }
                            else {
                                days=365;
                            }
                            NSDate *dates = purchOrderModel.endDate;
                            NSTimeInterval interval = 60 * 60 *24*days;
                            NSDate *endDate = [NSDate dateWithTimeInterval:interval sinceDate:dates];
                            [purchOrderModel setObject:endDate forKey:@"endDate"];
                            [purchOrderModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                                [[NSNotificationCenter defaultCenter]postNotificationName:purchSuccess object:nil];
                            }];
                        }
                        else//如果会员过期了
                        {
                            [purchOrderModel setObject:[NSDate date] forKey:@"beginDate"];
                            [purchOrderModel setObject:[AVUser currentUser] forKey:@"user"];
                            int days;
                            if (flag==100) {
                                days=7;
                            }
                            else if(flag==101){
                                days=30;
                            }
                            else if (flag==102){
                                days=90;
                            }
                            else {
                                days=365;
                            }
                            NSDate *dates = [NSDate date];
                            NSTimeInterval interval = 60 * 60 *24*days;
                            NSDate *endDate = [NSDate dateWithTimeInterval:interval sinceDate:dates];
                            [purchOrderModel setObject:endDate forKey:@"endDate"];
                            [purchOrderModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                                [[NSNotificationCenter defaultCenter]postNotificationName:purchSuccess object:nil];

                            }];
                        }
                        
                    }
                    else
                    {
                        PurchaseOrder *purchOrderModel=[[PurchaseOrder  alloc]init];
                        [purchOrderModel setObject:[NSDate date] forKey:@"beginDate"];
                        [purchOrderModel setObject:[AVUser currentUser] forKey:@"user"];
                        int days;
                        if (flag==100) {
                            days=7;
                        }
                        else if(flag==101){
                            days=30;
                        }
                        else if (flag==102){
                            days=90;
                        }
                        else {
                            days=365;
                        }
                        NSDate *dates = [NSDate date];
                        NSTimeInterval interval = 60 * 60 *24*days;
                        NSDate *endDate = [NSDate dateWithTimeInterval:interval sinceDate:dates];
                        [purchOrderModel setObject:endDate forKey:@"endDate"];
                        [purchOrderModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                            [[NSNotificationCenter defaultCenter]postNotificationName:purchSuccess object:nil];

                        }];
                    }
                }];
                
            }break;
            case SKPaymentTransactionStateFailed:{
                
                NSLog(@"购买失败");
                [MBProgressHUD showError:@"Transaction Fail" toView:self.view];
                // 购买失败也要把这个交易移除掉
                [queue finishTransaction:transaction];
            }break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"回复购买中,也叫做已经购买");
                // 回复购买中也要把这个交易移除掉
                [queue finishTransaction:transaction];
            }break;
            case SKPaymentTransactionStateDeferred:{
                
                NSLog(@"交易还在队列里面，但最终状态还没有决定");
            }break;
            default:
                break;
        }
    }
}
-(void)requestDidFinish:(SKRequest *)request{
    NSLog(@"信息反馈结束");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


// 苹果内购支付成功
- (void)buyAppleStoreProductSucceedWithPaymentTransactionp:(SKPaymentTransaction *)paymentTransactionp {
    
    NSString * productIdentifier = paymentTransactionp.payment.productIdentifier;
    // NSLog(@"productIdentifier Product id：%@", productIdentifier);
    NSString *transactionReceiptString= nil;
    
    //系统IOS7.0以上获取支付验证凭证的方式应该改变，切验证返回的数据结构也不一样了。
    NSString *version = [UIDevice currentDevice].systemVersion;
    if([version intValue] >= 7.0){
        // 验证凭据，获取到苹果返回的交易凭据
        // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
        NSURLRequest * appstoreRequest = [NSURLRequest requestWithURL:[[NSBundle mainBundle]appStoreReceiptURL]];
        NSError *error = nil;
        NSData * receiptData = [NSURLConnection sendSynchronousRequest:appstoreRequest returningResponse:nil error:&error];
        transactionReceiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }else{
        
        NSData * receiptData = paymentTransactionp.transactionReceipt;
        //  transactionReceiptString = [receiptData base64EncodedString];
        transactionReceiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    // 去验证是否真正的支付成功了
    [self checkAppStorePayResultWithBase64String:transactionReceiptString];
}

- (void)checkAppStorePayResultWithBase64String:(NSString *)base64String {
    
    /* 生成订单参数，注意沙盒测试账号与线上正式苹果账号的验证途径不一样，要给后台标明 */
    /*
     注意：
     自己测试的时候使用的是沙盒购买(测试环境)
     App Store审核的时候也使用的是沙盒购买(测试环境)
     上线以后就不是用的沙盒购买了(正式环境)
     所以此时应该先验证正式环境，在验证测试环境
     
     正式环境验证成功，说明是线上用户在使用
     正式环境验证不成功返回21007，说明是自己测试或者审核人员在测试
     */
    /*
     苹果AppStore线上的购买凭证地址是： https://buy.itunes.apple.com/verifyReceipt
     测试地址是：https://sandbox.itunes.apple.com/verifyReceipt
     */
    //    NSNumber *sandbox;
    NSString *sandbox;
#if (defined(APPSTORE_ASK_TO_BUY_IN_SANDBOX) && defined(DEBUG))
    //sandbox = @(0);
    sandbox = @"0";
#else
    //sandbox = @(1);
    sandbox = @"1";
#endif
    
    NSMutableDictionary *prgam = [[NSMutableDictionary alloc] init];;
    [prgam setValue:sandbox forKey:@"sandbox"];
    [prgam setValue:base64String forKey:@"reciept"];
    
    /*
     请求后台接口，服务器处验证是否支付成功，依据返回结果做相应逻辑处理
     0 代表沙盒  1代表 正式的内购
     最后最验证后的
     */
    /*
     内购验证凭据返回结果状态码说明
     21000 App Store无法读取你提供的JSON数据
     21002 收据数据不符合格式
     21003 收据无法被验证
     21004 你提供的共享密钥和账户的共享密钥不一致
     21005 收据服务器当前不可用
     21006 收据是有效的，但订阅服务已经过期。当收到这个信息时，解码后的收据信息也包含在返回内容中
     21007 收据信息是测试用（sandbox），但却被发送到产品环境中验证
     21008 收据信息是产品环境中使用，但却被发送到测试环境中验证
     */
    
    NSLog(@"字典==%@",prgam);
    
}

#pragma mark 客户端验证购买凭据
- (void)verifyTransactionResult
{
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
    // 传输的是BASE64编码的字符串
    /**
     BASE64 常用的编码方案，通常用于数据传输，以及加密算法的基础算法，传输过程中能够保证数据传输的稳定性
     BASE64是可以编码和解码的
     */
    NSDictionary *requestContents = @{
                                      @"receipt-data": [receipt base64EncodedStringWithOptions:0]
                                      };
    NSError *error;
    // 转换为 JSON 格式
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents
                                                          options:0
                                                            error:&error];
    // 不存在
    if (!requestData) { /* ... Handle error ... */ }
    
    // 发送网络POST请求，对购买凭据进行验证
    NSString *verifyUrlString;
#if (defined(APPSTORE_ASK_TO_BUY_IN_SANDBOX) && defined(DEBUG))
    verifyUrlString = @"https://sandbox.itunes.apple.com/verifyReceipt";
#else
    verifyUrlString = @"https://buy.itunes.apple.com/verifyReceipt";
#endif
    // 国内访问苹果服务器比较慢，timeoutInterval 需要长一点
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:verifyUrlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    
    // 在后台对列中提交验证请求，并获得官方的验证JSON结果
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   NSLog(@"链接失败");
                               } else {
                                   NSError *error;
                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if (!jsonResponse) {
                                       NSLog(@"验证失败");
                                   }
                                   
                                   // 比对 jsonResponse 中以下信息基本上可以保证数据安全
                                   /*
                                    bundle_id
                                    application_version
                                    product_id
                                    transaction_id
                                    */
                                   
                                   NSLog(@"验证成功");
                               }
                           }];
    
}
- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
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
