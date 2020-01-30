BlippitKit for iOS
======================================

## Introduction

BlippitKit provides functionality that supports sending a payload (e.g. phone number) over a Blippit app terminal.
For example, this allows payments where the payment service integration is provided by the cash register itself.

## System Requirements

* Minimum iOS version: 10.0
* Minimum Swift version: 5.1
* Minimum PodzKit version: 0.13.0

## Getting Started

### Including BlippitKit in your project

To use BlippitKit in your project, you need to embed its framework file:

1. Navigate to the **General** tab in your app target configuration.
2. Press the `+` button in the **Frameworks and Libraries** section.
3. Select and add the `BlippitKit.xcframework` file.
4. Make sure the framework is marked as **Embed & Sign**.
5. In the same target configuration, navigate to the **Info** tab.
6. Add the [`NSBluetoothAlwaysUsageDescription`](https://developer.apple.com/documentation/bundleresources/information_property_list/nsbluetoothperipheralusagedescription) property list key, and mention that Bluetooth is used for blips.
7. If your deployment target is **earlier than iOS 13**, add the [`NSBluetoothPeripheralUsageDescription`](https://developer.apple.com/documentation/bundleresources/information_property_list/nsbluetoothalwaysusagedescription) property list key as well, and use the same description as above.

BlippitKit uses PodzKit to communicate with the app terminal. It is therefore required that you also add PodzKit to your project. Do this in the same manner as with `BlippitKit.xcframework`.

### Using BlippitKit

To use BlippitKit, you need to first create an instance of the `Blippit` object:

```swift
import BlippitKit

// ...

let blippit = try BlippitSetup.setup(
    delegate: delegate,
    onBlipPayload: Payload(containing: "0701234567") 
)

// ...
```

When creating the instance, you pass in a configuration which specifies the interaction mode.

You also give it a delegate that conforms to the `BlippitDelegate` protocol to receive state change events and errors that may occur during a transfer:

```swift
extension MyController: BlippitDelegate {
    func blippit(_ blippit: Blippit, didChangeState state: BlippitState) {
        // ...
    }

    func blippit(_ blippit: Blippit, didFailWithError error: Error) {
        // ...
    }
}
```

Then start the kit:

```swift
blippit.start()
```

This will ask BlippitKit to start looking for app terminals and transfer payload on blip.

When no longer used, you need to stop it:

```swift
blippit.stop()
```

## Known Limitations

### Blips on multiple devices

Blips on multiple devices are possible in following situations:

* When one mobile device covers the light sensor while doing a normal blip. This can trigger blip on additional devices if they are too close to the app terminal and have the app up and running. Since only one device is allowed to be connected to the app terminal at any time, it is not well defined which of the active devices will connect.
* When the app terminal is in a low-light environment, or when covered by an object (for instance a hand), it will trigger the same behaviour.
There is no immediate workaround for this behaviour. It will be properly addressed in future releases.

## Support

In case you have any questions or concerns regarding BlippitKit, please contact: info@crunchfish.com
