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
#import "MMSheetView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MMPopupViewDemo";
    self.tableView            = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"e"];
    
    
    self.dataSource = @[@"AlertView Default",@"AlertView Conform",@"Default Sheet view"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"e"];
    cell.textLabel.text   = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MMItemHanfler handler = ^(NSInteger idx) {
        NSLog(@"click item idx = %ld",(long)idx);
    };
    
    MMPopupBlock completeBlock = ^(MMPopupView *popupView) {
      
        
    };

    switch (indexPath.row) {
        case 0:
        {
            NSArray *items = @[MMPopupViewMake(@"OK", MMItemTypeNormal, handler),
                               MMPopupViewMake(@"Save", MMItemTypeHighlight, handler),
                               MMPopupViewMake(@"Cancle", MMItemTypeDisabled, nil)];
            
            MMAlertView *alertView = [[MMAlertView alloc]initWithTitle:@"是否保存" detail:@"莫斯科没有眼泪" items:items];
            alertView.attachedView = self.view;
            [alertView show];

            break;
        }
        case 1:
        {
            NSArray *items = @[MMPopupViewMake(@"OK", MMItemTypeHighlight, nil)];
            MMAlertView *alertView = [[MMAlertView alloc]initWithTitle:@"警告" detail:@"是否要删除所选商品" items:items];
//            alertView.attachedView = self.view;
            [alertView show];

            break;
        }
            
        case 2:
        {
            NSArray *items = @[MMPopupViewMake(@"OK", MMItemTypeHighlight, handler),
                               MMPopupViewMake(@"height lighted", MMItemTypeHighlight, handler),
                               MMPopupViewMake(@"Normal", MMItemTypeHighlight, handler)];
            
            MMSheetView *sheetView =  [[MMSheetView alloc]initSheetViewWithTitle:@"<< MMSheeetView >>" items:items];
//            sheetView.attachedView = self.tableView.superview;
            [sheetView showWithBlock:completeBlock];
            
            break;
        }
        default:
            break;
    }
}

- (void)showIntegView {
    
    

}

@end
