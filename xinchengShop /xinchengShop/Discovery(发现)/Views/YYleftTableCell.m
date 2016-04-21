//
//  YYleftTableCell.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/25.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYleftTableCell.h"


@interface YYleftTableCell()
@property(strong,nonatomic)UIView *leftColorView;
@property(strong,nonatomic)UILabel *nameLabel;
@end


//左边色彩条宽度
static const CGFloat leftColorViewWidth=0;
//文字字体大小
static const CGFloat textFontSize=12;

@implementation YYleftTableCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置背影色
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        if (self.leftColorView==nil) {
            self.leftColorView=[[UIView alloc]init];
            self.leftColorView.backgroundColor=[UIColor clearColor];
            self.leftColorView.hidden=YES;
            [self.contentView addSubview:self.leftColorView];
            [self.leftColorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView.mas_left).with.offset(0);
                make.top.mas_equalTo(self.contentView.mas_top).with.offset(0);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(0);
                make.width.mas_equalTo(leftColorViewWidth);
            }];
        }
        
        if (self.nameLabel==nil) {
            self.nameLabel=[[UILabel alloc]init];
            self.nameLabel.font=[UIFont systemFontOfSize:textFontSize];
            self.nameLabel.textAlignment=NSTextAlignmentCenter;
            self.nameLabel.textColor = [UIColor grayColor];
            [self.nameLabel sizeToFit];
            [self.contentView addSubview:self.nameLabel];
            [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.contentView);
                make.left.mas_offset(@10);
                make.height.mas_equalTo(@20);
            }];
        }
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//设置选中跟没选中的区别
-(void)setHasBeenSelected:(BOOL)hasBeenSelected{

    _hasBeenSelected = hasBeenSelected;
    if (_hasBeenSelected) {
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = [UIColor grayColor];
        self.leftColorView.hidden = NO;
    }else{
    
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.nameLabel.textColor=[UIColor grayColor];
        self.leftColorView.hidden=YES;
    }
    
}

-(void)setCurLeftTagModel:(YYProductType *)curLeftTagModel{

    _curLeftTagModel = curLeftTagModel;
    self.nameLabel.text = _curLeftTagModel.name;
}

@end
