//
//  MainViewController.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Blippit
import CoreLocation
import Podz
import UIKit

final class MainViewController: UIViewController {
  @IBOutlet private var statusLabel: UILabel!
  @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet private var errorLabel: UILabel!
  @IBOutlet private var userIdTextField: UITextField!
  @IBOutlet private var toggleBlippitButton: UIButton!

  private lazy var locationManager = CLLocationManager()

  private var blippitFactory: BlippitFactory!
  private var blippit: Blippit!
  private var isBlippitActive = false

  static func instantiate(blippitFactory: BlippitFactory) -> MainViewController {
    let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)

    let viewController = storyboard.instantiateInitialViewController() as! MainViewController
    viewController.blippitFactory = blippitFactory

    return viewController
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    blippit?.stop()
  }

  @IBAction private func toggleBlippitButtonTapped() {
    if !isBlippitActive {
      setupBlippitWithUserId(userIdTextField.text!)
    } else {
      blippit.stop()
    }
    view.endEditing(true)
  }

  private func setupBlippitWithUserId(_ userId: String) {
    do {
      let blippit: Blippit = try {
        if let blippit = self.blippit {
          return blippit
        } else {
          let blippit = try blippitFactory.makeBlippit(delegate: self, userId: userId)
          self.blippit = blippit
          return blippit
        }
      }()
      blippit.start()
    } catch {
      handleError(error)
    }
  }

  private func handleError(_ error: Error) {
    setErrorText(error.name)

    if case BlippitError.invalidPodzStatus(PodzStatus.pending(let error)) = error {
      if error == .locationDenied {
        showLocationServicesErrorAlert(withTitle: "Location services is disabled, or access to it has been denied")
      } else if error == .locationNotDetermined {
        locationManager.requestAlwaysAuthorization()
      } else if error == .locationRestricted {
        showLocationServicesErrorAlert(withTitle: "Access to location services has been restricted")
      }
    }
  }

  private func showLocationServicesErrorAlert(withTitle title: String) {
    let alertController = UIAlertController(
      title: title,
      message: "Please enable the setting via the Settings app.",
      preferredStyle: .alert
    )
    alertController.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
    alertController.addAction(.init(title: "Settings", style: .default) { _ in
      let openSettingsURL = URL(string: UIApplication.openSettingsURLString)!
      UIApplication.shared.open(openSettingsURL, options: [:], completionHandler: nil)
    })
    present(alertController, animated: true, completion: nil)
  }

  private func setErrorText(_ errorText: String) {
    errorLabel.text = errorText
  }

  private func updateToggleBlippitButton(withUserId userId: String? = nil, isStarting: Bool = false) {
    UIView.performWithoutAnimation {
      toggleBlippitButton.setTitle(!isBlippitActive ? "Start" : "Stop", for: .normal)
      toggleBlippitButton.layoutIfNeeded()
    }

    let text = userId ?? userIdTextField.text ?? ""
    let isEnabled = !text.isEmpty && !isStarting

    toggleBlippitButton.isEnabled = isEnabled
    toggleBlippitButton.alpha = isEnabled ? 1.0 : 0.7
  }
}

extension MainViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {

    guard let text = textField.text, let range = Range(range, in: text) else {
      updateToggleBlippitButton()
      return true
    }

    let updatedText = text.replacingCharacters(in: range, with: string)
    updateToggleBlippitButton(withUserId: updatedText)

    return true
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

extension MainViewController: BlippitDelegate {
  func blippitWillStart(_ blippit: Blippit) {
    setStatus("Starting...")
    loadingIndicator.isHidden = false

    updateToggleBlippitButton(isStarting: true)
  }

  func blippitDidStart(_ blippit: Blippit) {
    setStatus("Started")
    loadingIndicator.isHidden = true

    setErrorText("None")

    isBlippitActive = true
    updateUserIdTextField()
    updateToggleBlippitButton()
  }

  func blippitDidStop(_ blippit: Blippit) {
    setStatus("Stopped")

    isBlippitActive = false
    updateUserIdTextField()
    updateToggleBlippitButton()
  }

  func blippit(_ blippit: Blippit, didFailWithError error: Error) {
    handleError(error)

    loadingIndicator.isHidden = true
  }

  private func updateUserIdTextField() {
    let isEnabled = !isBlippitActive
    userIdTextField.isEnabled = isEnabled
    userIdTextField.alpha = isEnabled ? 1.0 : 0.7
  }

  private func setStatus(_ status: String) {
    statusLabel.text = status
  }
}
