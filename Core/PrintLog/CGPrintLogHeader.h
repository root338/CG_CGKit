//
//  CGPrintLogHeader.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#ifndef QuickAskCommunity_CGPrintLogHeader_h
#define QuickAskCommunity_CGPrintLogHeader_h

#ifdef DEBUG

#define CGPrintLogOpen 1

#else

#define CGPrintLogOpen

#endif

#ifdef CGPrintLogOpen //---------if

#define CGLog(format, ...) do {                                                     \
        fprintf(stderr, "\n<%s : %d> %s\n",                                           \
        [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
        __LINE__, __func__);                                                        \
        (NSLog)((format), ##__VA_ARGS__);                                           \
        fprintf(stderr, "-------\n\n");                                               \
} while (0)

#define CGDefaultLog() CGLog(@"")

#define CGDebugAssert(condition, desc, ...)     NSAssert(condition, (desc), ##__VA_ARGS__)
#define CGDebugAssert1(condition, desc, arg1)   CGDebugAssert(condition, (desc), (arg1))

#else   //-----------else

#define CGLog(format, ...)
#define CGDefaultLog()

#define CGDebugAssert(condition, desc, ...)
#define CGDebugAssert1(condition, desc, arg1)

#endif  //-----------end

#endif
