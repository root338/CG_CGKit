//
//  CGPrintLogHeader.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#ifndef QuickAskCommunity_CGPrintLogHeader_h
#define QuickAskCommunity_CGPrintLogHeader_h

////在preprocessor Macros设置
//#ifdef DEBUG
//
//#define CGPrintLogOpen 1
//
//#define CGPrintInfoOpen 0
//#else
//
//#define CGPrintLogOpen
//#define CGPrintInfoOpen
//
//#endif

#ifdef CGPrintLogOpen //---------if

//有条件的错误输出，只有当condition为真时输出日志
#define CGConditionLog(condition, format, ...) do {                                 \
    if (condition) {                                                                \
        fprintf(stderr, "\n<%s : %d> %s\n",                                         \
        [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
        __LINE__, __func__);                                                        \
        (NSLog)((format), ##__VA_ARGS__);                                           \
        fprintf(stderr, "-------\n\n");                                             \
    }                                                                               \
} while (0)

#define CGLog(format, ...) CGConditionLog(YES, format, ##__VA_ARGS__)

#define CGDefaultLog() CGLog(@"")


#define CGErrorConditionLog(condition, format, ...) do {    \
    if (condition) {                                        \
        fprintf(stderr, "\nERROR:");                        \
        CGLog((format), ##__VA_ARGS__);                     \
    }                                                       \
    }while(0)

#define CGErrorLog(format, ...) CGErrorConditionLog(YES, format, ##__VA_ARGS__)

#ifdef CGPrintInfoOpen  //-----------InfoOpen   if判断

#define CGInfoLog(format, ...) CGLog(format, ##__VA_ARGS__)
#define CGInfoConditionLog(condition, format, ...) CGConditionLog(condition, format, ##__VA_ARGS__)
#else                   //-------------Else     否则

#define CGInfoLog(format, ...)
#define CGInfoConditionLog(condition, format, ...)

#endif                  //-------------end      结束

//断言
#define CGDebugAssert(condition, desc, ...)     NSAssert(condition, (desc), ##__VA_ARGS__)
#define CGDebugAssert1(condition, desc, arg1)   CGDebugAssert(condition, (desc), (arg1))



#else   //-----------else

#define CGConditionLog(condition, format, ...)
#define CGLog(format, ...)

#define CGDefaultLog()

#define CGInfoConditionLog(condition, format, ...)
#define CGInfoLog(format, ...)

#define CGErrorConditionLog(condition, format, ...)
#define CGErrorLog(format, ...)

#define CGDebugAssert(condition, desc, ...)
#define CGDebugAssert1(condition, desc, arg1)



#endif  //-----------end

#endif
