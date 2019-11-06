//
//  BlippitError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/**
 * Errors that may occur in the course of running a `Blippit` instance.
 *
 * Some instances of this type are just wrappers around the specific low-level failure. These instances often contain
 * the low-level error representation themselves, and/or other additional details that can help in mitigation.
 *
 * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
 * delegate implementation to the `BlippitSetup.setup(delegate:configuration:)` method.
 */
public enum BlippitError {
  /**
   * 1. `PodzStatus.pending(PodzError)`: `PodzError` represents a user-resolvable error (i.e., should be handled in
   *    a user-friendly way). Each error is passed in the pending state after the previous one is resolved. Blippit
   *    will resume on its own after all errors are taken care of.
   * 2. `PodzStatus.locked`: The API key and/or app ID cannot be verified. `Blippit` has to be recreated after the
   *    error is resolved.
   */
  case invalidPodzStatus(PodzStatus)

  /**
   * An invalid state was encountered while performing operations on a pod session. Errors of this nature are usually
   * bugs in the Blippit SDK itself. Please report this error to the Blippit SDK developers. Don't forget to attach
   * a description of the steps needed to trigger the error, and a dump of the app logs when the error occurred.
   */
  case invalidPodSessionState(PodSessionState)

  /**
   * The blipped app terminal does not support transferring of ID data. Ask the user to try a different app terminal.
   */
  case appTerminalDoesNotSupportTransferId

  /**
   * Sending of payer ID failed after several attempts. May be fixed by asking the user to blip again.
   */
  case transferPayerIdFailed
}

extension BlippitError: Error {}

extension BlippitError: Equatable {}

/* TODO: Merge to `BlippitMode` when `_BlippitMode.payment` is exposed publicly */
enum _BlippitError {
  case invalidCredentials(responseData: Data?)
  case invalidHttpStatusCode(Int, responseData: Data?)

  /**
   * Sending of session token failed after several attempts. May be fixed by asking the user to blip again.
   */
  case transferSessionTokenFailed
}

extension _BlippitError: Error {}

extension _BlippitError: Equatable {}
