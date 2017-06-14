//
//  CGSquareProgressView.swift
//  QuickAskCommunity
//
//  Created by DY on 2017/6/9.
//  Copyright © 2017年 ym. All rights reserved.
//

import UIKit

class CGSquareProgressView: UIView {
    
    /// 方形进度条的加载方式
    ///
    /// - horizontalLeftToRight: 水平 从左边到右边
    /// - horizontalRightToLeft: 水平 从右边到左边
    /// - verticalTopToBottom: 垂直 从上到下
    /// - verticalBottomToTop: 垂直 从下到上
    enum CGProgressStyle : Int {
        
        case horizontalLeftToRight
        case horizontalRightToLeft
        case verticalTopToBottom
        case verticalBottomToTop
    }
    
    /// 方形进度条的运行类型
    ///
    /// - show: 逐渐显示
    /// - hide: 逐渐消失
    enum CGProgressAnimatedStyle : Int {
        case show
        case hide
    }
    
    /** 加载的进度 [0, 1] */
    var progressValue : CGFloat = 0.0 {
        didSet {
            self.setupProgressLayer(progressValue: progressValue)
        }
    }
    
    var progressAnimatedStyle = CGProgressAnimatedStyle.show {
        didSet {
            if progressAnimatedStyle != oldValue && progressLayer != nil {
                self.setupProgressLayer(progressValue: progressValue)
            }
        }
    }
    
    /** 加载的进度方式 */
    var progressStyle = CGProgressStyle.horizontalLeftToRight {
        didSet {
            
            if progressStyle != oldValue && progressLayer != nil {
                
                let lineWidth = self.getProgressViewLineWidth()
                if lineWidth != progressLayer!.lineWidth {
                    progressLayer!.lineWidth = self.getProgressViewLineWidth()
                }
                
                progressLayer!.path = self.createProgressPath()
            }
        }
    }
    
    /** 进度条颜色，默认，白色 */
    var progressTintColor = UIColor.white {
        didSet {
            progressLayer?.strokeColor = progressTintColor.cgColor
        }
    }
    
    /// 进度条加载完成后是否移除
    var progressDidFinishIsRemoveFromSuperview = false {
        didSet {
            if progressDidFinishIsRemoveFromSuperview == true && progressDidFinishIsRemoveFromSuperview != oldValue {
                if progressValue >= 1.0 && self.superview != nil {
                    self.removeFromSuperview()
                }
            }
        }
    }
    
    var progressDidFinishIsRemoveLayerFromSuperlayer = false {
        didSet {
            if progressDidFinishIsRemoveLayerFromSuperlayer == true && progressDidFinishIsRemoveLayerFromSuperlayer != oldValue {
                if progressValue > 1.0 && progressLayer?.superlayer != nil {
                    self.removeProgressLayer()
                }
            }
        }
    }
    
    
    override var frame: CGRect {
        didSet {
            
            let isUpdatePath = frame.size.equalTo(oldValue.size) == false
            
            if progressLayer != nil {
                if isUpdatePath {
                    progressLayer!.path = self.createProgressPath()
                }
                
                let lineWidth = self.getProgressViewLineWidth()
                if lineWidth != progressLayer!.lineWidth {
                    progressLayer!.lineWidth = self.getProgressViewLineWidth()
                }
            }
        }
    }
    
    fileprivate var progressLayer : CAShapeLayer?
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow != nil && progressValue < 1.0 && progressAnimatedStyle == .hide {
            // 在添加到窗口时，进度条的动画为隐藏且进度小于1.0时，
            if progressLayer?.superlayer == nil {
                self.setupProgressLayer(progressValue: progressValue)
            }
        }
    }
    
    private func setupProgressLayer(progressValue: CGFloat) {
        
        if progressValue < 1.0 && progressValue >= 0.0 {
            
            let layer = self.getProgressLayer()
            if layer.superlayer == nil {
                self.layer.addSublayer(layer)
            }
            
            let strokeEnd   : CGFloat
            switch self.progressAnimatedStyle {
            case .show:
                strokeEnd   = progressValue
            case .hide:
                strokeEnd   = 1.0 - progressValue
            }
            
            layer.strokeEnd = strokeEnd
        }else {
            
            if self.progressDidFinishIsRemoveLayerFromSuperlayer {
                self.removeProgressLayer()
            }
            if self.progressDidFinishIsRemoveFromSuperview {
                self.removeFromSuperview()
            }
        }
    }
    
    private func getProgressLayer() -> CAShapeLayer {
        if progressLayer == nil {
            progressLayer   = self.createProgressLayer()
            progressLayer?.strokeStart  = 0.0
        }
        return progressLayer!
    }
    
    private func removeProgressLayer() {
        if progressLayer?.superlayer != nil {
            progressLayer?.removeFromSuperlayer()
        }
        progressLayer = nil
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        progressLayer?.frame    = self.bounds
    }
}

fileprivate extension CGSquareProgressView {
    
    func createProgressLayer() -> CAShapeLayer {
        
        let shareLayer = CAShapeLayer.init()
        
        shareLayer.frame            = self.bounds
        shareLayer.contentsScale    = UIScreen.main.scale
        
        shareLayer.strokeColor      = self.progressTintColor.cgColor
        shareLayer.lineWidth        = self.getProgressViewLineWidth()
        shareLayer.path             = self.createProgressPath()
        return shareLayer
    }
    
    func createProgressPath() -> CGPath {
        
        let startPointX : CGFloat
        let startPointY : CGFloat
        let endPointX   : CGFloat
        let endPointY   : CGFloat
        
        switch self.progressStyle {
        case .horizontalLeftToRight:
            startPointX = 0
            startPointY = self.height / 2.0
            endPointX   = self.width
            endPointY   = startPointY
        case .horizontalRightToLeft:
            startPointX = self.width
            startPointY = self.height / 2.0
            endPointX   = 0
            endPointY   = startPointY
        case .verticalTopToBottom:
            startPointX = self.width / 2.0
            startPointY = 0
            endPointX   = startPointX
            endPointY   = self.height
        case .verticalBottomToTop:
            startPointX = self.width / 2.0
            startPointY = self.height
            endPointX   = startPointX
            endPointY   = 0
        }
        
        let bezierPath = UIBezierPath.init()
        bezierPath.move(to: .init(x: startPointX, y: startPointY))
        bezierPath.addLine(to: .init(x: endPointX, y: endPointY))
        return bezierPath.cgPath
    }
    
    func getProgressViewLineWidth() -> CGFloat {
        
        let lineWidth : CGFloat
        switch self.progressStyle {
        case .horizontalLeftToRight:
            fallthrough
        case .horizontalRightToLeft:
            lineWidth   = self.height
        case .verticalBottomToTop:
            fallthrough
        case .verticalTopToBottom:
            lineWidth   = self.width
        }
        
        return lineWidth
    }
}
