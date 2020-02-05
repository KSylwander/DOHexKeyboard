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

  @IBOutlet private var channelTextField: UITextField!

  @IBOutlet private var payerIdContainer: UIView!
  @IBOutlet private var payerIdTextField: UITextField!
  @IBOutlet private var payerIdLengthLabel: UILabel!
  @IBOutlet private var randomPayerIdLengthTextField: UITextField!
  @IBOutlet private var randomPayerIdButton: UIButton!
  @IBOutlet private var blippitVersion: UILabel!

  @IBOutlet private var toggleBlippitButton: UIButton!

  private lazy var locationManager = CLLocationManager()

  private var blippitFactory: BlippitFactory!
  private var blippit: Blippit!

  private var propertyStorage: PropertyStorage!

  private var isBlippitActive = false {
    didSet {
      updatePayerIdUI()
      updateToggleBlippitButton()
    }
  }

  static func instantiate(blippitFactory: BlippitFactory, propertyStorage: PropertyStorage) -> MainViewController {
    let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)

    let viewController = storyboard.instantiateInitialViewController() as! MainViewController
    viewController.blippitFactory = blippitFactory
    viewController.propertyStorage = propertyStorage

    return viewController
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    blippitVersion.text = BlippitInfo.versionName

    channelTextField.placeholder = PropertyKeys.Podz.channel.defaultValue
    let channel = propertyStorage.value(for: PropertyKeys.Podz.channel)
    if channel != PropertyKeys.Podz.channel.defaultValue {
      channelTextField.text = channel
    }
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

  private func updatePayerIdUI() {
    let isEnabled = !isBlippitActive
    channelTextField.isEnabled = isEnabled
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

    if textField == payerIdTextField {
      guard let text = textField.text, let range = Range(range, in: text) else {
        updatePayerIdLengthLabel()
        updateToggleBlippitButton()
        return true
      }

      let updatedText = text.replacingCharacters(in: range, with: string)
      updatePayerIdLengthLabel(withPayerId: updatedText)
      updateToggleBlippitButton(withPayerId: updatedText)
    }
    return true
  }

  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    if textField == payerIdTextField {
      updatePayerIdLengthLabel(withPayerId: "")
      updateToggleBlippitButton(withPayerId: "")
    }
    return true
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == channelTextField {
      if let channel = textField.text, !channel.isEmpty {
        propertyStorage.setValue(channel, for: PropertyKeys.Podz.channel)
      } else {
        /* Use default value */
        propertyStorage.removeValue(for: PropertyKeys.Podz.channel)
      }
    }
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
    case .appTerminalFound:
      setStatus("App terminal found")
      loadingIndicator.isHidden = true
    case .transferInitiated:
      vibrate(forDuration: 0.1)
      setStatus("Initiating session...")
      loadingIndicator.isHidden = false
    case .transferDone:
      setStatus("Session completed")
      loadingIndicator.isHidden = true
    case .stopped:
      isBlippitActive = false
      setStatus("Stopped")
      loadingIndicator.isHidden = true
    @unknown default:
      fatalError()
    }
  }

  func blippit(_ blippit: Blippit, didFailWithError error: Error) {
    handleError(error)

    loadingIndicator.isHidden = true
  }

  private func setStatus(_ status: String) {
    statusLabel.text = status
  }
}
