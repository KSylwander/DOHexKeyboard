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
  @IBOutlet private var payerIdTextField: UITextField!
  @IBOutlet private var toggleBlippitButton: UIButton!
  @IBOutlet private var cancelSessionButton: UIButton!

  private lazy var locationManager = CLLocationManager()

  private var blippitFactory: BlippitFactory!
  private var blippit: Blippit!

  private var isBlippitActive = false {
    didSet {
      updatePayerIdTextField()
      updateToggleBlippitButton()
    }
  }

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
      setupBlippitWithPayerId(payerIdTextField.text!)
    } else {
      blippit.stop()
    }
    view.endEditing(true)
  }

  private func setupBlippitWithPayerId(_ payerId: String) {
    do {
      let blippit: Blippit = try {
        if let blippit = self.blippit {
          return blippit
        } else {
          let blippit = try blippitFactory.makeBlippit(delegate: self, payerId: payerId)
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

  @IBAction private func cancelSessionButtonTapped() {
    blippit.cancelOngoingSession()
  }

  private func updateToggleBlippitButton(withPayerId payerId: String? = nil) {
    UIView.performWithoutAnimation {
      toggleBlippitButton.setTitle(!isBlippitActive ? "Start" : "Stop", for: .normal)
      toggleBlippitButton.layoutIfNeeded()
    }

    let text = payerId ?? payerIdTextField.text ?? ""
    let isEnabled = !text.isEmpty

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
    updateToggleBlippitButton(withPayerId: updatedText)

    return true
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

extension MainViewController: BlippitDelegate {
  func blippit(_ blippit: Blippit, didChangeState state: BlippitState) {
    switch state {
    case .started:
      isBlippitActive = true
      setStatus("Started")
      setErrorText("None")
    case .lookingForAppTerminals:
      setStatus("Looking for app terminals...")
      loadingIndicator.isHidden = false
      setIsCancelSessionEnabled(false)
    case .appTerminalFound:
      setStatus("App terminal found")
      loadingIndicator.isHidden = true
      setIsCancelSessionEnabled(false)
    case .sessionInitiated:
      setStatus("Initiating session...")
      loadingIndicator.isHidden = false
      setIsCancelSessionEnabled(true)
    case .sessionDone:
      setStatus("Session completed")
      loadingIndicator.isHidden = true
      setIsCancelSessionEnabled(false)
    case .stopped:
      isBlippitActive = false
      setStatus("Stopped")
      loadingIndicator.isHidden = true
      setIsCancelSessionEnabled(false)
    }
  }

  func blippit(_ blippit: Blippit, didFailWithError error: Error) {
    handleError(error)

    loadingIndicator.isHidden = true
  }

  private func updatePayerIdTextField() {
    let isEnabled = !isBlippitActive
    payerIdTextField.isEnabled = isEnabled
    payerIdTextField.alpha = isEnabled ? 1.0 : 0.7
  }

  private func setIsCancelSessionEnabled(_ isCancelSessionEnabled: Bool) {
    cancelSessionButton.isEnabled = isCancelSessionEnabled
    cancelSessionButton.alpha = isCancelSessionEnabled ? 1.0 : 0.7
  }

  private func setStatus(_ status: String) {
    statusLabel.text = status
  }
}
