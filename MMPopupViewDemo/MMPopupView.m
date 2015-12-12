//
//  MMPopupView.m
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/2.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "MMPopupView.h"
#import "MMPopupCategory.h"
#import <Masonry.h>
#import "MMPopupWindow.h"
@interface MMPopupView ()


@end
@implementation MMPopupView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self  =[super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}
- (void)setup {
    
    self.type = MMItemTypeAlert;
    self.animationDuration = 0.3;
    
}

-(void)setType:(MMPopupType )type {
    
    _type = type;
    switch (type) {
        case MMItemTypeAlert:
        {
            self.showAnimation  = [self alertShowAnimation];
            self.hideAnimation = [self alertHideAniamtion];
            break;
        }
            
        case MMItemTypeSheet:
        {
            self.showAnimation = [self sheetShowAnimation];
            self.hideAnimation = [self sheetHideAniamiton];
            break;
        }
        default:
            break;
    }
}
- (void)show
{
    [self showWithBlock:nil];
}

- (void)showWithBlock:(MMPopupBlock)block
{
   
    if ( !self.attachedView )
    {
        self.attachedView = [MMPopupWindow shareWindow].attachView;
    }
    [self.attachedView mm_showDimBackground];
    
    NSAssert(self.showAnimation, @"show animation must be there");
    self.showAnimation(self);
    
 
}

- (void)hide
{
    [self hideWithBlock:nil];
}

- (void)hideWithBlock:(MMPopupBlock)block
{
//    if ( block )
//    {
//        self.hideCompletionBlock = block;
//    }
    
    if ( !self.attachedView )
    {
        self.attachedView = [MMPopupWindow shareWindow].attachView;
    }
    
    [self.attachedView mm_hideDimBackground];
    NSAssert(self.hideAnimation, @"hide animation must be there");
    self.hideAnimation(self);
}

- (MMPopupBlock )alertShowAnimation {
    
    __weak typeof(self)weakself = self;
    
    MMPopupBlock  block = ^(MMPopupView *popupView){
        [weakself.attachedView.mm_dimBackgroundView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakself.attachedView);
        }];
        [self layoutIfNeeded];
        
        self.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.2f);
        self.alpha = 0.0f;
        
        [UIView animateWithDuration:self.animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.layer.transform  =CATransform3DIdentity;
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            if (self.showCompletionBlock) {
                self.showCompletionBlock(self);
            }
        }];
    };
    return block;
}
- (MMPopupBlock )alertHideAniamtion {

//    __weak typeof(self)weakself = self;
    MMPopupBlock block = ^(MMPopupView *popupView){
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options: UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             
                             [self removeFromSuperview];
                             
                             if ( self.hideCompletionBlock )
                             {
                                 self.hideCompletionBlock(self);
                             }
                             
                         }];
    };
    
    
    return block;
}
- (MMPopupBlock )sheetShowAnimation {
    
    MMPopupBlock block = ^(MMPopupView *popupView) {
        
//        添加到灰色背景上
        [self.attachedView.mm_dimBackgroundView addSubview:self];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.attachedView);
            make.bottom.equalTo(self.attachedView.mas_bottom).offset(self.attachedView.frame.size.width);
            
        }];
        [self layoutIfNeeded];
        [UIView animateWithDuration:self.animationDuration animations:^{
           
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.attachedView.mas_bottom).offset(0);
            }];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (self.showCompletionBlock) {
                self.showCompletionBlock(self);
            }
        }];
        
    };
    return block;
}

- (MMPopupBlock ) sheetHideAniamiton {
    
    MMPopupBlock block = ^(MMPopupView *popupView) {
        
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.attachedView.mas_bottom).offset(self.attachedView.frame.size.height);
        }];
        [self layoutIfNeeded];

    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        if (self.hideCompletionBlock) {
            self.hideCompletionBlock(self);
        }

    }];
    };
    
    return block;
}
@end
