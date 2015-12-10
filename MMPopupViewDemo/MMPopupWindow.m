//
//  MMPopupWindow.m
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/7.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "MMPopupWindow.h"

@implementation MMPopupWindow



-(instancetype)init {
    self = [super init];
    if (self) {
        
        self.windowLevel = UIWindowLevelStatusBar + 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionTap:)];
        [self addGestureRecognizer:tap];
        
    }
    
    return self;
}

+(MMPopupWindow *)shareWindow {
    static MMPopupWindow *shareWindow;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
       
        shareWindow  =[[MMPopupWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        shareWindow.rootViewController  =[UIViewController new];
    });
    return shareWindow;
}

- (void)actionTap:(UIGestureRecognizer *)geust {
    
}

-(UIView *)attachView {
    
    return self.rootViewController.view;
}
@end
