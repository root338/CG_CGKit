//
//  CGFloatExtension.swift
//  QuickAskCommunity
//
//  Created by apple on 2019/12/9.
//  Copyright © 2019 ym. All rights reserved.
//

import Foundation

extension CGFloat {
    func cg_less(horizontalInsets: UIEdgeInsets) -> CGFloat {
        return self - horizontalInsets.cg_horizontalValue
    }
    func cg_less(verticalInsets: UIEdgeInsets) ->CGFloat {
        return self - verticalInsets.cg_verticalValue
    }
    func cg_add(horizontalInsets: UIEdgeInsets) -> CGFloat {
        return self + horizontalInsets.cg_horizontalValue
    }
    func cg_add(verticalInsets: UIEdgeInsets) ->CGFloat {
        return self + verticalInsets.cg_verticalValue
    }
    func mid(lessValue value: CGFloat = 0) -> CGFloat {
        return (self - value) / 2
    }
}
