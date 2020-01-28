//
//  DefaultEstablishCloudSessionUseCase.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct DefaultEstablishCloudSessionUseCase {
  let appId: UUID

  let requestBuilder: URLRequestBuilder
  let encoder: Encoder
  let decoder: Decoder
  let uploadDataUseCase: UploadDataUseCase
}

extension DefaultEstablishCloudSessionUseCase: EstablishCloudSessionUseCase {
  func establishCloudSession(pid: UInt32, serviceInfo: ServiceInfo, completion: @escaping Completion) -> Cancellable? {
    do {
      let request = requestBuilder.build()

      let requestDto = EstablishCloudSessionRequestDto(pid: pid, appId: appId, serviceInfo: serviceInfo)
      let data = try encoder.encode(requestDto)

      return uploadDataUseCase.uploadData(with: request, from: data) { response, result in
        let result = result.flatMap { data in
          return Result(catching: { try self.decoder.decode(EstablishCloudSessionResponseDto.self, from: data) })
        }
        completion(response, result)
      }
    } catch {
      completion(nil, .failure(error))
      return nil
    }
  }
}
