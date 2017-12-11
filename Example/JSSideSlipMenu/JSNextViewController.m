//
//  JSNextViewController.m
//  JSSideSlipMenu_Example
//
//  Created by Johnson on 2017/12/11.
//  Copyright © 2017年 johnsongs. All rights reserved.
//

#import "JSNextViewController.h"
#import "JSSideSlipMenu.h"

@interface JSNextViewController ()

@end

@implementation JSNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightTextColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"next view";
    label.font = [UIFont systemFontOfSize:20];
    label.frame = CGRectMake(90, 100, 0, 0);
    [label sizeToFit];
    [self.view addSubview:label];
    // Do any additional setup after loading the view.
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
