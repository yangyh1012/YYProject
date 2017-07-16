//
//  ViewController.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<MBProgressHUDDelegate>

@property (nonatomic, strong) NSMutableArray *datas;


@property (nullable, nonatomic, strong) UITableView *tableView;

@property (nullable, nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) UIAlertController *faceImageAlertController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //约束动画
    {
        [UIView animateWithDuration:0.3f animations:^{
            
            [self.view layoutIfNeeded];
        }];
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
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewInit

- (void)addNavItem {
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"厦门" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftNavigationItemHandle:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    leftButton.frame = CGRectMake(0, 0, 40, 18);
    [leftButton sizeToFit];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightNavigationItemHandle:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton sizeToFit];
    
    UIBarButtonItem *leftMenuButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *rightMenuButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: leftMenuButton, nil] animated:YES];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: rightMenuButton, nil] animated:YES];
}

- (void)addTableView:(BOOL)tablePageFlag {
    
    //    self.tableView.delegate = self;
    //    self.tableView.dataSource = self;
    
    //不要分割线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //去掉多余的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //默认选中第一行
    //[self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    if (tablePageFlag) {
        
        self.pageNum = YYProjectStartPage;
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadArticleListData方法）
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadListDataForStart)];
        header.automaticallyChangeAlpha = YES;// 设置自动切换透明度(在导航栏下面自动隐藏)
        header.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
        [header beginRefreshing];// 马上进入刷新状态
        self.tableView.mj_header = header;// 设置header
        
        // 上拉刷新
        __weak __typeof(self)wself = self;
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [wself loadListDataForMore];
        }];
    }
}

- (void)addCollectionView:(BOOL)collectionPageFlag {
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 65.0f) / 3.0f, 85.0f);
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewFlowLayout.minimumLineSpacing = 10;
    collectionViewFlowLayout.minimumInteritemSpacing = 10 * [[YYConstants sharedManager] multiplesForPhone];
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10 * [[YYConstants sharedManager] multiplesForPhone], 0, 10 * [[YYConstants sharedManager] multiplesForPhone]);
    
    //    self.collectionView.delegate = self;
    //    self.collectionView.dataSource = self;
    
    self.collectionView.collectionViewLayout = collectionViewFlowLayout;
    
    if (collectionPageFlag) {
        
        self.pageNum = YYProjectStartPage;
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadArticleListData方法）
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadListDataForStart)];
        header.automaticallyChangeAlpha = YES;// 设置自动切换透明度(在导航栏下面自动隐藏)
        header.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
        [header beginRefreshing];// 马上进入刷新状态
        self.collectionView.mj_header = header;// 设置header
        
        // 上拉刷新
        __weak __typeof(self)wself = self;
        self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [wself loadListDataForMore];
        }];
    }
}

#pragma mark - Button

- (void)leftNavigationItemHandle:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightNavigationItemHandle:(id)sender {
    
    //TODO:rightNavigationItemHandle
}

- (void)commitBtnHandle:(id)sender {
    
    [self.view endEditing:YES];
    
    NSString *passwordTextFieldText = @"";
    if ([NSString isValidPassword:passwordTextFieldText]) {
        
        [self showErrorMessage:[NSString isValidPassword:passwordTextFieldText]];
        
        return ;
    }
    
    [self performSegueWithIdentifier:@"showPasswordForget" sender:nil];
}

- (void)faceImageBtnHandle:(id)sender {
    
    __weak __typeof(self)wself = self;//防止循环引用
    
    if (!self.faceImageAlertController) {
        
        self.faceImageAlertController = [UIAlertController alertControllerWithTitle:nil
                                                                            message:nil
                                                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        [self.faceImageAlertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            DLog(@"%@",wself);
        }]];
        
        [self.faceImageAlertController addAction:[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        
        [self.faceImageAlertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    }
    
    [self presentViewController:self.faceImageAlertController animated:YES completion:nil];
}

#pragma mark - Action

/**
 *  一段代码完成上下拉刷新
 */
- (void)requestPageDataWithType:(NSInteger)type {
    
    NSString *URLString = YYLocationUrl;
    NSDictionary *params = @{@"page":@(self.pageNum)};
    NSDictionary *otherParams = @{@"tableView":self.tableView,
                                  YYNotificationPageLoad:@(type)};
    
    NSDictionary *parameters = @{@"URLString":URLString,
                                 @"parameters":params,
                                 @"otherParams":otherParams};
    
    [self requestDataParam:parameters loadFlag:NO];
}

#pragma mark - Request

/**
 *  请求
 */
- (void)requestDataList {
    
    NSString *URLString = YYLocationUrl;
    NSDictionary *params = @{};
    NSDictionary *otherParams = @{};
    
    NSDictionary *parameters = @{@"URLString":URLString,
                                 @"parameters":params,
                                 @"otherParams":otherParams,
                                 @"mode":@1,
                                 @"uidAndTokenFlag":@1};
    
    [self requestDataParam:parameters];
}

/**
 *  数据成功返回的处理
 */
- (void)requestSuccess:(id)responseObject otherParams:(id)otherParams {
    
    NSString *notificationName = [otherParams objectForKey:YYNotificationKey];
    
    if ([notificationName isEqualToString:YYLocationUrl]) {
        
        NSArray *result = [responseObject objectForKey:@"results"];
        
        if ([result count] > 0) {
            
            if (!self.datas) {
                
                self.datas = [[NSMutableArray alloc] init];
            }
            
            //如果是在第一页，就去掉全部数据
            if (self.pageNum == 1) {
                
                [self.datas removeAllObjects];
            }
            
            [self.datas addObjectsFromArray:result];
            
            [self.tableView reloadData];
            
        } else {
            
            self.pageNum = (self.pageNum - 1 == 0)?YYProjectStartPage:(self.pageNum - 1);
            [self showErrorMessage:@"无更多数据"];
        }
        
        NSNumber *pageLoadNum = [otherParams objectForKey:YYNotificationPageLoad];
        if ([pageLoadNum integerValue] == 0) {
            
            [self.tableView.mj_header endRefreshing];
        } else {
            
            [self.tableView.mj_footer endRefreshing];
        }
        
    } else if ([notificationName isEqualToString:YYProjectBaseUrl]) {
        
        [self showHUDWithText:[otherParams objectForKey:YYYProjectRespDesc]];
        [self performSelector:@selector(bactToPreController:) withObject:nil afterDelay:YYProjectHUDTipTime];
    }
}

- (void)bactToPreController:(id)sender {
    
    [self hide:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - StoryboardSegue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showTest"]) {
        
        
    } else if ([segue.identifier isEqualToString:@"showTest"]) {
        
        
    }
}

@end


#pragma mark - AnotherViewController

@interface AnotherViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
///<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AnotherViewController

#pragma mark - Life cycle
#pragma mark - View Init
#pragma mark - Button
#pragma mark - Action
#pragma mark - Request
#pragma mark - Notification
#pragma mark - Delegate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"标题";
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //不要分割线
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //去掉多余的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 65.0f) / 3.0f, 85.0f);
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewFlowLayout.minimumLineSpacing = 10;
    collectionViewFlowLayout.minimumInteritemSpacing = 10 * [[YYConstants sharedManager] multiplesForPhone];
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10 * [[YYConstants sharedManager] multiplesForPhone], 0, 10 * [[YYConstants sharedManager] multiplesForPhone]);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.collectionViewLayout = collectionViewFlowLayout;
    
    
    [self addNavItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    
}

#pragma mark - ViewInit

- (void)addNavItem {
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"厦门" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftNavigationItemHandle:) forControlEvents:UIControlEventTouchUpInside];
    //    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    leftButton.frame = CGRectMake(0, 0, 40, 18);
    [leftButton sizeToFit];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightNavigationItemHandle:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    
    UIBarButtonItem *leftMenuButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *rightMenuButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: leftMenuButton, nil] animated:YES];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: rightMenuButton, nil] animated:YES];
}

#pragma mark - Button

- (void)leftNavigationItemHandle:(id)sender {
    
    //TODO:leftNavigationItemHandle
}

- (void)rightNavigationItemHandle:(id)sender {
    
    //TODO:rightNavigationItemHandle
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    //设置单元格不可点击
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置单元格线条占满宽度
    //    [cell setLayoutMargins:UIEdgeInsetsZero];
    //    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    DLog(@"row:%@",@(row));
    DLog(@"section:%@",@(section));
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    DLog(@"row:%@",@(row));
    DLog(@"section:%@",@(section));
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 5;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//    return 5;
//}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    NSInteger section = indexPath.section;
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DLog(@"item:%@",@(item));
    DLog(@"section:%@",@(section));
    
    
    
    //    [self layerSettingWithView:cell borderWidth:1.0f borderColor:[[YYConstants sharedManager] YYProjectLightColor] cornerRadius:10.0f masksToBounds:YES];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    NSInteger section = indexPath.section;
    
    DLog(@"item:%@",@(item));
    DLog(@"section:%@",@(section));
}


#pragma mark - Segue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
