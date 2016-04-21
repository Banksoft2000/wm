//
//  YYEditView.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/9.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYShoppingModel.h"

@class YYShoppingController;
@protocol EditDelegate <NSObject>

- (void)productModel:(YYShoppingModel *)model withSection:(NSInteger)section withRow:(NSInteger)row;

@end

@interface YYEditView : UIView

@property (weak, nonatomic) id<EditDelegate> editDelegate;

@property (strong, nonatomic) YYShoppingModel *model;

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger row;
@property (assign, nonatomic) int buyNum;
@property (strong, nonatomic) IBOutlet UIView *numberView;
@property (strong, nonatomic) IBOutlet UILabel *staic;
@property (strong, nonatomic) IBOutlet UIButton *delegate;

- (IBAction)deleteData:(UIButton *)sender;

- (void)initNumberView;
@end
