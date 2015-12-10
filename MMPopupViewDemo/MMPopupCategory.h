//
//  UIColor+MMPopup.h
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/7.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MMPopup)
+ (UIColor *) mm_colorWithHex:(NSUInteger)hex;

@end

@interface UIButton (MMPopup)

+ (id) mm_buttonWithTarget:(id)target action:(SEL)sel;

@end

@interface UIImage (MMPopup)

+ (UIImage *) mm_imageWithColor:(UIColor *)color;

@end

@interface UIView (MMPopup)

@property (nonatomic, strong, readonly) UIView         *mm_dimBackgroundView;
@property (nonatomic, assign, readonly) BOOL           mm_dimBackgroundAnimating;
@property (nonatomic, assign          ) NSTimeInterval mm_dimAnimationDuration;

- (void) mm_showDimBackground;
- (void) mm_hideDimBackground;

- (void) mm_distributeSpacingHorizontallyWith:(NSArray*)view;
- (void) mm_distributeSpacingVerticallyWith:(NSArray*)view;


@end