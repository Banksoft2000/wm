//
//  YYMyData.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/8.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMyData.h"

@implementation YYMyData
//实例化db  创建产品详情表
-(FMDatabase *) inflateDB{
    
    BOOL res = NO;
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/productDetail.db"];
    NSLog(@"DBpath:%@",path);
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    /**
     *  @param AUTOINCREMENT key
     *  @param TEXT          shopId     店铺id
     *  @param TEXT          shopName   店铺名
     *  @param TEXT          shopImg    店铺logo
     *  @param TEXT          productid  产品id
     *  @param TEXT          ids        产品属性ids
     *  @param TEXT          price      价格
     *  @param TEXT          stock      库存
     *  @param TEXT          number     购买数量
     *  @param TEXT          staic      属性字符串 使用 @“ ”隔开
     *  @param TEXT          shopNo     店铺NO
     *  @param TEXT          active     活动
     *  @param TEXT          areaNO     地区编号
     *  @param TEXT          active     standardIds        属性的 id 拼接的字符串
     *  @param TEXT          areaNO     standardValues     属性对用的文字
     */
    NSString *createDetailSql = @"create table if not exists product_table(id INTEGER PRIMARY KEY AUTOINCREMENT,shopId TEXT, shopName TEXT,shopImg TEXT,productId TEXT,ids TEXT,price TEXT,stock TEXT, number TEXT,staic TEXT,icon TEXT,name TEXT,shopNo TEXT,active TEXT,areaNo TEXT,standardIds TEXT,standardValues TEXT)";
    
    //执行sql语句
    res = [db executeUpdate:createDetailSql];
    if (res == NO) {
        NSLog(@"创建失败");
    }else if(res==YES){
        NSLog(@"创建成功");
    }
    [db close];
    return db;
}

//插入
- (void)insertDataWithDic:(NSDictionary *)dic {
 
    //初始化DB
    FMDatabase *db = [self inflateDB];
    BOOL res = [db open];
    
    NSString *insertDetailSql = @"insert into product_table(shopId, shopName,shopImg,productId,ids,price,stock,number,staic,icon,name,shopNo,active,areaNo,standardIds,standardValues) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    if (res) {
        
        NSString *shopId = dic[SHOP_ID];
        NSString *shopName = dic[SHOP_NAME];
        NSString *shopImg = dic[SHOP_IMG];
        NSString *productId = dic[PRODUCT_ID];
        NSString *ids = dic[IDS];
        NSString *price = dic[PRICE];
        NSString *stock = dic[STOCK];
        NSString *number = dic[NUMBER];
        NSString *staic = dic[STAIC];
        NSString *icon = dic[ICON];
        NSString *name = dic[NAME];
        NSString *shopNo = dic[SHOPNO];
        NSString *active = dic[ACTIVE];
        NSString *areaNo = dic[AREANO_SHOP];
        NSString *standIds = dic[STAND_IDS];
        NSString *standValues = dic[STAND_VALUES];
        
        //查找数据
        FMResultSet *set = [db executeQuery:@"SELECT * FROM product_table  WHERE SHOPID=? AND PRODUCTID=? AND STAIC=?",shopId,productId,staic];

        BOOL isData = NO;
        while ([set next]) {
            
            //修改数量
            NSString *numberStr = [set stringForColumn:@"number"];
            int num = [numberStr intValue];
            
            int last = [number intValue];

            NSString *new = [NSString stringWithFormat:@"%d",num+last];
            //修改
            BOOL resultCSet = [db executeUpdate:@"UPDATE product_table SET NUMBER=? WHERE SHOPID=? AND PRODUCTID=? AND STAIC=?",new,shopId,productId,staic];
            
            if (resultCSet) {
                
                NSLog(@"修改成功");
            }else {
                
                NSLog(@"修改失败");
            }

            isData = YES;
        }

        //如果不存在就添加一个新的数据
        if (isData == NO) {
            
            [db executeUpdate:insertDetailSql,shopId,shopName,shopImg,productId,ids,price,stock,number,staic,icon,name,shopNo,active,areaNo,standIds,standValues];
    
        }
    }

    [db close];
}

//获取到数据
- (NSArray *)getData {
    
    //实例化
    FMDatabase *db = [self inflateDB];

    BOOL res = [db open];
    
    //店铺
    NSMutableArray *shopArr = [[NSMutableArray alloc] init];
    
    if (res) {
        
        //查找
        FMResultSet *set = [db executeQuery:@"SELECT * FROM product_table"];
        
        while ([set next]) {
            
            NSMutableDictionary *productDic = [[NSMutableDictionary alloc] init];
            
            productDic[IDS]         = [set stringForColumn:IDS];
            productDic[SHOP_ID]     = [set stringForColumn:SHOP_ID];
            productDic[SHOP_NAME]   = [set stringForColumn:SHOP_NAME];
            productDic[SHOP_IMG]    = [set stringForColumn:SHOP_IMG];
            productDic[PRODUCT_ID]  = [set stringForColumn:PRODUCT_ID];
            productDic[PRICE]       = [set stringForColumn:PRICE];
            productDic[STOCK]       = [set stringForColumn:STOCK];
            productDic[STAIC]       = [set stringForColumn:STAIC];
            productDic[ICON]        = [set stringForColumn:ICON];
            productDic[NUMBER]      = [set stringForColumn:NUMBER];
            productDic[NAME]        = [set stringForColumn:NAME];
            productDic[SHOPNO]      = [set stringForColumn:SHOPNO];
            productDic[ACTIVE]      = [set stringForColumn:ACTIVE];
            productDic[AREANO_SHOP] = [set stringForColumn:AREANO_SHOP];
            productDic[STAND_IDS]   = [set stringForColumn:STAND_IDS];
            productDic[STAND_VALUES]= [set stringForColumn:STAND_VALUES];
            
            //判断是否为空
            if (shopArr.count < 1) {
                
                //添加第一个元素
                NSMutableArray *shop = [[NSMutableArray alloc] init];
                
                [shop addObject:productDic];
                [shopArr addObject:shop];
                
            }else {
                
                //遍历店铺 如果店铺相同 则把商品装入同一个店铺中  否则 新建一个店铺
                for (NSMutableArray *shopIDArr in shopArr) {
                    
                    NSDictionary *shopID = shopIDArr[0];
                    
                    if ([shopID[SHOP_ID] isEqualToString:productDic[SHOP_ID]]) {
                        
                        [shopIDArr addObject:productDic];
                        
                    }else {
                        
                        NSMutableArray *shop = [[NSMutableArray alloc] init];
                        
                        [shop addObject:productDic];
                        
                        [shopArr addObject:shop];
                        
                    }
                }
                
            }
            
        }
    }
    
    [db close];

    return shopArr;
}

//修改
- (void)changeData:(YYShoppingModel *)model {
    
    //实例化
    FMDatabase *db = [self inflateDB];
    
    BOOL res = [db open];
    
    if (res) {
   
        if (![model.number isEqualToString:@"0"]) {
            
            //修改
            NSString *updateSql = [NSString stringWithFormat:@"update product_table set number='%@' where shopId='%@' and  productId='%@' and staic='%@'",model.number,model.shopId,model.productId,model.staic];
            
            [db executeUpdate:updateSql];
            
        }else {
          
            //删除
            NSString *deleteSql = [NSString stringWithFormat:@"delete from product_table where shopId='%@' and  productId='%@' and staic='%@'",model.shopId,model.productId,model.staic];
           
            [db executeUpdate:deleteSql];
            
        }
    }
    
    [db close];
    
}

@end
