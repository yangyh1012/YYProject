//
//  YYBaseViewController.h
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYBaseViewControllerTestDelegate <NSObject>

@required

- (void)testDelegateHandle:(id)object;

@optional

@end

typedef NS_ENUM(NSInteger, YYBaseViewControllerTestType) {
    
    YYBaseViewControllerTestType1 = 0,
    YYBaseViewControllerTestType2,
};

@interface YYBaseViewController : UIViewController


@property (nonatomic, weak) id <YYBaseViewControllerTestDelegate> testDelegate;

@property (nonatomic, assign) YYBaseViewControllerTestType baseViewControllerTestType;

@property (nonatomic, assign) NSInteger pageNum;



/**
 *  下拉刷新调用此方法，此方法调用requestPageDataWithType方法
 */
- (void)loadListDataForStart;

/**
 *  上拉刷新调用此方法，此方法调用requestPageDataWithType方法
 */
- (void)loadListDataForMore;

/**
 *  只请求url，其他参数都为空
 *
 *  @param urlStr url字符串
 */
- (void)requestDataUrlStr:(NSString *)urlStr;


- (void)requestDataUrlStr:(NSString *)urlStr loadFlag:(BOOL)loadFlag;

/**
 *  添加更多复杂的参数
 *
 *  @param parameters 参数
 */
- (void)requestDataParam:(NSDictionary *)parameters;

- (void)requestDataParam:(NSDictionary *)parameters loadFlag:(BOOL)loadFlag;

/**
 *  请求成功时执行此方法
 *
 *  @param responseObject 数据
 *  @param otherParams    参数
 */
- (void)requestSuccess:(id)responseObject otherParams:(id)otherParams;





/**
 *  显示加载条
 */
- (void)showIndeterminateHUD;


/**
 隐藏加载条
 */
- (void)hideIndeterminateHUD;


/**
 显示提示信息，不会自动隐藏
 
 @param text 信息
 */
- (void)showHUDWithText:(NSString *)text;


/**
 显示提示信息，会自动隐藏
 
 @param text 信息
 */
- (void)showErrorMessage:(NSString *)text;

/**
 *  显示加载提示框
 *
 *  @param text     提示文字
 *  @param mode     提示框样式（MBProgressHUDModeIndeterminate，MBProgressHUDModeText）
 *  @param yOffset  提示框的纵坐标
 *  @param fontSize 提示框的文字大小
 */
- (void)showHUDWithText:(NSString *)text mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset font:(CGFloat)fontSize;

- (void)hide:(BOOL)animated;

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

- (CGFloat)HUDOffsetY;





/**
 *  当没有数据时，显示提示框
 *
 *  @param tip 提示的文字
 *  @param y   提示框的纵坐标
 */
- (void)showDataEmptyTip:(NSString *)tip positionY:(CGFloat)y;

- (void)hideDataEmptyTip;





/**
 计算边框

 @return 长度
 */
- (CGFloat)multiplesForPhone;

/**
 *  根据子视图得到某个特定类型的父视图View
 *
 *  @param aClass 特定类型
 *  @param sender 子视图
 *
 *  @return 某个特定类型的View
 */
- (id)isCorrectViewWithClass:(Class)aClass subView:(id)sender;




/**
 *  按钮设置网络背景图(默认 UIViewContentModeScaleAspectFit)
 *
 *  @param button 按钮
 *  @param urlStr 网址字符串
 */
- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr;

- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr contentModeFlag:(BOOL)flag;



/**
 *  富文本
 *
 *  @param allStr   需要处理的整个字符串
 *  @param rangeStr 需要处理的部分字符串
 *  @param flag     是否需要下划线
 *
 *  @return 处理后的富文本
 */
- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr underLineFlag:(BOOL)flag;

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font;

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font underLineFlag:(BOOL)flag;

@end
