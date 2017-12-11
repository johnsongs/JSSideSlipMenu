//
//  JSSideSlipMenu.h
//  JSSideSlipMenu
//
//  Created by Johnson on 2017/10/25.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JSPanDirection) {
    JSPanDirectionLeft      = 0,
    JSPanDirectionRight     = 1
};

@interface JSSideSlipMenu : NSObject

+ (instancetype)sharedSlipMenu;

@property (nonatomic, assign) BOOL menuCanGesture;

//- (void)setMenuSideView:(UIView *)sideView withRootViewController:(UIViewController *)viewController;
/**
 设置侧边栏的view
 
 @param sideViewClass 侧边栏的类名
 */
- (void)setMenuSideView:(__weak Class)sideViewClass withControlNavigation:(UINavigationController *)navigation;

//返回侧边栏的view
- (UIView *)menuView;

//显示侧边栏
- (void)showSideAnimationComplete:(void(^)(void))complete;

@end

@interface UIView (JSSideMenuNavigationCategory)

- (void)pushViewController:(UIViewController *)viewController;

@end
