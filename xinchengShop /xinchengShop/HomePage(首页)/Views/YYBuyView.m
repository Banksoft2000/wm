//
//  YYBuyView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/2.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYBuyView.h"



static int i = 1;                           //购买数量
static int standNUm = 1500;                 //规格的种类
static NSMutableString *staicText = nil;    //显示状态的数据
static NSString *imageValue = nil;           //颜色数据
static NSString * textValue= nil;            //尺码数据
static NSString *otherText = nil;    //其他数据

#define IMGCOLLITEMWIDTH 50                 //显示类型为图片的时候，高度为60
#define TEXTCOLLITEMWIDTH 25                //显示类型为文字的时候，高度为25
#define TITLEHEIGHT 25                      //规格的样式

@implementation YYBuyView
{
    UIScrollView *_standScr;                  //Color
    UILabel *_numLab;                         //numBerlabel
    UIImageView *imageV;                      //colorImage
    UILabel *_sizeLab;
 
    NSMutableArray *_dataList;    //展示的数据 默认 为第一个数据
    
    NSMutableArray *_allText;
    NSMutableArray *_allID;
    
    NSMutableDictionary *_productDic;
   
}


- (void)awakeFromNib {
    
    //每次进入的时候让数量都为 1
    i = 1;
    
    //需要保存的数据
    _productDic = [[NSMutableDictionary alloc] init];
   
    //添加数量
    [self initNumberView];
    
    //规格滚动视图
    [self initStandScrollView];
 
    
    _makeSure.backgroundColor = PRICE_TEXT_RED;
    self.userInteractionEnabled = YES;

}

//滚动视图
- (void)initStandScrollView {

    _standScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _standard.height)];
    
    [_standard addSubview:_standScr];
    
    _standScr.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH);
    
    _standScr.showsHorizontalScrollIndicator = NO;
    _standScr.showsVerticalScrollIndicator = NO;
}

//设置默认
- (void)setPriceArr:(NSArray *)priceArr {
    
    _priceArr = priceArr;
 
    //转载文字----staic文字
    _allText = [[NSMutableArray alloc] init];
    //装载id ------priceModel 需要的id
    _allID = [[NSMutableArray alloc] init];
   
    //默认数据为第一个
    for (int i = 0; i < _allData.count;i ++) {
        
        NSArray *array = _allData[i];
        BaseModel *model = array[0];
        
        if ([model isKindOfClass:[YYImageModel class]]) {
            
            //设置icon 的默认图片
            YYImageModel *imageModel = (YYImageModel *)model;
            
            NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,imageModel.image];
            [_icon sd_setImageWithURL:[NSURL URLWithString:url]];
            
            //设置默认的图片  将图片保存到字典中
            [_productDic setObject:imageModel.image forKey:@"icon"];
            
            [_allText addObject:imageModel.value];
            [_allID addObject:imageModel.id];
            
        }else if ([model isKindOfClass:[YYTextModel class]]) {
            
            YYTextModel *textModel = (YYTextModel *)model;
            
            textValue = textModel.value;

            NSLog(@"%@",textModel.id);
            [_allText addObject:textValue];
            [_allID addObject:textModel.id];
        }
   
    }
    
    NSString *staicText = [_allText componentsJoinedByString:@" "];
    //拼接priceModel需要的id
    NSString *priceID = [_allID componentsJoinedByString:@"|"];
    for (YYPriceModel *priceModel in _priceArr) {
        
        if ([priceID isEqualToString:priceModel.ids]) {
            
            _price.text = [NSString stringWithFormat:@"%ld",priceModel.price];
            _sale.text = [NSString stringWithFormat:@"%ld",priceModel.stock];
            
            _staic.text = [NSString stringWithFormat:@"%@",staicText];
        }
        
        //设置默认的存储数据
        NSString *buyNumber = [NSString stringWithFormat:@"%d",i];
        [_productDic setObject:priceModel.ids forKey:@"ids"];
        [_productDic setObject:_price.text forKey:@"price"];
        [_productDic setObject:_sale.text forKey:@"stock"];
        [_productDic setObject:buyNumber forKey:@"number"];
        [_productDic setObject:_staic.text forKey:@"staic"];
        
    }

    [self initStandardView];
    
    [self.buyDelegate productDetail:_productDic];
}



//规格视图
- (void)initStandardView {
    
    int images = 0;   //规格中图片样式种类的个数
    int sizes = 0;      //规格中文字样式种类的个数
    int originY = 0;   //backView的origin.y值
    
    for (int i = 0; i < _standArr.count; i ++) {
        
        YYStandardModel *standModel = _standArr[i];
        
        NSArray *arr = _allData[i];
        
        int count = (arr.count*IMGCOLLITEMWIDTH)/SCREEN_WIDTH + 1;
       
        
        if ([standModel.type isEqualToString:@"image"]) {

             CGRect rect = CGRectMake(10, images *(IMGCOLLITEMWIDTH * TITLEHEIGHT) + sizes *(TEXTCOLLITEMWIDTH + TITLEHEIGHT), SCREEN_WIDTH, count *IMGCOLLITEMWIDTH + TITLEHEIGHT);
            
            YYStandColl *coll = [[YYStandColl alloc] initWithFrame:rect withArray:arr withHeitht:IMGCOLLITEMWIDTH withIndectity:@"image" withTitleText:standModel.name];
            
            
            coll.tag = standNUm + i;
            coll.standDelegate = self;
            [_standScr addSubview:coll];

            images ++;
   
        }else {
            
             CGRect rect = CGRectMake(10, images *(IMGCOLLITEMWIDTH + TITLEHEIGHT) + sizes *(TEXTCOLLITEMWIDTH + TITLEHEIGHT), SCREEN_WIDTH, count *TEXTCOLLITEMWIDTH + TITLEHEIGHT);
   
            YYStandColl *coll = [[YYStandColl alloc] initWithFrame:rect withArray:arr withHeitht:TEXTCOLLITEMWIDTH withIndectity:@"text" withTitleText:standModel.name];

            coll.tag = standNUm + i;
            coll.standDelegate = self;
            [_standScr addSubview:coll];
            
            sizes ++;
        }
    }
 
    //设置scrollView的contentSize
    _standScr.contentSize = CGSizeMake(SCREEN_WIDTH, originY);
}



#pragma mark - 购买数量
//购买数量
- (void)initNumberView {
    
    UIButton *subtract = [UIButton buttonWithType:UIButtonTypeCustom];
    subtract.frame = CGRectMake(0, 0, 27, 27);
     [subtract addTarget:self action:@selector(subtractAction:) forControlEvents:UIControlEventTouchUpInside];
    [subtract setImage:[UIImage imageNamed:@"pd_style_release"] forState:UIControlStateNormal];
    [_number addSubview:subtract];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(_number.width - 27, 0, 27, 27);
    [addBtn setImage:[UIImage imageNamed:@"pd_style_add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [_number addSubview:addBtn];

    _numLab = [[UILabel alloc] initWithFrame:CGRectMake(subtract.width, -2, _number.width - subtract.width*2, _number.height+4)];
    [_number addSubview:_numLab];
    
    _numLab.textAlignment = NSTextAlignmentCenter;
    _numLab.layer.borderColor = [MYGRAYCOLOR CGColor];
    _numLab.layer.borderWidth = 1;
    
    _numLab.text = @"1";
    _numLab.font = [UIFont systemFontOfSize:13];
    _numLab.clipsToBounds = YES;


    _number.clipsToBounds = YES;
    _number.layer.borderColor = [MYGRAYCOLOR CGColor];
    _number.layer.borderWidth = 1;
    _number.layer.cornerRadius = 3;
  
}

- (void)subtractAction:(UIButton *)sender {
    

    if (i > 1) {
        i --;
    }
    
    _numLab.text = [NSString stringWithFormat:@"%d",i];
    
    [_productDic setObject:_numLab.text forKey:@"number"];
    
    [self.buyDelegate productDetail:_productDic];
 
}

- (void)addAction:(UIButton *)sender {
    
    //对i 进行判断
    i ++;

    _numLab.text = [NSString stringWithFormat:@"%d",i];
    [_productDic setObject:_numLab.text forKey:@"number"];
    [self.buyDelegate productDetail:_productDic];

}

#pragma mark - StandDelegate
- (void)getCollectionView:(UICollectionView *)collectionView withSelectText:(NSString *)text withTitleText:(NSString *)titleText withIndex:(NSInteger)index withId:(NSString *)ids withIcon:(NSString *)icon {
    
    if (icon != nil) {
        
        NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,icon];
        [_icon sd_setImageWithURL:[NSURL URLWithString:url]];
        
        //将图片保存到字典中
        [_productDic setObject:icon forKey:@"icon"];
    }
    
    int position = (int)collectionView.tag - 1500;
    
    [_allText replaceObjectAtIndex:position withObject:text];
    [_allID replaceObjectAtIndex:position withObject:ids];
    
    NSString *staicText = [_allText componentsJoinedByString:@" "];
    //拼接priceModel需要的id
    NSString *priceID = [_allID componentsJoinedByString:@"|"];
    
    for (YYPriceModel *priceModel in _priceArr) {
        
        if ([priceID isEqualToString:priceModel.ids]) {
            
            _price.text = [NSString stringWithFormat:@"%ld",priceModel.price];
            _sale.text = [NSString stringWithFormat:@"%ld",priceModel.stock];
            
            _staic.text = [NSString stringWithFormat:@"%@",staicText];
        }
        
        NSString *buyNumber = [NSString stringWithFormat:@"%d",i];
        
        /*
            ids         产品价格id
            price       价格
            stock       库存
            buyNumber   购买数量
            staic       规格属性
         */
        [_productDic setObject:priceModel.ids forKey:@"ids"];
        [_productDic setObject:_price.text forKey:@"price"];
        [_productDic setObject:_sale.text forKey:@"stock"];
        [_productDic setObject:buyNumber forKey:@"number"];
        [_productDic setObject:_staic.text forKey:@"staic"];
     
   
    }
    
    
    [self.buyDelegate productDetail:_productDic];
    
    /*
    YYImageModel *colorModel = nil;
    YYTextModel *sizeModle = nil;
  
  
    for (int i = 0; i < _standArr.count; i ++) {
        
        YYStandardModel *standModel = _standArr[i];
        
        if ([titleText isEqualToString:standModel.name]) {
            
            if ([titleText isEqualToString:@"颜色"]) {
                
                colorText = text;
                if ([standModel.type isEqualToString:@"image"]) {
                    
                    //更换图片
                    colorModel = _colorArr[0];
                }else {
                    //更换图片
                    colorModel = _sizeArr[0];
                }
                
                NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,colorModel.image];
                [_icon sd_setImageWithURL:[NSURL URLWithString:url]];
 
            }else if ([titleText isEqualToString:@"尺码"]) {
                
                sizeText = text;
                
            }else {
                
                otherText = text;
            }
        }
    }
    
    
    //拼接ids
    //  1ff80f47e8a44df6ae0d575c7f04e3fc|20eb0cef39e24e41a1fa7b10e8a2d20f
    NSArray *textArr = [NSArray arrayWithObjects:colorText,otherText,sizeText, nil];
    NSMutableString *textMutStr = [[NSMutableString alloc] init];
    int i = 0;
    for (NSString *str in textArr) {
        
        if (str != nil) {
            
            if (i == 0) {
                
                [textMutStr appendFormat:@"%@",str] ;
                i ++;
                
            }else {
                
                [textMutStr appendFormat:@"|%@",str];
            }
            
        }
    }
    
    for (YYPriceModel *model in _priceArr) {
        
        if ([textMutStr isEqualToString:model.ids]) {
            
            NSLog(@"%@",textMutStr);
        }
    }
    */
    
    /*
    NSLog(@"titleText:%@",titleText);

    YYColorModel *colorModel = nil;

    YYSizeModel *sizeModle = nil;
    
    if ([titleText isEqual:@"颜色"]) {
        
        colorText = text;
        
        //更改图片
        colorModel = _colorArr[index];
        NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,colorModel.image];
        [_icon sd_setImageWithURL:[NSURL URLWithString:url]];
 
    }else if ([titleText isEqual:@"尺码"]) {
        
        sizeText = text;
        sizeModle = _sizeArr[index];

    }else {
        
        [otherText appendString:titleText];
    }

    NSArray *arr = [NSArray arrayWithObjects:colorText,sizeText, nil];
    
    
    NSString *str = [arr componentsJoinedByString:@"|"];
    
//    [staicText appendFormat:@"%@|%@",colorText,sizeText];

    
    for (YYPriceModel *priceModel in _priceArr) {
        
        if ([str isEqualToString:priceModel.ids]) {
            
            

            _price.text = [NSString stringWithFormat:@"%ld",priceModel.price];
            
            _sale.text = [NSString stringWithFormat:@"%ld",priceModel.stock];
            
            _staic.text = [NSString stringWithFormat:@"%@%@%ld",color.value,sizeModle.value,priceModel.stock];
            
        }
    }
    
    NSLog(@"%@",str);

    
    
    
//    [staicText appendFormat:@"%@|%@|%@ %ld",colorText,sizeText,otherText,];

   */
}



@end
