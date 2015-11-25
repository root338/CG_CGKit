# CG_CGKit
系统库的扩展，自定义控件的实现

目录结构描述

    Anmation  自定义动画处理
        UINavigationViewController+PushAndPopAnmation 导航栏自定义Pop动画
        
    APPPurviewJudge 系统权限判断，现在实现相机相册的权限判断
    
    Foundation  对非视图类的扩展，或自定义非视图类
        AFNetwork+Category  对AFNetwork的再封装（项目必须包含AFNetwork库）（未实现完全）
          ConstantDefine  定义自定义类型，枚举
          HandelData  数据解析相关类
          Manager 请求的管理类
          Model 解析的对象
            DataModel 请求的返回数据对象模型
            RequestModel  请求的发送数据对象模型
              CreateCategory  快捷创建请求的发送数据对象模型
        Constant  设置常量
    
        AreaCalculate 区域计算相关扩展（主要为C函数）
    
        Dispath+Category  GCD方法扩展
    
        IOSVersion  iOS版本判断
    
        Keyboard  keyboard 管理类
    
        NSArray NSArray 扩展方法
    
        NSDate  时间转换扩展方法
    
        NSError 
    
        NSObject  现在实现：1.获取app版本号；
    
        NSPredicate
    
        NSString
    
        PrintLog  日志打印宏的定义， 需要在项目配置类的Build Setting -> Preprocessor Macros 下设置CGPrintLogOpen CGPrintInfoOpen
    
        Tools
            Category
                NStimer 计时器扩展方法
            KeyboardNotification  快捷设置键盘通知扩展
            LoadLaunchImage 加载启动图
            Notification
            OpenSystemAPP 调用系统app
            UserDefault 
        
        UI  UI 开头非视图系统类
            Category 扩展方法
        
    View
        Category
          AlertViewCategory
          AreaCalculate 计算区域（主要与UIView相关）
          CGButtonCategory
          CoreScene
            UIColor+Category  UIColor的扩展，主要加创建颜色的宏定义
          CreateView
            Auto Layout View  创建默认支持AutoLayout的UIView类或其子类
            View  创建默认不支持AutoLayout的UIView类或其子类
          Navigation
          TextCategory  输入框的扩展方法
          UICollection
          UIScrollView
          UITableView
          UITableViewDelegate
          ViewCategory
        CustomView  自定义视图
          AlertView
          Button
          Cell
          CollectionView
          Label
          RefreshView
          ScrollView
          SingleView  单选视图
          TableView
          TextFieldInputView 
          WebView
          View  其他组合视图
            CycleScrollView
        header  UIView 一些头文件声明
        Layout  NSLayoutConstraint的扩展方法，三方支持AutoLayout的库
          UIView+Masonry
          PureLayout
          CustomLayoutCategory
    ViewController
        Appearance  
          UINavigation  全局设置导航栏的外观
          BaseVC  基类控制器（现有：导航栏，表格，普通的视图控制器）
          Category
          Delegate
            CGNavigationDelegate
          DetailToolsVC 具体的特定视图控制器的实现

其他一些注意

  一些必须拥有其他三方库的文件
  
    必须包含 AFNetwork
      AFNetwork+Category 
    
    必须包含 JSONModel
      AFNetwork+Category
      
    必须包含 Masonry
      UIView+Masonry  
      CGTitleBaseView 所在目录 CG_CGKit -> View -> CustomView -> View
      
  必须移除文件
    CGQRCodeViewController  NSString+QRCodeURL.h其他项目包含文件 ^_^
