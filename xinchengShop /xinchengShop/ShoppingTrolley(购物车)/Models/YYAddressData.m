//
//  YYAddressData.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYAddressData.h"

@implementation YYAddressData


//实例化db  创建地址表
-(FMDatabase *) inflateDB{
    
    BOOL res = NO;
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/adress.db"];
    NSLog(@"ADRESSPath:%@",path);
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    /**
     *  @param AUTOINCREMENT key
     *  @param TEXT          name       姓名
     *  @param TEXT          address    地址
     *  @param TEXT          phone      手机号
     *  @param TEXT          default    是否为默认地址
     *  @param TEXT          postcode   邮编
     */
    NSString *createDetailSql = @"create table if not exists adress_table(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,tel TEXT,postcode TEXT, adress TEXT,detail TEXT,defa TEXT)";
    
    //执行sql语句
    res = [db executeUpdate:createDetailSql];
    if (res == NO) {
        NSLog(@"address：创建失败");
    }else if(res==YES){
        NSLog(@"address：创建成功");
    }
    [db close];
    return db;
}

//插入
- (BOOL)insertDataWithDic:(NSDictionary *)dic {
    
    BOOL isSuccess = YES;
    //初始化DB
    FMDatabase *db = [self inflateDB];
    BOOL res = [db open];
    
    NSString *insertDetailSql = @"insert into adress_table(name,tel,postcode, adress,detail,defa) values(?,?,?,?,?,?)";
    
    if (res) {

        NSString *name = dic[NAME_ADRESS];
        NSString *adress = dic[ADRESS];
        NSString *phone = dic[PHONE];
        NSString *defaults = dic[DEFAULT_ADRESS];
        NSString *postcode = dic[POSTCODE];
        NSString *detail = dic[DETAIL_ADDRESS];
        
        
        //如果添加的数据为 默认地址的话 将其他的数据改为NO
        if ([defaults isEqualToString:@"YES"]) {
            
            //查找
            FMResultSet *set1 = [db executeQuery:@"SELECT * FROM adress_table"];
            
            while ([set1 next]) {
                
                [db executeUpdate:@"update product_table set defa=?",@"NO"];
                
            }
        }
        
        //查找数据
        FMResultSet *set = [db executeQuery:@"select * from adress_table  where name=?and tel=? and adress=? and detail=?",name,phone,adress,detail];

        while ([set next]) {
            
            //如果有的话返回no 提示框中提示已经有收货地址了
            isSuccess = NO;
            
        }
  
        //如果不存在就添加一个新的数据
        if (isSuccess == YES) {
            
            [db executeUpdate:insertDetailSql,name,phone,postcode,adress,detail,defaults];
            
        }
 
    }
    
    [db close];
    
    return isSuccess;
}

//获取到数据
- (NSArray *)getData {
    
    //实例化
    FMDatabase *db = [self inflateDB];
    
    BOOL res = [db open];
    
    //店铺
    NSMutableArray *adressArr = [[NSMutableArray alloc] init];
    
    if (res) {
        
        //查找
        FMResultSet *set = [db executeQuery:@"SELECT * FROM adress_table"];
    
        while ([set next]) {
           NSMutableDictionary *adressDic = [[NSMutableDictionary alloc] init];
            adressDic[PHONE] = [set stringForColumn:PHONE];
            adressDic[ADRESS] = [set stringForColumn:ADRESS];
            adressDic[POSTCODE] = [set stringForColumn:POSTCODE];
            adressDic[NAME_ADRESS] = [set stringForColumn:NAME_ADRESS];
            adressDic[DETAIL_ADDRESS] = [set stringForColumn:DETAIL_ADDRESS];
            adressDic[DEFAULT_ADRESS] = [set stringForColumn:DEFAULT_ADRESS];
            
            YYManaModel *model =  [[YYManaModel alloc] initWithDictionary:adressDic];
            
            
            [adressArr addObject:model];
    
        }
    }
    
    [db close];
    
    return adressArr;
}

//修改
- (void)changeData:(YYManaModel *)model oldModel:(YYManaModel *)oldModel {
    
    //初始化DB
    FMDatabase *db = [self inflateDB];
    BOOL res = [db open];

    if (res) {
     
        
        //删除
        [db executeUpdate:@"delete from adress_table where name=?and tel=? and adress=? and detail=?",oldModel.name,oldModel.tel,oldModel.adress,oldModel.detail];
        
    
        if (model) {
            
            NSMutableDictionary *adressDic = [[NSMutableDictionary alloc] init];
            
                     adressDic[PHONE] = model.tel;
                    adressDic[ADRESS] = model.adress;
                  adressDic[POSTCODE] = model.postcode;
               adressDic[NAME_ADRESS] = model.name;
            adressDic[DETAIL_ADDRESS] = model.detail;
            adressDic[DEFAULT_ADRESS] = model.defa;
            
            [self insertDataWithDic:adressDic];
            
        }
        
        /*{
            
            //查找
            FMResultSet *set = [db executeQuery:@"select * from adress_table where name=? and tel=? and adress=? and detail=?",oldModel.name,oldModel.tel,oldModel.adress,oldModel.detail];
            
            while ([set next]) {
                
                NSLog(@"找到啦");
            }
            
            //修改
            //修改
//            NSString *updateSql = [NSString stringWithFormat:@"update adress_table set name='%@' and tel='%@' and postcode='%@' and adress='%@' and detail='%@' where name='%@' and tel='%@' and postcode='%@' and adress='%@' and detail='%@'",@"000000000000",model.tel, model.postcode,model.adress,model.detail,oldModel.name,oldModel.tel,oldModel.postcode, oldModel.adress,oldModel.detail];
            
           NSString *updateSql = [NSString stringWithFormat:@"update adress_table set name='%@' where name='%@' and tel='%@' and postcode='%@' and adress='%@' and detail='%@'",model.name,oldModel.name,oldModel.tel,oldModel.postcode,oldModel.adress,oldModel.detail];
            
            NSString *tel = [NSString stringWithFormat:@"update adress_table set name='%@' where name='%@' and tel='%@' and postcode='%@' and adress='%@' and detail='%@'",model.tel,oldModel.name,oldModel.tel,oldModel.postcode,oldModel.adress,oldModel.detail];
            
            if ([db executeUpdate:updateSql] &&[db executeUpdate:tel]) {
                
                NSLog(@"成共啦");
            }

            //查找
            FMResultSet *set1 = [db executeQuery:@"select * from adress_table where name=?",model.name];
            
            while ([set1 next]) {
                
                NSLog(@"-----%@",[set1 stringForColumn:@"tel"]);
                
                NSLog(@"添加上了");
                
            }
        }
       */
    }
    
    [db close];
 
}

@end
