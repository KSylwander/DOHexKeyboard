//
//  BlippitMode.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

public enum BlippitMode {
  case payment(blippitApiKey: UUID, blippitAppId: UUID, serviceInfo: ServiceInfo)
  case payerId(String)
}
