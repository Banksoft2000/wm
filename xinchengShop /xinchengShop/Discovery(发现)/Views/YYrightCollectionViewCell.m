//
//  YYrightCollectionViewCell.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/25.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYrightCollectionViewCell.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>


@interface YYrightCollectionViewCell ()
@property(strong,nonatomic)UIImageView *roomImageView;
@property(strong,nonatomic)UILabel *roomLabel;
@end

static const CGFloat collectionCellHeight=80;
static const CGFloat labelHeight=20;

@implementation YYrightCollectionViewCell

//cell的重用
-(instancetype)initWithFrame:(CGRect)frame{


    self = [super initWithFrame:frame];
    if (self) {
        if (self.roomImageView==nil) {

            self.roomImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-80-10*3)/4, collectionCellHeight-labelHeight)];
            self.roomImageView.contentMode=UIViewContentModeScaleAspectFill;
            self.roomImageView.clipsToBounds = YES;
            self.roomImageView.layer.masksToBounds = YES;
            self.roomImageView.layer.cornerRadius = 2.0;
            [self.contentView addSubview:self.roomImageView];
        }
        
        if (self.roomLabel==nil) {
            self.roomLabel=[[UILabel alloc]init];
            self.roomLabel.font=[UIFont systemFontOfSize:8];
            self.roomLabel.textColor = [UIColor grayColor];
            self.roomLabel.textAlignment=NSTextAlignmentCenter;
            [self.roomLabel sizeToFit];
            [self.contentView addSubview:self.roomLabel];
            [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.roomImageView.mas_bottom).with.offset(2);
                make.centerX.mas_equalTo(self.roomImageView).with.offset(0);
                make.height.mas_equalTo(labelHeight);
            }];
            
        }
    }
    
    return self;
}

-(void)setCurNoHeadRightModel:(YYProduct *)curNoHeadRightModel{

    _curNoHeadRightModel = curNoHeadRightModel;
    NSString *imageFile = [NSString stringWithFormat:@"http://xinchengguangchang.com%@",_curNoHeadRightModel.icon];
    
    [self.roomImageView sd_setImageWithURL:[NSURL URLWithString:imageFile] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
    self.roomLabel.text = _curNoHeadRightModel.name;
}



+(CGSize)ccellSize{


     return CGSizeMake(([UIScreen mainScreen].bounds.size.width-80-10*3)/3,collectionCellHeight);
}
@end
