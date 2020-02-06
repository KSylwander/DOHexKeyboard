//
//  KeyboardInfo
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import UIKit

struct KeyboardInfo {
  let animationCurve: UIView.AnimationCurve
  let animationDuration: TimeInterval

  let beginFrame: CGRect
  let endFrame: CGRect
}

extension Notification {
  var keyboardInfo: KeyboardInfo? {
    guard let userInfo = userInfo,
        let rawAnimationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
        let animationCurve = UIView.AnimationCurve(rawValue: rawAnimationCurve.intValue),
        let rawAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
        let rawBeginFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
        let rawEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {

      return nil
    }
    return KeyboardInfo(
      animationCurve: animationCurve,
      animationDuration: TimeInterval(rawAnimationDuration.doubleValue),
      beginFrame: rawBeginFrame.cgRectValue,
      endFrame: rawEndFrame.cgRectValue
    )
  }
}
