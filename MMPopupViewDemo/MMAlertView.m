//
//  MMAlertView.m
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/2.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import "MMAlertView.h"
#import "MMPopupCategory.h"
#import <Masonry.h>
#import "MMPopupViewItem.h"
#define MMHexColor(color)   [UIColor mm_colorWithHex:color]

@interface MMAlertView ()

@property (nonatomic,strong)UILabel *detailLabel;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UIView *buttonView;

@end

@implementation MMAlertView

-(instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail items:(NSArray *)items {
    
    self = [super init];
    
    if (self) {
        
//        如果items.count == 0，输出log信息
        NSAssert(items.count > 0, @"Count not find any item");
        self.actionItems = items;
        
        //单例访问全局配置信息
        MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
        
        //基本配置
        self.layer.cornerRadius = config.cornerRadius;
        self.layer.masksToBounds = YES;
        self.backgroundColor = config.backgroundColor;
        self.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        self.layer.borderColor = config.splitColor.CGColor;
        
        //宽
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(config.width);
        }];
        
        MASViewAttribute *attibute = self.mas_top;
        
        //title
        if (title.length > 0)
        {
            self.titleLable = [UILabel new];
            [self addSubview:self.titleLable];
            [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(attibute).offset(20);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            }];
            
            self.titleLable.textColor = config.titleColor;
            self.titleLable.textAlignment = NSTextAlignmentCenter;
            self.titleLable.numberOfLines = 0;
            self.titleLable.font = [UIFont systemFontOfSize:config.titleFontSize];
            self.titleLable.text = title;
            
            attibute = self.titleLable.mas_bottom;
        }
        
        //detialLabel
        
        if (detail.length > 0) {
            
            self.detailLabel  = [UILabel new];
            [self addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              
                make.top.equalTo(attibute).offset(5);
                make.left.and.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
                
            }];
            
            self.detailLabel.textAlignment = NSTextAlignmentCenter;
            self.detailLabel.textColor = config.titleColor;
            self.detailLabel.text = detail;
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.backgroundColor = config.backgroundColor;
            self.detailLabel.font = [UIFont systemFontOfSize:config.titleFontSize];
            attibute = self.detailLabel.mas_bottom;
        }
        
        //按钮的父view buttonView
        self.buttonView = [UIView new];
        [self addSubview:self.buttonView];
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(attibute).offset(25);
            make.left.and.right.equalTo(self);
        }];
        
        __block UIButton *firstButton = nil;
        __block UIButton *lastButton = nil;
        
        for (NSInteger i = 0; i < items.count; i++) {
            
            MMPopupViewItem *item = items[i];
            UIButton *btn = [UIButton mm_buttonWithTarget:self action:@selector(actionButton:)];
            [self.buttonView addSubview:btn];
            btn.tag = i;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                //按钮的数量 2
                if (items.count <= 2)
                {
                    make.top.bottom.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);
                    
                    if ( !firstButton )
                    {
                        firstButton = btn;
                        make.left.equalTo(self.buttonView.mas_left).offset(-5);
                        
                    }else
                    {
                        make.left.equalTo(lastButton.mas_right).offset(-5);
                        make.width.equalTo(firstButton);
                    }
                    
                }else
                {
                    //items.count > 2
                    make.left.and.right.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);
                    
                    if (!firstButton) {
                        
                        firstButton = btn;
                        make.top.equalTo(self.buttonView.mas_top).offset(-(1/[UIScreen mainScreen].scale));
                        
                    }else {
                        make.top.equalTo(lastButton.mas_bottom).offset(-(1/[UIScreen mainScreen].scale));
                        make.width.equalTo(firstButton);
                    }
                    
                }
                
                lastButton = btn;

            }];
            [btn setBackgroundImage:[UIImage mm_imageWithColor:config.backgroundColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage mm_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn setTitleColor:item.highlight?config.itemHighlightColor:config.itemNormalColor forState:UIControlStateNormal];
            btn.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
            btn.layer.borderColor = config.splitColor.CGColor;
            btn.titleLabel.font = (btn == items.lastObject)?[UIFont boldSystemFontOfSize:config.titleFontSize]:[UIFont systemFontOfSize:config.titleFontSize];
            
        }
        
        [lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            if ( items.count <= 2) {
                
                make.right.equalTo(self.buttonView.mas_right).offset(5);
            }else {
                
                make.bottom.equalTo(self.buttonView.mas_bottom).offset(1 / [UIScreen mainScreen].scale);
            }
        }];
                           
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.buttonView.mas_bottom);
        }];
        
        
    }
    return self;
}

//处理button 的点击事件
- (void)actionButton:(UIButton *)sender {
    
    MMPopupViewItem *item = self.actionItems[sender.tag];
    
    [self hide];
    if (item.handler) {
        item.handler(sender.tag);
    }
    
    
}
@end

@implementation MMAlertViewConfig

+(MMAlertViewConfig *)globalConfig {
    static MMAlertViewConfig *config ;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
        config = [MMAlertViewConfig new];
    });
    
    return config;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.width          = 275.0f;
        self.buttonHeight   = 50.0f;
        self.innerMargin    = 25.0f;
        self.cornerRadius   = 5.0f;
        
        self.titleFontSize  = 18.0f;
        self.detailFontSize = 14.0f;
        self.buttonFontSize = 17.0f;
        
        self.backgroundColor    = MMHexColor(0xFFFFFFFF);
        self.titleColor         = MMHexColor(0x333333FF);
        self.detailColor        = MMHexColor(0x333333FF);
        self.splitColor         = MMHexColor(0xCCCCCCFF);

        
        self.itemNormalColor    = MMHexColor(0x333333FF);
        self.itemHighlightColor = MMHexColor(0xE76153FF);
        self.itemPressedColor   = MMHexColor(0xEFEDE7FF);
        
        self.defaultTextOK      = @"好";
        self.defaultTextCancel  = @"取消";
        self.defaultTextConfirm = @"确定";

    }
    
    return self;
}

@end