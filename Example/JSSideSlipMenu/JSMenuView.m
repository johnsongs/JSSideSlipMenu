//
//  JSMenuView.m
//  JSSideSlipMenu_Example
//
//  Created by Johnson on 2017/12/11.
//  Copyright © 2017年 johnsongs. All rights reserved.
//

#import "JSMenuView.h"
#import "JSNextViewController.h"
#import "JSSideSlipMenu.h"

@implementation JSMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"cusstom view";
        label.font = [UIFont systemFontOfSize:20];
        label.frame = CGRectMake(80, 30, 0, 0);
        [label sizeToFit];
        [self addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"push next view controller" forState:UIControlStateNormal];
        button.frame = CGRectMake(30, 100, 240, 80);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor lightGrayColor]];
        [button addTarget:self action:@selector(pushNextViewController:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (void)pushNextViewController:(UIButton *)button {
    JSNextViewController *nextViewController = [[JSNextViewController alloc] init];
    [self pushViewController:nextViewController];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
