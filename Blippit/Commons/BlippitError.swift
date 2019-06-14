//
//  BlippitError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

public enum BlippitError {
  case invalidPodzStatus(
    /* 1. `PodzStatus.pending(PodzError)`: `PodzError` represents a user-resolvable error (i.e., should be handled in
     *    a user-friendly way). Each error is passed in the pending state after the previous one is resolved. Blippit
     *    will resume on its own after all errors are taken care of.
     * 2. `PodzStatus.locked`: The API key and/or app ID cannot be verified. `Blippit` has to be recreated after the
     *    error is resolved.
     */
    PodzStatus
  )
  case invalidPodSessionState(PodSessionState)
  case appTerminalDoesNotSupportTransferId

  case invalidCredentials(responseData: Data?)
  case invalidHttpStatusCode(Int, responseData: Data?)

  /* Sending of data token failed after `Constants.states.transferDataToken.maxRetries + 1` attempts. May be fixed by
   * asking the user to blip again.
   */
  case transferDataTokenFailed

  /* Sending of cloud session done token failed after `Constants.states.transferCloudSessionDoneToken.maxRetries + 1`
   * attempts. May be fixed by asking the user to blip again.
   */
  case transferCloudSessionDoneTokenFailed
}

extension BlippitError: Error {}

extension BlippitError: Equatable {}
