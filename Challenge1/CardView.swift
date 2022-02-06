//
//  CardView.swift
//  Challenge1
//
//  Created by Anwesh M on 31/01/22.
//

import UIKit

@IBDesignable class CardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var cornerRadius : CGFloat = 2
    @IBInspectable var shadowOffsetWidth : CGFloat  = 1
    @IBInspectable var shadowOffsetHeight : CGFloat  = 1
    @IBInspectable var shadowColor = UIColor.black.cgColor
    @IBInspectable var shadowOpacity : CGFloat =  0.3
    
    //lays out subviews
    //sub classes can override this method as needed to perform more precise layout of thier subviews
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor
        layer.shadowOffset =  CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius )
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}


@IBDesignable class RoundButton: UIButton {
   // MARK: - Properties
   @IBInspectable var cornerRadius: CGFloat = 0.0 {
      didSet {
         setNeedsLayout()
      }
   }
   @IBInspectable var shadowColor: UIColor = UIColor.darkGray {
      didSet {
         setNeedsLayout()
      }
   }
   @IBInspectable var shadowOffsetWidth: CGFloat = 0.0 {
      didSet {
         setNeedsLayout()
      }
   }
   @IBInspectable var shadowOffsetHeight: CGFloat = 1.8 {
      didSet {
         setNeedsLayout()
      }
   }
   @IBInspectable var shadowOpacity: Float = 0.30 {
      didSet {
         setNeedsLayout()
      }
   }
   @IBInspectable var shadowRadius: CGFloat = 3.0 {
      didSet {
         setNeedsLayout()
      }
   }
   private var shadowLayer: CAShapeLayer = CAShapeLayer() {
      didSet {
         setNeedsLayout()
      }
   }
   override func layoutSubviews() {
      super.layoutSubviews()
      layer.cornerRadius = cornerRadius
      shadowLayer.path = UIBezierPath(roundedRect: bounds,
         cornerRadius: cornerRadius).cgPath
      shadowLayer.fillColor = backgroundColor?.cgColor
      shadowLayer.shadowColor = shadowColor.cgColor
      shadowLayer.shadowPath = shadowLayer.path
      shadowLayer.shadowOffset = CGSize(width: shadowOffsetWidth,
         height: shadowOffsetHeight)
      shadowLayer.shadowOpacity = shadowOpacity
      shadowLayer.shadowRadius = shadowRadius
      layer.insertSublayer(shadowLayer, at: 0)
   }
}
