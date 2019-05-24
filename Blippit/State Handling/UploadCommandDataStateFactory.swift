//
//  UploadCommandDataStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

protocol UploadCommandDataStateFactory {
  func makeState(delegate: StateDelegate, cloudSessionId: String, data: CommandData, podSession: PodSession) -> State
}
