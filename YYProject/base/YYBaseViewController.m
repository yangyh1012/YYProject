//
//  YYBaseViewController.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "YYBaseViewController.h"

@interface YYBaseViewController ()<YYCommunicationDelegate,MBProgressHUDDelegate>

@property (nullable, nonatomic, strong) UITableView *tableView1;

@property (nullable, nonatomic, strong) UICollectionView *collectionView1;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) YYCommunication *communication;

@property (nullable, nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) UILabel *dataEmptyTipLabel;


@end

@implementation YYBaseViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //我常用的Xcode快捷键
    // ctrl+6 打开方法导航
    // shift+↑ 选取
    // command+L 输入行数跳到指定行
    // command+/ 添加注释
    // command+[ 左移代码块
    // command+←或者↑ 跳到该文件的头部
    // command+ctrl+← 跳到上一个页面
    // command+ctrl+↑ h文件和m文件互换
    // command+shift+J 打开文件导航
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];//设置加载时背景为灰色
    
    self.automaticallyAdjustsScrollViewInsets = NO;//去掉多余的滚动间距
    self.navigationController.navigationBar.translucent = NO;//去掉导航透明
    self.tabBarController.tabBar.translucent = NO;//去掉底部透明
    
    self.communication = [[YYCommunication alloc] init];
    self.communication.delegate = self;//网络请求代理
    
    [self addNavItemForBack];
    
    {
        BOOL flag = NO;
        
        //数据初始化
        if (flag) {
            
            self.title = @"这是标题";
            
            self.pageNum = YYProjectStartPage;
            
            self.communication.delegate = self;
        }
        
        //数据请求
        if (flag) {
            
            [self requestDataUrlStr:YYProjectBaseUrl];
        }
        
        if (flag) {
            
            //可以使界面的View的frame有值
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    {
        BOOL flag = NO;
        if (flag) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillShow:)
                                                         name:@"test" object:nil];
            
            //注册键盘出现通知
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillShow:)
                                                         name:UIKeyboardWillShowNotification object:nil];
            //注册键盘隐藏通知
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillHide:)
                                                         name:UIKeyboardWillHideNotification object:nil];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    {
        BOOL flag = NO;
        if (flag) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:@"test" object:nil];
            
            //解除键盘出现通知
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIKeyboardWillShowNotification object:nil];
            //解除键盘隐藏通知
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIKeyboardWillHideNotification object:nil];
        }
    }
}

- (void)dealloc {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];//去掉动作
    [self.communication cancleAllRequest];//取消所有请求
    self.communication.delegate = nil;//去除代理
    [[NSNotificationCenter defaultCenter] removeObserver:self];//去除通知
    [self hide:NO];//去除提示框
    
    DLog(@"====== %@ dealloc ======",NSStringFromClass(self.class));//打印当前控制器名称
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Init

- (void)addNavItemForBack {
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftNavigationItemHandle:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0, 0, 18, 32);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)navigationSetting {
    
    //从storyboard获取控制器进而推出
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UIViewController"];
    [self.navigationController pushViewController:viewController animated:NO];
    
    //隐藏后退按钮
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏字体颜色
    UINavigationController *navigationController = self.navigationController;
    if ([navigationController isKindOfClass:[UINavigationController class]]) {
        
        navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
        [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    
    //隐藏导航栏，放在viewWillAppear和viewWillDisappear中
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //登录取消时，自动跳转到首页
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    //跳转到指定的控制器
    for (UIViewController *temp in self.navigationController.viewControllers) {
        
        if ([temp isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController *tabBarController = (UITabBarController *)temp;
            [tabBarController.navigationController popToViewController:temp animated:YES];
        }
    }
    
    //取消透明
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark - Button

- (void)leftNavigationItemHandle:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Action

/**
 *  下拉加载数据
 */
- (void)loadListDataForStart {
    
    self.pageNum = YYProjectStartPage;
    
    [self requestPageDataWithType:0];
}

/**
 *  上拉加载数据
 */
- (void)loadListDataForMore {
    
    self.pageNum = self.pageNum + 1;
    if ([self.datas count] <= 0) {
        
        self.pageNum = 1;
    }
    
    [self requestPageDataWithType:1];
}

/**
 *  分页加载数据
 */
- (void)requestPageDataWithType:(NSInteger)type {
    
    NSString *URLString = @"";
    NSDictionary *params = @{@"page":@(self.pageNum)};
    NSDictionary *otherParams = @{@"tableView":self.tableView1,
                                  YYNotificationPageLoad:@(type)};
    
    NSDictionary *parameters = @{@"URLString":URLString,
                                 @"parameters":params,
                                 @"otherParams":otherParams};
    
    [self requestDataParam:parameters loadFlag:NO];
}

/**
 *  让上下拉刷新的加载条停止
 */
- (void)stopLoadingAndPageInitOtherParams:(id)otherParams {
    
    UITableView *tableView = [otherParams objectForKey:@"tableView"];
    NSNumber *pageLoadNum = [otherParams objectForKey:YYNotificationPageLoad];
    
    if (pageLoadNum && tableView) {
        
        if ([pageLoadNum integerValue] == 0) {
            
            [tableView.mj_header endRefreshing];
        } else {
            
            [tableView.mj_footer endRefreshing];
        }
        
        if (self.pageNum > YYProjectStartPage) {
            
            self.pageNum = self.pageNum - 1;
        }
    }
}

//=====================================================
//=====================================================




- (void)showDataEmptyTip:(NSString *)tip positionY:(CGFloat)y {
    
    if (!self.dataEmptyTipLabel) {
        
        self.dataEmptyTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        self.dataEmptyTipLabel.text = tip;
        [self.view addSubview:self.dataEmptyTipLabel];
        [self.dataEmptyTipLabel sizeToFit];
        self.dataEmptyTipLabel.frame = CGRectMake((self.view.frame.size.width - self.dataEmptyTipLabel.frame.size.width) / 2.0, (self.view.frame.size.height - self.dataEmptyTipLabel.frame.size.height) / 2.0 - y, self.dataEmptyTipLabel.frame.size.width, self.dataEmptyTipLabel.frame.size.height);
    }
    
    [self.view bringSubviewToFront:self.dataEmptyTipLabel];
    self.dataEmptyTipLabel.hidden = NO;
}

- (void)hideDataEmptyTip {
    
    self.dataEmptyTipLabel.hidden = YES;
}








- (id)isCorrectViewWithClass:(Class)aClass subView:(id)sender {
    
    id view = [sender superview];
    if (view) {
        
        if ([view isKindOfClass:aClass]) {
            
            return view;
        } else {
            
            return [self isCorrectViewWithClass:aClass subView:view];
        }
    } else {
        
        return nil;
    }
}



/**
 *  跳转到登录
 */
- (void)showLogin:(id)sender {
    
    [self hide:YES];
    [[YYDataHandle sharedManager] setUserDefaultSecretStringValue:@"" WithKey:YYProjectSid];
    UIViewController *loginViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MDLoginViewController"];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

#pragma mark - Request

//无任何参数请求
- (void)requestDataUrlStr:(NSString *)urlStr {
    
    [self requestDataUrlStr:urlStr loadFlag:YES];
}

//无任何参数请求
- (void)requestDataUrlStr:(NSString *)urlStr loadFlag:(BOOL)loadFlag {
    
    if (loadFlag) {
        
        [self showIndeterminateHUD];
    }
    
    [self.communication httpRequest:urlStr];
}

//有参数请求
- (void)requestDataParam:(NSDictionary *)parameters {
    
    [self requestDataParam:parameters loadFlag:YES];
}

//有参数请求
- (void)requestDataParam:(NSDictionary *)parameters loadFlag:(BOOL)loadFlag {
    
    if (loadFlag) {
        
        [self showIndeterminateHUD];
    }
    
    [self.communication httpRequestWithAllPara:parameters];
}

//可以正常连接到服务端
- (void)requestSuccess:(nullable id)responseObject URLString:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters otherParams:(nullable NSDictionary *)otherParams {
    
    NSString *respCode = @"RespCode";
    NSString *respDesc = YYYProjectRespDesc;
    NSString *results = @"Results";
    
    NSNumber *responseStatus = (NSNumber *)[responseObject objectForKey:respCode];
    NSString *statusStr = [responseStatus stringValue];
    
    NSMutableDictionary *mutableOtherParams = [otherParams mutableCopy];
    [mutableOtherParams setObject:[responseObject objectForKey:respDesc] forKey:respDesc];
    
    //请求失败或者是重新登录
    if ([statusStr isEqualToString:YYProjectStatusFailed] ||
        [statusStr isEqualToString:YYProjectStatusLoginFirst]) {
        
        __weak __typeof(self)wself = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *responseTip = [mutableOtherParams objectForKey:respDesc];
            DLog(@"错误信息为：%@",responseTip);
            DLog(@"返回的状态码为：%@",statusStr);
            
            //隐藏加载条
            [wself hideIndeterminateHUD];
            
            [wself requestLoginFirstOrFailedStatus:statusStr otherParams:mutableOtherParams];
        });
        
    } else {
        
        //请求成功
        __weak __typeof(self)wself = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            DLog(@"提示信息为：%@",[mutableOtherParams objectForKey:respDesc]);
            DLog(@"返回的数据为：%@",responseObject);
            
            //请求成功还是要不要隐藏加载条
            if (![mutableOtherParams objectForKey:@"HUD"]) {
                
                [wself hideIndeterminateHUD];
            }
            
            [wself requestSuccess:[responseObject objectForKey:results] otherParams:mutableOtherParams];
        });
    }
}

//不能正常连接到服务端
- (void)requestFailure:(nullable NSError *)error URLString:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters otherParams:(nullable NSDictionary *)otherParams {
    
    __weak __typeof(self)wself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //隐藏加载条
        [wself hideIndeterminateHUD];
        
        //打印错误信息
        [wself showErrorMessage:[NSString codeDescription:[error code]]];
        
        [wself stopLoadingAndPageInitOtherParams:otherParams];
    });
}

//请求失败或者是重新登录
- (void)requestLoginFirstOrFailedStatus:(NSString *)statusStr otherParams:(id)otherParams {
    
    NSString *responseTip = [otherParams objectForKey:YYYProjectRespDesc];
    [self showHUDWithText:responseTip mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
    
    //重新登录
    if ([statusStr isEqualToString:YYProjectStatusLoginFirst]) {
        
        if (![otherParams objectForKey:YYNotificationLoginFirst]) {
            
            [self performSelector:@selector(showLogin:) withObject:nil afterDelay:YYProjectHUDTipTime];
        } else {
            
            [self hide:YES afterDelay:YYProjectHUDTipTime];
        }
        
    } else {
        
        [self hide:YES afterDelay:YYProjectHUDTipTime];
    }
    
    [self stopLoadingAndPageInitOtherParams:otherParams];
}

/**
 *  请求成功
 */
- (void)requestSuccess:(id)responseObject otherParams:(id)otherParams {
    
    //子类实现这个方法
}

#pragma mark - Notification

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    
    /*说明：UIKeyboardFrameEndUserInfoKey获得键盘的尺寸，键盘高度
     
     */
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    DLog(@"%.f",keyboardSize.height);
    
    //    self.tableViewBottomConstraint.constant = keyboardSize.height;
    //    [self updateViewConstraints];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    
    /*说明：UIKeyboardFrameEndUserInfoKey获得键盘的尺寸，键盘高度
     
     */
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    DLog(@"%.f",keyboardSize.height);
    
    //    self.tableViewBottomConstraint.constant = self.tableViewBottomConstraint.constant - keyboardSize.height;
    //    [self updateViewConstraints];
}

#pragma mark - MBProgressHUDDelegate

- (void)showIndeterminateHUD {
    
    [self showHUDWithText:nil mode:MBProgressHUDModeIndeterminate yOffset:0 font:0];
}

- (void)hideIndeterminateHUD {
    
    [SVProgressHUD dismiss];
}

- (void)showErrorMessage:(NSString *)text {
    
    [self showHUDWithText:text];
    [self hide:YES afterDelay:YYProjectHUDTipTime];
}

- (void)showHUDWithText:(NSString *)text {
    
    [self showHUDWithText:text mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
}

- (void)showHUDWithText:(NSString *)text mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset font:(CGFloat)fontSize {
    
    if (mode == MBProgressHUDModeText) {
        
        if (!self.HUD) {
            
            if (self.navigationController.view) {
                
                self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            } else {
                
                self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
            }
            
            [self.view addSubview:self.HUD];
            self.HUD.delegate = self;
            self.HUD.margin = 10.0f;
            //            self.HUD.contentColor = [[YYConstants sharedManager] YYProjectDefaultColor];
            //            self.HUD.bezelView.color = [UIColor whiteColor];
            
            self.HUD.contentColor = [UIColor whiteColor];
            self.HUD.bezelView.color = [UIColor blackColor];
        }
        
        self.HUD.label.font = [UIFont systemFontOfSize:fontSize];
        self.HUD.offset = CGPointMake(self.HUD.offset.x, yOffset);
        self.HUD.mode = mode;
        self.HUD.label.text = text;
        [self.HUD showAnimated:YES];
    } else {
        
        [SVProgressHUD show];
    }
}

- (void)hide:(BOOL)animated {
    
    [self hide:animated afterDelay:0];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    
    if (delay > 0) {
        
        [self.HUD hideAnimated:YES afterDelay:YYProjectHUDTipTime];
    } else {
        
        [self.HUD hideAnimated:YES];
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}

- (CGFloat)HUDOffsetY {
    
    return self.view.frame.size.height/2.0 - 100;
}

#pragma mark - UITextFieldDelegate

/**
 *  只能输入数字
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL flag = NO;
    
    if (flag) {
        
        if ([string length] > 0) {
            
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9')) {//数据格式正确
                
                //首字母不能为0
                if([textField.text length] == 0){
                    
                    if (single == '0') {
                        
                        return NO;
                    } else {
                        
                        return YES;
                    }
                } else {
                    
                    return YES;
                }
            } else {//输入的数据格式不正确
                
                return NO;
            }
        } else {
            
            return YES;
        }
    } else {
        
        return YES;
    }
}

#pragma mark - Segue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showTest"]) {
        
        
    } else if ([segue.identifier isEqualToString:@"showTest"]) {
        
        
    }
}


@end
