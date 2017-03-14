//
//  runtimeTestObject.h
//  FrameworkDemo
//
//  Created by 秦建栋 on 2017/3/8.
//  Copyright © 2017年 秦建栋. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol runtimeTestObjectDelegate<NSObject>
- (void)helpWishClothes;
- (void)helpDoHomeWork;
@end

@interface runtimeTestObject : NSObject<runtimeTestObjectDelegate>
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *age;
@property (nonatomic,strong)NSString *sex;

- (void)gotoEatDinner;
- (void)seyHello;
+ (BOOL)isWoman:(NSInteger)number;
@end
