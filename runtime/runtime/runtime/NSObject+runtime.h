//
//  NSObject+runtime.h
//  FrameworkDemo
//
//  Created by 秦建栋 on 2017/3/13.
//  Copyright © 2017年 秦建栋. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ModelDelegate<NSObject>
- (NSDictionary *)arrayContainModelClass;
@end
@interface NSObject (runtime)

@end
