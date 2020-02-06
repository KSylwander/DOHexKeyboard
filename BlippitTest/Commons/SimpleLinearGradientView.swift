////
//  SimpleLinearGradientView
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import UIKit

@IBDesignable
final class SimpleLinearGradientView: UIView {
  override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }

  @IBInspectable private var startColor: UIColor?
  @IBInspectable private var endColor: UIColor?

  @IBInspectable private var startLocation: Double = 0.0
  @IBInspectable private var endLocation: Double = 1.0

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    layoutGradient()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    layoutGradient()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layoutGradient()
  }

  private func layoutGradient() {
    guard let layer = layer as? CAGradientLayer, let startColor = startColor, let endColor = endColor else {
      return
    }
    layer.colors = [startColor.cgColor, endColor.cgColor]
    layer.locations = [startLocation as NSNumber, endLocation as NSNumber]
  }
}
