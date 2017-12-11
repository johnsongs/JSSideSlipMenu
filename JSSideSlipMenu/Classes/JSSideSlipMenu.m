//
//  JSSideSlipMenu.m
//  JSSideSlipMenu
//
//  Created by Johnson on 2017/10/16.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import "JSSideSlipMenu.h"

#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define KeyWindow [[UIApplication sharedApplication] keyWindow]

#define kSideWidth       (SCREEN_WIDTH-SCREEN_WIDTH/3)

@interface JSSideSlipMenu () <UIGestureRecognizerDelegate> {
    JSPanDirection panDirection;
    BOOL showSide;
}

@property (nonatomic, assign) Class menuViewclass;
@property (nonatomic, strong) UIView *sideMenuView; //MENU CONTAINER
@property (nonatomic, strong) UIView *menuView;     //MENU VIEW
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, assign) BOOL closeSideMenuAnimation;

@end

@implementation JSSideSlipMenu

+ (instancetype)sharedSlipMenu {
    static dispatch_once_t onceToken;
    static JSSideSlipMenu *menuRoot;
    dispatch_once(&onceToken, ^{
        menuRoot = [[JSSideSlipMenu alloc] init];
    });
    return menuRoot;
}

- (instancetype)init {
    if (self = [super init]) {
        _menuCanGesture = YES;
    }
    return self;
}

- (void)setMenuSideView:(__weak Class)sideViewClass withControlNavigation:(UINavigationController *)navigation {
    self.menuViewclass = sideViewClass;
    
    self.navigationController = navigation;
    
    self.closeSideMenuAnimation = NO;
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureCallBack:)];
    [pan setDelegate:self];
    [KeyWindow.rootViewController.view addGestureRecognizer:pan];
    
    [self addSideView];
    [self addPangesture];
}

- (void)addSideView {
    if (!_sideMenuView) {
        _sideMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _sideMenuView.hidden = YES;
        
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backImageView.backgroundColor = [UIColor blackColor];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.alpha = 0;
        [_sideMenuView addSubview:_backImageView];
        
        _menuView = [[NSClassFromString(NSStringFromClass(_menuViewclass)) alloc] initWithFrame:CGRectMake(-kSideWidth, 0, kSideWidth, SCREEN_HEIGHT)];
        _menuView.backgroundColor = [UIColor whiteColor];
        [_sideMenuView addSubview:_menuView];
        
        [KeyWindow.rootViewController.view addSubview:_sideMenuView];
    }
}

- (void)addPangesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCallBack:)];
    tap.numberOfTapsRequired = 1;
    [self.backImageView addGestureRecognizer:tap];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return _menuCanGesture;
}

-(void)panGestureCallBack:(UIPanGestureRecognizer *)panGesture{
    self.sideMenuView.hidden = NO;
    [KeyWindow.rootViewController.view bringSubviewToFront:_sideMenuView];
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
//            ((id(*)(id, SEL))objc_msgSend)(_menuView, NSSelectorFromString(@"viewWillShow"));
            CGPoint locationPoint = [panGesture locationInView:KeyWindow.rootViewController.view];
            if (locationPoint.x < SCREEN_WIDTH/3) {
                if(self.closeSideMenuAnimation){
                    [panGesture setEnabled:NO];
                    break;
                }else {
                    [self addSideView];
                    _backImageView.alpha = 0;
                }
            }else {
                [panGesture setEnabled:NO];
                break;
            }
            
        }
        case UIGestureRecognizerStateChanged:{
            CGPoint velocityPoint = [panGesture velocityInView:KeyWindow.rootViewController.view];
            CGPoint translationPoint = [panGesture translationInView:KeyWindow.rootViewController.view];
            
            CGRect menuViewFrame = self.menuView.frame;
            if (velocityPoint.x > 0) {
                panDirection = JSPanDirectionRight;
                menuViewFrame.origin.x = _menuView.frame.origin.x + ABS(translationPoint.x);
                self.backImageView.alpha = ABS(0.5*(self.menuView.frame.origin.x+self.menuView.frame.size.width)/_menuView.frame.size.width);
                if (self.menuView.frame.origin.x >= 0) {
                    menuViewFrame.origin.x = 0;
                    self.backImageView.alpha = 0.5;
                }
                [panGesture setTranslation:CGPointZero inView:KeyWindow.rootViewController.view];
            }else {
                panDirection = JSPanDirectionLeft;
                menuViewFrame.origin.x = _menuView.frame.origin.x - ABS(translationPoint.x);
                self.backImageView.alpha = ABS(0.5*(self.menuView.frame.origin.x+self.menuView.frame.size.width)/_menuView.frame.size.width);
                
                if (ABS(self.menuView.frame.origin.x) > _menuView.frame.size.width) {
                    menuViewFrame.origin.x = -_menuView.frame.size.width;
                    self.backImageView.alpha = 0;
                }
                [panGesture setTranslation:CGPointZero inView:KeyWindow.rootViewController.view];
            }
            self.menuView.frame = menuViewFrame;
            break;
        }
        case UIGestureRecognizerStateEnded:{
            if (!showSide) {
                if (ABS(_menuView.frame.origin.x) < _menuView.frame.size.width*2/3) {
                    [self showSideAnimation];
                }else {
                    [self hideSideAnimation];
                }
                
            }else if (showSide){
                if (ABS(_menuView.frame.origin.x) > _menuView.frame.size.width/4) {
                    [self hideSideAnimation];
                }else {
                    [self showSideAnimation];
                }
            }
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            [panGesture setEnabled:YES];
            [self hideSideAnimation];
            break;
        }
        default:
            break;
    }
}

- (void)tapGestureCallBack:(UITapGestureRecognizer *)gesture {
    if (showSide) {
        [self hideSideAnimation];
    }
}

- (void)showSideAnimationComplete:(void(^)(void))complete {
    self.sideMenuView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.menuView.frame = CGRectMake(0, _menuView.frame.origin.y, _menuView.frame.size.width, _menuView.frame.size.height);
        self.backImageView.alpha = 0.5;
    } completion:^(BOOL finished) {
        showSide = YES;
        if (complete) {
            complete();
        }
    }];
}

- (void)showSideAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.menuView.frame = CGRectMake(0, _menuView.frame.origin.y, _menuView.frame.size.width, _menuView.frame.size.height);
        self.backImageView.alpha = 0.5;
    } completion:^(BOOL finished) {
        showSide = YES;
    }];
}

- (void)hideSideAnimation {
    if (!_closeSideMenuAnimation) {
        [UIView animateWithDuration:0.5 animations:^{
            self.closeSideMenuAnimation = YES;
            self.menuView.frame = CGRectMake(-_menuView.frame.size.width, _menuView.frame.origin.y, _menuView.frame.size.width, _menuView.frame.size.height);
            self.backImageView.alpha = 0;
        } completion:^(BOOL finished) {
            self.closeSideMenuAnimation = NO;
            showSide = NO;
            _sideMenuView.hidden = YES;
        }];
    }
    
}

@end

@implementation UIView (JSSideMenuNavigationCategory)

- (void)pushViewController:(UIViewController *)viewController {
    [[JSSideSlipMenu sharedSlipMenu].navigationController pushViewController:viewController animated:YES];
    [[JSSideSlipMenu sharedSlipMenu] hideSideAnimation];
}

@end
