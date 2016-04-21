//
//  YYAreaData.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYAreaData.h"

#import "YYChinaModel.h"
@implementation YYAreaData

{
    NSMutableArray *a1;
    NSMutableArray *b1;
    NSMutableArray *c1;
    NSMutableArray *d1;
 
    NSMutableArray *a2;
    
    NSMutableArray *b2;
    NSMutableArray *b3;
    
    NSMutableArray *c2;
    NSMutableArray *c3;
    NSMutableArray *c4;
    
}

-(void)startParser{
    
    a1 = [[NSMutableArray alloc] init];
    b1 = [[NSMutableArray alloc] init];
    c1 = [[NSMutableArray alloc] init];
    d1 = [[NSMutableArray alloc] init];
  
    NSString *xmlPath = [[NSBundle mainBundle]pathForResource:@"china" ofType:@"xml"];
    NSData *xmlData1  = [NSData dataWithContentsOfFile:xmlPath];
    
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:xmlData1];
    
    parser.delegate = self;
    //开始解析
    [parser parse];
    
}


- (NSMutableArray *)province {
    
    return a1[0];
    
    
}
- (NSMutableArray *)city {
    
    return b1[0];
}
- (NSMutableArray *)county {
    
    return c1[0];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{

    YYChinaModel *model = [[YYChinaModel alloc] init];
    
    model.code = attributeDict[@"code"];
    model.name = attributeDict[@"name"];

    if ([elementName isEqualToString:@"country"]) {

        //省份-  a1:中国  a2：省份
        a2 = [[NSMutableArray alloc] init];
        [a1 addObject:a2];
        
        //city-  b1:中国 b2：省份 b3：city
        b2 = [[NSMutableArray alloc] init];
        [b1 addObject:b2];
        
        //county c1：中国 c2：省份 c3：city c4:county
        c2 = [[NSMutableArray alloc] init];
        
        [c1 addObject:c2];
        
        
    }else if ([elementName isEqualToString:@"province"]) {

        [a2 addObject:model];
        
        
        b3 = [[NSMutableArray alloc] init];
        [b2 addObject:b3];
        
        c3 = [[NSMutableArray alloc] init];
        [c2 addObject:c3];
        
        
    } if ([elementName isEqualToString:@"city"]) {
        
        [b3 addObject:model];
        
        c4 = [[NSMutableArray alloc] init];
        [c3 addObject:c4];
        
    } if ([elementName isEqualToString:@"county"]) {
        
        [c4 addObject:model];
        
    }
  
}


@end
