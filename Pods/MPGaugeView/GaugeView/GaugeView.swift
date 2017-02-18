//
//  GaugeView.swift
//  MPiccinato
//
//  Created by Piccinato, Mathew on 12/26/15.
//  Copyright © 2015 Piccinato, Mathew. All rights reserved.
//

import Foundation
import UIKit
import Darwin

@IBDesignable class GaugeView: UIView {
   
    // Style
    var stops: Array<(stop: Double, color: UIColor)> = [ (0.0, UIColor.greenColor()) ] {
        didSet {
            self.fillLayer.stops = self.stops
        }
    }
    var borderColor: UIColor = UIColor.grayColor()
    var width: CGFloat = 30.0
    
    var animateUpdates: Bool = true
   
    // Data
    private var _progress: Double = 0.0
    private var _previousProgress: Double = 0.0
    var progress: Double {
        get {
            return _progress
        }
        set(value){
            _previousProgress = _progress
            _progress = value > 1 ? 1 : value < 0 ? 0 : value
        
            if self.animateUpdates {
                self.fillLayer.progress = _progress
                self.animate()
            } else {
                self.fillLayer.progress = _progress
                self.fillLayer.setNeedsDisplay()
            }
        }
    }
   
    // Layers
    private let fillLayer: GaugeLayer = GaugeLayer()
    private let borderLayer: CAShapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.whiteColor()
        
        self.initBorderLayer()
        self.initFillLayer()

        self.layer.addSublayer(self.fillLayer)
        self.layer.addSublayer(self.borderLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.initBorderLayer()
        self.initFillLayer()
    }
    
    // Parts
    func getArcCenter() -> CGPoint {
        return CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds))
    }
    
    func getRadius() -> CGFloat {
        return CGRectGetMidX(self.bounds)
    }
    
    func initFillLayer() {
        self.fillLayer.stops = self.stops
        self.fillLayer.frame = self.bounds
        self.fillLayer.progress = self.progress
        self.fillLayer.width = Double(self.width)
    }
    
    func initBorderLayer() {
        let arcCenter = self.getArcCenter()
        let radius = self.getRadius()
        
        let borderPath = UIBezierPath()
        borderPath.moveToPoint(CGPointMake(0, self.bounds.size.height))
        borderPath.addArcWithCenter(arcCenter, radius: radius, startAngle: CGFloat(M_PI), endAngle: CGFloat(-2.0 * M_PI), clockwise: true)
        borderPath.addLineToPoint(CGPointMake(self.bounds.size.width - self.width, self.bounds.size.height))
        borderPath.addArcWithCenter(arcCenter, radius: radius - self.width, startAngle: CGFloat(-2.0 * M_PI), endAngle: CGFloat(M_PI), clockwise: false)
        borderPath.addLineToPoint(CGPointMake(0, self.bounds.size.height))
        
        self.borderLayer.path = borderPath.CGPath
        self.borderLayer.position = CGPoint(x: 0, y: 0)
        
        self.borderLayer.lineWidth = 1
        self.borderLayer.fillColor = UIColor.clearColor().CGColor
        self.borderLayer.strokeColor = self.borderColor.CGColor
        self.borderLayer.fillRule = kCAFillRuleEvenOdd
    }
    
    // Animation
    func animate() {
        if self.superview == nil {
            return
        }
        
        let animation = CABasicAnimation(keyPath: "progress")
        animation.duration = 1
        animation.fromValue = self._previousProgress
        animation.toValue = self.progress
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = true
        self.fillLayer.addAnimation(animation, forKey: "progress")
    }
}

class GaugeLayer: CALayer {
    
    var progress: Double = 0.0
    var stops: Array<(stop: Double, color: UIColor)> = [ (0.0, UIColor.greenColor()) ]
    var width: Double = 10.0
    
    private var color: UIColor {
        get {
            if self.stops.count == 1 {
                return stops.first!.color
            }
        
            var c: UIColor = stops.first!.color
           
            for (value, color) in self.stops {
                if value <= self.progress {
                    c = color
                }
            }
            
            return c
        }
    }
    
    override init() {
        super.init()

        self.contentsScale = UIScreen.mainScreen().scale
        self.setNeedsDisplay()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        
        if let other = layer as? GaugeLayer {
            self.width = other.width
            self.stops = other.stops
        }
    }
    
    override class func needsDisplayForKey(key: String) -> Bool {
        if key == "progress" {
            return true
        }
        return super.needsDisplayForKey(key)
    }
    
    override func drawInContext(ctx: CGContext) {
        let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds))
        let radius = CGRectGetMidX(self.bounds)
        
        let endAngle = CGFloat((M_PI - (M_PI * self.progress)) * -1)
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(M_PI), endAngle: endAngle, clockwise: true)
        path.addLineToPoint(center)
        
        let innerPath = UIBezierPath(arcCenter: center, radius: radius - CGFloat(self.width), startAngle: CGFloat(M_PI), endAngle: endAngle, clockwise: true)
        innerPath.addLineToPoint(center)
        
        path.appendPath(innerPath)
        path.usesEvenOddFillRule = true
       
        CGContextAddPath(ctx, path.CGPath)
       
        CGContextSetFillColorWithColor(ctx, self.color.CGColor)
        CGContextEOFillPath(ctx)
    }
    
}

