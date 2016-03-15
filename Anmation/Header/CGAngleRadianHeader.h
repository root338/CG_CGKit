//
//  CGAngleRadianHeader.h
//  TestCG_CGKit
//
//  Created by DY on 16/3/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGAngleRadianHeader_h
#define CGAngleRadianHeader_h

/** 角度转弧度 */
#define _CG_RadianForAngle(angle)    ((angle) / 180.0 * M_PI)

/** 弧度转角度 */
#define _CG_AngleForRadian(radian)   ((radian) * 180.0 / M_PI)

#endif /* CGAngleRadianHeader_h */
