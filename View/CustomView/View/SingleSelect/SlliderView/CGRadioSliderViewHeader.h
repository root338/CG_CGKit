//
//  CGRadioSliderViewHeader.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGRadioSliderViewHeader_h
#define CGRadioSliderViewHeader_h

/** 单选视图滑块宽度类型 */
typedef NS_ENUM(NSInteger, CGRadioSliderWidthType) {
    
    /** 等于选择单元的宽度 */
    CGRadioSliderWidthTypeEqualSelectedCellWidth,
    
    /** 等于选择单元的标题宽度 */
    CGRadioSliderWidthTypeEqualSelectedCellTitleWidth,
    
    /** 自定义 */
    CGRadioSliderWidthTypeCustom,
};

#endif /* CGRadioSliderViewHeader_h */
