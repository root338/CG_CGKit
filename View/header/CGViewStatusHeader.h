//
//  CGViewStatusHeader.h
//  QuickAskCommunity
//
//  Created by DY on 15/12/9.
//  Copyright © 2015年 ym. All rights reserved.
//

#ifndef CGViewStatusHeader_h
#define CGViewStatusHeader_h

/**
 *  页面编辑中，各个状态
 */
typedef NS_ENUM(NSInteger, CGViewInteractionStatus) {
    
    CGViewInteractionStatusNone,
    /**
     *  正在编辑
     */
    CGViewInteractionStatusEditing,
    /**
     *  编辑完成（不是用户结束编辑，而是编辑内容符合规定提交标准），但还没有提交
     */
    CGViewInteractionStatusDidEditAndUnsubmitted,
    /**
     *  正在提交
     */
    CGViewInteractionStatusBeingSubmit,
    /**
     *  提交完成
     */
    CGViewInteractionStatusSubmitComplete,
};

#endif /* CGViewStatusHeader_h */
