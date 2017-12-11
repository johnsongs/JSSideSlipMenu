//
//  JSViewController.m
//  JSSideSlipMenu
//
//  Created by johnsongs on 12/11/2017.
//  Copyright (c) 2017 johnsongs. All rights reserved.
//

#import "JSViewController.h"
#import "JSSideSlipMenu.h"

@interface JSViewController ()

@end

@implementation JSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [JSSideSlipMenu sharedSlipMenu].menuCanGesture = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [JSSideSlipMenu sharedSlipMenu].menuCanGesture = NO;
}

- (void)showMenu {
    [[JSSideSlipMenu sharedSlipMenu] showSideAnimationComplete:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
