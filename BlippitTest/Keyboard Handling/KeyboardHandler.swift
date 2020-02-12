//
//  KeyboardHandler
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import UIKit

final class KeyboardHandler {
  private static let contentMargin = CGFloat(60.0)

  private static let notificationNames: [Notification.Name] = [
    UIResponder.keyboardDidShowNotification,
    UIResponder.keyboardWillHideNotification
  ]

  private let scrollView: UIScrollView

  private struct ScrollViewState {
    private let contentInsets: UIEdgeInsets
    private let scrollIndicatorInsets: UIEdgeInsets

    init(from scrollView: UIScrollView) {
      contentInsets = scrollView.contentInset
      scrollIndicatorInsets = scrollView.scrollIndicatorInsets
    }

    func apply(to scrollView: UIScrollView) {
      scrollView.contentInset = contentInsets
      scrollView.scrollIndicatorInsets = scrollIndicatorInsets
    }
  }
  private var previousScrollViewState: ScrollViewState?

  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
  }

  @objc private func handleNotification(_ notification: Notification) {
    switch notification.name {
    case UIResponder.keyboardDidShowNotification:
      handleKeyboardDidShow(notification)
    case UIResponder.keyboardWillHideNotification:
      handleKeyboardWillHide(notification)
    default:
      /* Do nothing */
      break
    }
  }

  private func handleKeyboardDidShow(_ notification: Notification) {
    guard let keyboardInfo = notification.keyboardInfo, let window = scrollView.window else {
      return
    }

    /* Calculate actual overlap of keyboard and scroll view; i.e., don't make any assumptions on
     * where the scroll view is placed; fixes problems on iPhone X
     */
    let keyboardFrame = window.convert(keyboardInfo.endFrame, to: scrollView.superview)
    let overlapHeight = (scrollView.frame.height - keyboardFrame.minY) + KeyboardHandler.contentMargin

    if previousScrollViewState == nil {
      /* Record the first/pristine scroll view state only, so that it may get reverted when the
       * keyboard is hidden
       */
      previousScrollViewState = ScrollViewState(from: scrollView)
    }
    let contentInsets = scrollView.contentInset

    if overlapHeight != contentInsets.bottom {
      var contentInset = contentInsets
      contentInset.bottom = overlapHeight
      scrollView.contentInset = contentInset

      var scrollIndicatorInsets = contentInsets
      scrollIndicatorInsets.bottom = overlapHeight - KeyboardHandler.contentMargin
      scrollView.scrollIndicatorInsets = scrollIndicatorInsets
    }
  }

  private func handleKeyboardWillHide(_ notification: Notification) {
    guard let previousScrollViewState = previousScrollViewState else {
      return
    }
    previousScrollViewState.apply(to: scrollView)
    self.previousScrollViewState = nil
  }
}

extension KeyboardHandler: KeyboardHandling {
  func setup() {
    let center = NotificationCenter.default
    KeyboardHandler.notificationNames.forEach { name in
      center.addObserver(self, selector: #selector(handleNotification(_:)), name: name, object: nil)
    }
  }

  func teardown() {
    let center = NotificationCenter.default
    KeyboardHandler.notificationNames.forEach { name in
      center.removeObserver(self, name: name, object: nil)
    }
  }
}
