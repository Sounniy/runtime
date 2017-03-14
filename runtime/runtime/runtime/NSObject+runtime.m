//
//  NSObject+runtime.m
//  FrameworkDemo
//
//  Created by 秦建栋 on 2017/3/13.
//  Copyright © 2017年 秦建栋. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>
@implementation NSObject (runtime)
//字典转模型

+(instancetype)objectWithDict:(NSDictionary *)dict{

    id objec = [[self alloc]init];
    unsigned int count =0;
    //获取成员属性列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    //便利所有属性,然后根据key-value给model赋值
    
    for (unsigned int i = 0; i<count; i++) {
        //1.成员属性
        Ivar ivar = ivarList[i];
        //2.获取成员属性名称,转化成NSString
        NSString *ivarString = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //3.成员属性名转化成字典
        NSString *key = [ivarString substringFromIndex:1];
        //4.去字典中取出对应的值
        id value = dict[key];
        
        
       //1.获取成员属性类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
         //二级转换,字典中还有字典,也需要把对应的字典转成模型
        //判断value是不是字典
        if ([value isKindOfClass:[NSDictionary class]]&& ![ivarType containsString:@"NS"]) {
            
            //处理类型字符串
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            //自定义对象,并且是字典
            Class modelClass = object_getClass(ivarType);
            if (modelClass) {
                value = [modelClass objectWithDict:value];
            }
    
        }        

        
    }
    
    return objec;
}

@end
