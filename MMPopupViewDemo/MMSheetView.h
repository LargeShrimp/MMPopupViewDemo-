//
//  MMSheetView.h
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/11.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "MMPopupView.h"

@interface MMSheetView : MMPopupView


- (instancetype)initSheetViewWithTitle:(NSString *)title items:(NSArray *)items;

@end


@interface MMSheetViewConfig: NSObject

+(instancetype)globalConfig;

@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 50.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 19.

@property (nonatomic, assign) CGFloat titleFontSize;        // Default is 14.
@property (nonatomic, assign) CGFloat buttonFontSize;       // Default is 17.

@property (nonatomic, strong) UIColor *backgroundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *titleColor;          // Default is #666666.
@property (nonatomic, strong) UIColor *splitColor;          // Default is #CCCCCC.

@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is #333333. effect with MMItemTypeNormal
@property (nonatomic, strong) UIColor *itemDisableColor;    // Default is #CCCCCC. effect with MMItemTypeDisabled
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is #E76153. effect with MMItemTypeHighlight
@property (nonatomic, strong) UIColor *itemPressedColor;    // Default is #EFEDE7.

@property (nonatomic, strong) NSString *defaultTextCancel;  // Default is "取消"
@end