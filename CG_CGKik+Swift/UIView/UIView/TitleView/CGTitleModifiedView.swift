//
//  CGTitleModifiedView.swift
//  QuickAskCommunity
//
//  Created by PCG on 2017/6/10.
//  Copyright © 2017年 ym. All rights reserved.
//

import UIKit

class CGTitleModifiedView: CGBaseLayoutView {

    let titleLabel : UILabel
    let leftModifiedView : UIView
    let rightModifiedView : UIView
    let titleSpace : CGFloat
    
    private var didSetupConstraint = false
    
    init(leftModifiedView: UIView, rightModifiedView: UIView, titleSpace: CGFloat) {
        
        titleLabel              = UILabel.init()
        self.leftModifiedView   = leftModifiedView
        self.rightModifiedView  = rightModifiedView
        self.titleSpace         = titleSpace
        
        super.init(frame: .zero)
        
        self.addSubview(titleLabel)
        self.addSubview(leftModifiedView)
        self.addSubview(rightModifiedView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        if didSetupConstraint == false {
            
            titleLabel.cg_autoCenterToSuperview()
            titleLabel.cg_autoConstrain(toSuperviewAttribute: .top, relation: .greaterThanOrEqual)
            
            leftModifiedView.cg_autoAxis(.horizontal, toSameAxisOf: titleLabel)
            leftModifiedView.cg_autoEdge(with: leftModifiedView.superview!, optionEdge: .leftTop, insets: .zero, relation: .greaterThanOrEqual)
            
            leftModifiedView.cg_autoInverseAttribute(.trailing, toItem: titleLabel, constant: titleSpace)
            
            rightModifiedView.cg_autoEdge(with: rightModifiedView.superview!, optionEdge: .rightTop, insets: .zero, relation: .greaterThanOrEqual)
            rightModifiedView.cg_autoAxis(.horizontal, toSameAxisOf: titleLabel)
            rightModifiedView.cg_autoInverseAttribute(.leading, toItem: titleLabel, constant: titleSpace)
            
            didSetupConstraint = true
        }
        
        super.updateConstraints()
    }
}


// MARK: - 扩展初始化方法
extension CGTitleModifiedView {
    
    convenience init(lineConfig: CGTitleModifiedLineViewConfig) {
        let leftView = CGTitleModifiedView.createLineView(config: lineConfig)
        let rightView = CGTitleModifiedView.createLineView(config: lineConfig)
        
        self.init(leftModifiedView: leftView, rightModifiedView: rightView, titleSpace: lineConfig.titleSpace)
    }
    
    convenience init(lineConfigModel: CGTitleModifiedLineViewConfigModel) {
        self.init(lineConfig: lineConfigModel.config)
    }
    
    private class func createLineView(config: CGTitleModifiedLineViewConfig) -> UIView {
        
        let view = UIView.init()
        
        view.cornerRadius   = config.cornerRadius
        view.backgroundColor    = config.backgroundColor
        view.cg_autoSetupViewSize(config.lineSize)
        
        return view
    }
}
