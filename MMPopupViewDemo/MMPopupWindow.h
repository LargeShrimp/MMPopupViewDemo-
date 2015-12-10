//
//  MMPopupWindow.h
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/7.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMPopupWindow : UIWindow

@property (nonatomic,assign)BOOL touchWildToHide;
@property (nonatomic,strong) UIView *attachView;

+ (MMPopupWindow *)shareWindow;
@end
