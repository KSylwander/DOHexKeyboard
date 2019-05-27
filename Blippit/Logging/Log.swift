//
//  Log.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-27.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation
import os.log

/* Used to get a reference to the `Bundle` where the artifacts in this file reside. This is the SDK framework bundle in
 * our case.
 */
private final class Runtime {
  static let bundleIdentifier = Bundle(for: Runtime.self).bundleIdentifier!
}

/**
 Namespace used for logging through the [Unified Logging System](https://developer.apple.com/documentation/os/logging).

 **Best practices:**

 - Use `os_log` to log critical details to help debug issues.
 - Use `os_log_info` for additional info that will be captured during error or fault.
 - Use `os_log_debug` for high-volume debugging during development.
 - Use `os_log_error` to cause additional information capture from app.
 */
enum Log {
  /**
   Controls visibility of logging messages.
   */
  enum Message {
    /**
     A message that can be used to log where execution is currently at.
     */
    case executionContext

    /**
     A message sent as public will show up in logs on device. Do not use for sensitive data.
     */
    case `public`(String)

    /**
     A message sent as private will not show up in logs on device. Use this for sensitive data. Will still be seen in
     debug logs.
     */
    case `private`(String)
  }

  /* Contains a log object for each category. Use `logObject(forCategory:)` to retrieve one. */
  private static var logObjects = [String: OSLog]()

  private static let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss'.'SSSZ"
    return dateFormatter
  }()

  static func info(_ message: Message,
                   timestamp: Date = Date(),
                   file: String = #file,
                   function: String = #function,
                   line: Int = #line) {

    log(.info, message, timestamp: timestamp, file: file, function: function, line: line)
  }

  static func debug(_ message: Message,
                    timestamp: Date = Date(),
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {

    log(.debug, message, timestamp: timestamp, file: file, function: function, line: line)
  }

  static func error(_ message: Message,
                    timestamp: Date = Date(),
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {

    log(.error, message, timestamp: timestamp, file: file, function: function, line: line)
  }

  private static func log(_ type: OSLogType, _ message: Message,
                          timestamp: Date = Date(),
                          file: String,
                          function: String,
                          line: Int) {

    let filename = file.filename
    let logObject = self.logObject(forCategory: filename)
    let typeString = String(osLogType: type)

    switch message {
    case .executionContext:
      os_log(
        "%{public}@ %{public}@:%{public}d",
        log: logObject,
        type: type,
        typeString, function, line
      )
    case .public(let message):
      os_log(
        "%{public}@ %{public}@:%{public}d -> %{public}@",
        log: logObject,
        type: type,
        typeString, function, line, message
      )
    case .private(let message):
      os_log(
        "%{public}@ %{public}@:%{public}d -> %@",
        log: logObject,
        type: type,
        typeString, function, line, message
      )
    }
  }

  private static func logObject(forCategory category: String) -> OSLog {
    if let logObject = logObjects[category] {
      return logObject
    }

    let logObject = OSLog(subsystem: Runtime.bundleIdentifier, category: category)
    logObjects[category] = logObject
    return logObject
  }
}

private extension String {
  var filename: String {
    return (self as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
  }
}

private extension String {
  init(osLogType: OSLogType) {
    switch osLogType {
    case .debug:
      self = "DEBUG"
    case .info:
      self = "INFO"
    case .error:
      self = "ERROR"
    case .fault:
      self = "FAULT"
    default:
      fatalError("Unsupported osLogType: \(osLogType)")
    }
  }
}
