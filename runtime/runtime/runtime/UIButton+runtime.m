//
//  UIButton+runtime.m
//  FrameworkDemo
//
//  Created by 秦建栋 on 2017/3/10.
//  Copyright © 2017年 秦建栋. All rights reserved.
//

#import "UIButton+runtime.h"


@implementation UIButton (runtime)

SEL oriSEL1;
Method oriMethod1;
SEL newSEL1;
Method newMethod1;

+(void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = [self class];
        SEL oriSEL =@selector(sendAction:to:forEvent:);
        oriSEL1 = oriSEL;
        Method oriMethod = class_getInstanceMethod([self class], oriSEL);
        oriMethod1 = oriMethod;
        SEL newSEL = @selector(mySendAction:to:forEvent:);
        newSEL1 = newSEL;
        Method newMethod = class_getInstanceMethod([self class], newSEL);
        newMethod1 = newMethod;
       BOOL isAdd = class_addMethod(selfClass, oriSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        //用来检查有没有在子类重写过这个方法如果发现方法已经存在了,会返回失败,也可以用来做检查用,我们这里是为了避免重写系统方法的情况;如果方法没有存在则先尝试添加被替换的方法的实现.如果你在子类里重写了方法,系统会优先实现子类的实现,你替换的是父类的实现,就会无效
       /*
        1.若返回成功:则说明被替换方法没有存在,也就是被替换的方法没有实现,我们需要先把这个方法实现,再执行我们想要的效果,用我们自定义的方法去替换被替换的方法.这里使用到时是class_replacMethod这个方法,class_replaceMethod本身会尝试调用clas_addMethod和method_setImplementation
        2.如果失败了:则说明被替换的方法已经被重写,所以,直接将两个方法的实现交换
        */
        if (isAdd) {
            class_replaceMethod(selfClass, newSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else{
            method_exchangeImplementations(oriMethod, newMethod);
//            method_setImplementation(<#Method m#>, <#IMP imp#>)直接设置方法的实现
        }
        
    });



}
-(void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [self mySendAction:action to:target forEvent:event];
    NSLog(@"添加方法了");



}
//重写这个方法只是用来便于理解为什么要加isAdd判断
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [super sendAction:action to:target forEvent:event];

}
@end
