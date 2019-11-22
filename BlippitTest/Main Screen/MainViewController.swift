//
//  MainViewController.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import BlippitKit
import CoreLocation
import PodzKit
import UIKit

final class MainViewController: UIViewController {
  @IBOutlet private var statusLabel: UILabel!
  @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet private var errorLabel: UILabel!

  @IBOutlet private var payerIdContainer: UIView!
  @IBOutlet private var payerIdTextField: UITextField!
  @IBOutlet private var payerIdLengthLabel: UILabel!
  @IBOutlet private var randomPayerIdLengthTextField: UITextField!
  @IBOutlet private var randomPayerIdButton: UIButton!

  @IBOutlet private var toggleBlippitButton: UIButton!
  @IBOutlet private var cancelSessionButton: UIButton!

  private lazy var locationManager = CLLocationManager()

  private var blippitFactory: BlippitFactory!
  private var blippit: Blippit!

  private var isBlippitActive = false {
    didSet {
      updatePayerIdUI()
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

  @IBAction private func randomPayerIdButtonTapped() {
    view.endEditing(true)
    do {
      let id: TransferId
      if let length = randomPayerIdLengthTextField.text.flatMap(Int.init) {
        id = try TransferId.random(withLength: length)
      } else {
        id = try TransferId.random()
      }
      payerIdTextField.text = id.idString
      updatePayerIdLengthLabel()
      updateToggleBlippitButton()
    } catch {
      handleError(error)
    }
  }

  @IBAction private func toggleBlippitButtonTapped() {
    view.endEditing(true)
    if !isBlippitActive {
      setupBlippitWithPayerId(payerIdTextField.text!)
    } else {
      blippit.stop()
    }
    view.endEditing(true)
  }

  private func setupBlippitWithPayerId(_ payerId: String) {
    do {
      blippit = try blippitFactory.makeBlippit(delegate: self, payerId: payerId)
      blippit.start()
    } catch {
      handleError(error)
    }
  }

  private func handleError(_ error: Error) {
    setErrorText(error.name)
  }

  private func setErrorText(_ errorText: String) {
    errorLabel.text = errorText
  }

  @IBAction private func cancelSessionButtonTapped() {
    blippit.cancelOngoingSession()
  }

  private func updatePayerIdUI() {
    let isEnabled = !isBlippitActive
    payerIdTextField.isEnabled = isEnabled
    randomPayerIdLengthTextField.isEnabled = isEnabled
    randomPayerIdButton.isEnabled = isEnabled
    payerIdContainer.alpha = isEnabled ? 1.0 : 0.7
  }

  private func updatePayerIdLengthLabel(withPayerId payerId: String? = nil) {
    payerIdLengthLabel.text = "\((payerId ?? payerIdTextField.text ?? "").count)"
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
      updatePayerIdLengthLabel()
      updateToggleBlippitButton()
      return true
    }

    let updatedText = text.replacingCharacters(in: range, with: string)
    updatePayerIdLengthLabel(withPayerId: updatedText)
    updateToggleBlippitButton(withPayerId: updatedText)

    return true
  }

  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    updatePayerIdLengthLabel(withPayerId: "")
    updateToggleBlippitButton(withPayerId: "")
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

  private func setIsCancelSessionEnabled(_ isCancelSessionEnabled: Bool) {
    cancelSessionButton.isEnabled = isCancelSessionEnabled
    cancelSessionButton.alpha = isCancelSessionEnabled ? 1.0 : 0.7
  }

  private func setStatus(_ status: String) {
    statusLabel.text = status
  }
}
