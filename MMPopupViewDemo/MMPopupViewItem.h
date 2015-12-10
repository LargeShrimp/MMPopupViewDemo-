//
//  MMPopupViewItem.h
//  MMPopupViewDemo
//
//  Created by taitanxiami on 15/12/2.
//  Copyright © 2015年 taitanxiami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^MMItemHanfler)(NSInteger index);
@interface MMPopupViewItem : NSObject
@property (nonatomic)BOOL highlight;
@property (nonatomic)BOOL disabled;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,copy) MMItemHanfler handler;

@end

//item type
typedef NS_ENUM(NSInteger,MMItemType) {
    
    MMItemTypeNormal,
    MMItemTypeHighlight,
    MMItemTypeDisabled
};


///创建item 

NS_INLINE MMPopupViewItem *MMPopupViewMake(NSString *title,MMItemType type,MMItemHanfler handler) {
    
    MMPopupViewItem *item = [MMPopupViewItem new];
    item.title = title;
    item.handler = handler;
    
    switch (type) {
        case MMItemTypeNormal:
        {
            break;
        }
        case MMItemTypeHighlight:
        {
            item.highlight = YES;
            break;
        }
        case MMItemTypeDisabled:
        {
            item.disabled = YES;
            break;
        }
        default:
            break;
    }
    return item;
}
