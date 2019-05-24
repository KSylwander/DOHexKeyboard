//
//  UIView+CornerRadius.swift
//  PodzPaymentDemo
//
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import UIKit

extension UIView {
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }

    set {
      layer.cornerRadius = newValue
      layer.shouldRasterize = newValue > 0.0
      layer.rasterizationScale = UIScreen.main.scale
    }
  }
}
