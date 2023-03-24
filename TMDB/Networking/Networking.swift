//
//  Networking.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 1.03.2023.
//

import Alamofire
import UIKit

class Networking {
    static func request<T: Decodable>(router: EndpointConfiguration,
                                      thread: DispatchQoS.QoSClass? = nil,
                                      shouldShowLoading: Bool = false,
                                      lottieType: LottieType = .loading,
                                      onSuccess: @escaping (T, String?) -> Void,
                                      onFailure: @escaping (String?, NetworkError) -> Void) {
        switch thread {
        case .background:
            DispatchQueue.global(qos: .background).async {
                handleRequest(router: router,
                              shouldShowLoading: shouldShowLoading,
                              lottieType: lottieType,
                              onSuccess: onSuccess,
                              onFailure: onFailure)
            }
        default:
            handleRequest(router: router,
                          shouldShowLoading: shouldShowLoading,
                          onSuccess: onSuccess,
                          onFailure: onFailure)
        }
    }
    
    static private func handleRequest<T: Decodable>(router: EndpointConfiguration,
                                                    shouldShowLoading: Bool = false,
                                                    lottieType: LottieType = .loading,
                                                    onSuccess: @escaping (T, String?) -> Void,
                                                    onFailure: @escaping (String?, NetworkError) -> Void) {
        if shouldShowLoading {
            LoadingManager.shared.showLoading(fromVC: UIApplication.shared.topMostViewController, lottieType: lottieType) {
                callRequest(router: router,
                            shouldShowLoading: shouldShowLoading,
                            lottieType: lottieType,
                            onSuccess: onSuccess,
                            onFailure: onFailure)
            }
        }
        else {
            callRequest(router: router,
                        shouldShowLoading: shouldShowLoading,
                        onSuccess: onSuccess,
                        onFailure: onFailure)
        }
    }
    
    static private func callRequest<T: Decodable>(router: EndpointConfiguration,
                                                  shouldShowLoading: Bool = false,
                                                  lottieType: LottieType = .loading,
                                                  onSuccess: @escaping (T, String?) -> Void,
                                                  onFailure: @escaping (String?, NetworkError) -> Void) {
        AF.request(router).responseDecodable { (response: AFDataResponse<T?>) in
            if shouldShowLoading {
                LoadingManager.shared.dismissLoading() {
                    handleResponse(response: response,
                                   onSuccess: onSuccess,
                                   onFailure: onFailure)
                }
            }
            else {
                handleResponse(response: response,
                               onSuccess: onSuccess,
                               onFailure: onFailure)
            }
        }
    }
    
    static private func handleResponse<T: Decodable>(response: AFDataResponse<T?>,
                                                     onSuccess: @escaping (T, String?) -> Void,
                                                     onFailure: @escaping (String?, NetworkError) -> Void) {
        printLog(response: response)
        let jsonString = String(bytes: response.data ?? Data(), encoding: .utf8) ?? ""
        let dict = jsonString.convertToDictionary()
        let consumerErrorMessage = dict?["error"] as? String
        switch response.result {
        case .success(let baseData):
            guard let validatedStatusCode = response.response?.statusCode else { return }
            switch validatedStatusCode {
            case 200..<300:
                guard let validatedData = baseData else {
                    onFailure("error200", .noError)
                    return
                }
                onSuccess(validatedData, consumerErrorMessage)
            case 406:
                onFailure("error406", .notValidOtpCode)
            case 417:
                onFailure("error417" , .redirectAuth)
            case 423:
                onFailure("error423", .authenticationLocked)
            default:
                onFailure("errorDefault", .noError)
            }
        case .failure:
            if !ConnectionManager.isConnectedToNetwork() {
                onFailure(consumerErrorMessage, .notConnectedInternet)
            }
            else {
                onFailure(consumerErrorMessage, .noError)
            }
        }
    }

    static private func printLog<T: Decodable>(response: AFDataResponse<T>) {
        print("\n\n\n")
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        debugPrint(response)
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        print("\n\n\n")
    }
}
