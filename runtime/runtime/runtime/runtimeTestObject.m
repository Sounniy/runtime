//
//  runtimeTestObject.m
//  FrameworkDemo
//
//  Created by 秦建栋 on 2017/3/8.
//  Copyright © 2017年 秦建栋. All rights reserved.
//

#import "runtimeTestObject.h"
#import <UIKit/UIKit.h>
@interface runtimeTestObject()
{
    NSString *_Height;
    CGFloat _Weight;

}
@property(nonatomic,strong)NSString *isSleep;
@property(nonatomic,strong)NSString *isEat;


@end
@implementation runtimeTestObject



- (void)gotoEatDinner{

    NSLog(@"去吃晚饭了");
}
- (void)seyHello{
    NSLog(@"hello world");


}
+(BOOL)isWoman:(NSInteger)number{
    if (number<2) {
        return YES;
    }
    return NO;

}
@end
