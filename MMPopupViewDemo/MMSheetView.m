//
//  MMSheetView.m
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/11.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "MMSheetView.h"
#import "MMPopupCategory.h"
#import <Masonry.h>
#import "MMPopupViewItem.h"
#define MMHexColor(color)   [UIColor mm_colorWithHex:color]

@interface MMSheetView ()

@property (nonatomic,strong) NSArray  *actionItems;
@property (nonatomic,strong) UIView   *titleView;
@property (nonatomic,strong) UILabel  *titleLabel;
@property (nonatomic,strong) UIView   *buttonView;
@property (nonatomic,strong) UIButton *cancleButton;

@end
@implementation MMSheetView

- (instancetype)initSheetViewWithTitle:(NSString *)title items:(NSArray *)items {
    
    if (self = [super init]) {
        
        NSAssert(items.count > 0, @"Count find any items ");
        self.type        = MMItemTypeSheet;
        self.actionItems = items;
        MMSheetViewConfig *config = [MMSheetViewConfig globalConfig];
        self.backgroundColor      = config.splitColor;
        
        //添加约束
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        }];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        
        if (title.length > 0) {
            self.titleView = [UILabel new];
            [self addSubview:self.titleView];
//            self.titleView.backgroundColor = config.backgroundColor;
            [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.and.top.equalTo(self);
            }];
                        
            self.titleLabel = [UILabel new];
            [self.titleView addSubview:self.titleLabel];
            self.titleLabel.text = title;
            self.titleLabel.textColor = config.titleColor;
//            self.titleLabel.backgroundColor = config.backgroundColor;
            self.titleLabel.font = [UIFont systemFontOfSize:config.titleFontSize];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.numberOfLines = 0;
            
            self.titleLabel.backgroundColor = [UIColor redColor];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.edges.equalTo(self.titleView).insets(UIEdgeInsetsMake(config.innerMargin, config.innerMargin, config.innerMargin, config.innerMargin));
            }];
            
            lastAttribute = self.titleView.mas_bottom;
        }
        
//        按钮的设置
        self.buttonView = [UIView new];
        [self addSubview:self.buttonView];
        
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(lastAttribute);
            
        }];
        
        
        __block UIButton *firstButton = nil;
        __block UIButton *lastButton  = nil;
        
        for (NSInteger i = 0; i < items.count;i++) {
            
            MMPopupViewItem *item = items[i];
            UIButton *btn = [UIButton mm_buttonWithTarget:self action:@selector(actionButton:)];
            [self.buttonView addSubview:btn];
            btn.tag = i;
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.equalTo(self.buttonView).insets(UIEdgeInsetsMake(0, -(1/[UIScreen mainScreen].scale), 0, -(1/[UIScreen mainScreen].scale)));
                make.height.mas_equalTo(config.buttonHeight);
                
                if ( !firstButton ) {
                    
                    firstButton = btn;
                    make.top.equalTo(self.buttonView.mas_top).offset(-5);
                    
                }else {
                    
                    make.top.equalTo(lastButton.mas_bottom).offset(-5);
                    make.height.equalTo(firstButton);
                    
                }
                
                lastButton = btn;
            }];
            
            [btn setBackgroundImage:[UIImage mm_imageWithColor:config.backgroundColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage mm_imageWithColor:config.backgroundColor] forState:UIControlStateDisabled];
            [btn setBackgroundImage:[UIImage mm_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn setTitleColor:config.itemNormalColor forState:UIControlStateNormal];
            btn.titleLabel.font   = [UIFont systemFontOfSize:config.buttonFontSize];
            btn.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
            btn.layer.borderColor = config.splitColor.CGColor;
//            btn.enabled = !items.di
            
        }
        
        [lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.buttonView.mas_bottom).offset(5);
        }];
        
        
        //取消按钮
        
        self.cancleButton = [UIButton mm_buttonWithTarget:self action:@selector(actionCancle)];
        [self addSubview:self.cancleButton];
        [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.buttonView);
            make.top.equalTo(self.buttonView.mas_bottom).offset(8);
            make.height.mas_equalTo(config.buttonHeight);
        }];
        
        self.cancleButton.titleLabel.font = [UIFont systemFontOfSize:config.buttonFontSize];
        [self.cancleButton setBackgroundImage:[UIImage mm_imageWithColor:config.backgroundColor] forState:UIControlStateNormal];
        [self.cancleButton setBackgroundImage:[UIImage mm_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
        [self.cancleButton setTitle:config.defaultTextCancel forState:UIControlStateNormal];
        [self.cancleButton setTitleColor:config.itemNormalColor forState:UIControlStateNormal];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cancleButton.mas_bottom);
        }];
    }
    return self;
    
    
}


- (void)actionButton:(UIButton*)btn
{
    MMPopupViewItem *item = self.actionItems[btn.tag];
    
    [self hide];
    
    if ( item.handler )
    {
        item.handler(btn.tag);
    }
}

- (void)actionCancle {
    
    [self hide];
}
@end

@implementation MMSheetViewConfig


+(instancetype)globalConfig {
    
    static MMSheetViewConfig *config;
    dispatch_once_t token;
    dispatch_once(&token, ^{
       
        config = [MMSheetViewConfig new];
    });
    
    return config;
}

- (instancetype)init {
    
    self  = [super init];
    if (self) {
        
        self.buttonHeight   = 50.0f;
        self.innerMargin    = 19.0f;
        
        self.titleFontSize  = 14.0f;
        self.buttonFontSize = 17.0f;
        
        self.backgroundColor    = [UIColor whiteColor];
        self.titleColor         =  [UIColor blackColor];
        self.splitColor         = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        
        self.itemNormalColor    = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        self.itemDisableColor   = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        self.itemHighlightColor = [UIColor colorWithRed:231/255.0 green:97/255.0  blue:83/255.0  alpha:1];
        self.itemPressedColor   = MMHexColor(0xEFEDE7FF);
        
        self.defaultTextCancel  = @"取消";

    }
    return self;
}
@end