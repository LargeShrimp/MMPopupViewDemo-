//
//  MMPopupView.h
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/2.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,MMPopupType){
    
    MMItemTypeAlert,
    MMItemTypeSheet,
    MMItemTypeCustom
};
@class MMPopupView;
typedef void (^MMPopupBlock)(MMPopupView *popupView);

@interface MMPopupView : UIView

@property (nonatomic,strong) UIView *attachedView;
@property (nonatomic,copy)MMPopupBlock showAnimation;
@property (nonatomic,copy)MMPopupBlock hideAnimation;

//动画时间
@property (nonatomic,assign)NSTimeInterval animationDuration;

@property (nonatomic,assign)MMPopupType type;

@property (nonatomic,copy) MMPopupBlock hideCompletionBlock;
@property (nonatomic,copy) MMPopupBlock  showCompletionBlock;
//@property (nonatomic,copy) MMPopupBlock 

- (void) show;
- (void) hide;

@end
