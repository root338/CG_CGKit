//
//  CGBackgroundImageView.swift
//  QuickAskCommunity
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 ym. All rights reserved.
//

import UIKit


/// 两个图像拼接的背景视图
class CGBackgroundDoubleImageView: UIView {

    let leftImageView : UIImageView
    let rightImageView : UIImageView
    
    /// leftImageView/rightImageView之间的比例 [0, 1]之间
    var dimensionScale : CGFloat {
        didSet {
            if dimensionScale != oldValue {
                
                leftImageViewWidthConstraint = leftImageView.cg_autoDimension(.width, equalView: self, scale: dimensionScale)
            }
        }
    }
    
    fileprivate weak var leftImageViewWidthConstraint : NSLayoutConstraint? {
        didSet {
            
            if oldValue != nil {
                self.removeConstraint(oldValue!)
            }
        }
    }
    
    init(frame: CGRect, dimensionScale: CGFloat) {
        
        leftImageView       = UIImageView.init()
        rightImageView      = UIImageView.init()
        
        self.dimensionScale = dimensionScale
        
        super.init(frame: frame)
        
        self.addSubview(leftImageView)
        self.addSubview(rightImageView)
        
        self.setupContentViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(dimensionScale: CGFloat, animated: Bool) {
        
        self.dimensionScale = dimensionScale
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
}

fileprivate extension CGBackgroundDoubleImageView {
    
    func setupContentViewLayout() {
        
        leftImageView.cg_autoEdgesToSuperviewEdges(with: .excludingRight, insets: .zero)
        leftImageViewWidthConstraint    = leftImageView.cg_autoDimension(.width, equalView: self, scale: dimensionScale)
        
        rightImageView.cg_autoEdgesToSuperviewEdges(with: .excludingLeft, insets: .zero)
        rightImageView.cg_autoInverseAttribute(.leading, toItem: leftImageView)
    }
}
