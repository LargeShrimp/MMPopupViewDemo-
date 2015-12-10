//
//  ViewController.m
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/2.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "ViewController.h"
#import "MMPopupView.h"
#import "MMPopupViewItem.h"
#import "MMAlertView.h"
#import "MMPopupCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(200   , 200, 120, 40)];

    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];

    [btn addTarget:self action:@selector(showIntegView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}


- (void)showIntegView {
    
    MMItemHanfler handler = ^(NSInteger idx) {
        NSLog(@"click item idx = %d",idx);
        
        
    };
    
    NSArray *items = @[MMPopupViewMake(@"OK", MMItemTypeNormal, handler),
                       MMPopupViewMake(@"Save", MMItemTypeHighlight, handler),
                       MMPopupViewMake(@"Cancle", MMItemTypeDisabled, handler)];
    
    MMAlertView *alertView = [[MMAlertView alloc]initWithTitle:@"是否保存" detail:@"莫斯科没" items:items];
    
    
    alertView.attachedView = self.view;
    
    [alertView show];

}

@end
