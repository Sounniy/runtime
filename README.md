# runtime
 //判断类中是否包含某个方法的实现
  BOOL class_respondsToSelector(Class cls, SEL sel)
  //获取类中的方法列表
  Method *class_copyMethodList(Class cls, unsigned int *outCount) 
  //为类添加新的方法,如果方法该方法已存在则返回NO
  BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
  //替换类中已有方法的实现,如果该方法不存在添加该方法
  IMP class_replaceMethod(Class cls, SEL name, IMP imp, const char *types) 
  //获取类中的某个实例方法(减号方法)
  Method class_getInstanceMethod(Class cls, SEL name)
  //获取类中的某个类方法(加号方法)
  Method class_getClassMethod(Class cls, SEL name)
  //获取类中的方法实现
  IMP class_getMethodImplementation(Class cls, SEL name)
  //获取类中的方法的实现,该方法的返回值类型为struct
  IMP class_getMethodImplementation_stret(Class cls, SEL name) 

  //获取Method中的SEL
  SEL method_getName(Method m) 
  //获取Method中的IMP
  IMP method_getImplementation(Method m)
  //获取方法的Type字符串(包含参数类型和返回值类型)
  const char *method_getTypeEncoding(Method m) 
  //获取参数个数
  unsigned int method_getNumberOfArguments(Method m)
  //获取返回值类型字符串
  char *method_copyReturnType(Method m)
  //获取方法中第n个参数的Type
  char *method_copyArgumentType(Method m, unsigned int index)
  //获取Method的描述
  struct objc_method_description *method_getDescription(Method m)
  //设置Method的IMP
  IMP method_setImplementation(Method m, IMP imp) 
  //替换Method
  void method_exchangeImplementations(Method m1, Method m2)

  //获取SEL的名称
  const char *sel_getName(SEL sel)
  //注册一个SEL
  SEL sel_registerName(const char *str)
  //判断两个SEL对象是否相同
  BOOL sel_isEqual(SEL lhs, SEL rhs) 
SEL 和 IMP

SEL:类成员方法的指针,但不同于C语言中的函数指针,函数指针直接保存了方法的地址,但SEL只是方法编号。

IMP:一个函数指针,保存了方法的地址

Method 对上述两者的一个包装结构.

IMP和SEL关系

每个继承与NSObject的类都能自动获得runtime的支持,在这样的一个类中,有一个isa指针,指向该类定义的数据结构体,这个结构体是由编译器编译时为类(需继承于NSObject)创建的,在这个结构体中有包括了指向其父类类定义的指针以及Dispatch table. Dispatch table是一张SEL和IMP的对应(http://blog.csdn.net/fengsh998/article/details/8614486)
也就是说方法编号SEL最后还是要通过Dispatch table表找到对应的IMP,IMP就是一个函数指针,然后执行这个方法

1:有什么办法可以知道方法编号
 
@selector()就是取方法编号。

SEL methodID = @selector(function1);

2:编号获取后执行对应方法呢

[self performSelector: methodID withObject:nil];

3:通过编号获取方法

NSString *methodName   = NSStringFormSelector(MethordID)

4:IMP 获得和使用

IMP methodPoint = [self methodForSelector:methodID];
methodPoint();

5:为什么不直接获得函数指针,而要从SEL这个编号走一圈再回到函数指针呢

有了SEL这个中间过程,我们可以对一个编号和什么方法映射做些操作,也就是说我们可以一个SEL指向不同的函数指针,这样就可以只用一个方法名在不同时候执行不同的函数体.另外可以将SEL作为参数传递给不同的类执行.也就是说我们某些业务我们只知道方法名但需要根绝不同的情况让不同类执行的时候,SEL可以帮助我们.

class_getInstanceMethod     得到类的实例方法
class_getClassMethod          得到类的类方法

BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types) 
- (void)eatFunction:(NSString*)foodName{
- 
- 
- }
cls: 被添加方法的类
name:需添加的方法名  @selector(eatFunction:)
imp:实现这个方法的函数,即这个方法实现的指针;添加一个新方法时:就是是这个新方法的实现;要在系统方法修改的是时候就是执行原方法的函数地址method_getImplementation(class_getClassMethod([self class], @selector(eatFunction:)))
type:定义添加的该函数返回值类型和参数类型的字符串 method_getTypeEnciding(class_getClassMethod([self class], @selector(eatFunction:)))
void eatfunction(id self, SEL _cmd,NSString *foodName){


}
class_addMethod([EmptyClass class], @selector(say:), (IMP)say, "i@:@");
i 表示返回值类型为int,v表示是void
@:参数id(self)
: :SEL(_cmd)
@:id(str)  
Ivar 实例变量 没有set get方法.定义对象的实例变量，包括类型和名字。
property 属性  声明属性 以快速方便的为实例变量创建存取器，并允许我们通过点语法使用存取器 实质上是实例变量,

