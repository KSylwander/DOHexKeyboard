//
//  SACAuthenticationManager.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

final class SACAuthenticationManager: NSObject {
  private let certificatePinning: CertificatePinning

  init(certificatePinning: CertificatePinning) {
    self.certificatePinning = certificatePinning
  }
}

extension SACAuthenticationManager: URLSessionDelegate {
  func urlSession(_ session: URLSession,
                  didReceive challenge: URLAuthenticationChallenge,
                  completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

    let (disposition, credential): (URLSession.AuthChallengeDisposition, URLCredential?) = {
      if challenge.previousFailureCount == 0
          && challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {

        /* If there are no failed attempts, and this is a server trust authentication method */
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
          return (.cancelAuthenticationChallenge, nil)
        }

        do {
          try certificatePinning.apply(to: serverTrust, domain: challenge.protectionSpace.host)
          return (.useCredential, URLCredential(trust: serverTrust))
        } catch {
          return (.cancelAuthenticationChallenge, nil)
        }
      } else {
        return (.performDefaultHandling, nil)
      }
    }()
    completionHandler(disposition, credential)
  }
}
