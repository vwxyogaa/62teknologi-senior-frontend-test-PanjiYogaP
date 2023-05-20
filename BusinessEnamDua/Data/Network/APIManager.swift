//
//  APIManager.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import Foundation
import Alamofire
import RxSwift

final class APIManager {
    static let shared = APIManager()
    
    func executeQuery<T> (url: URL, method: HTTPMethod, params: Parameters? = nil) -> Observable<T> where T: Codable {
        return Observable<T>.create { observer in
            let headers: HTTPHeaders = [
              "accept": "application/json",
              "Authorization": "Bearer Ubf1-f0uqsJUnssqPMGo-tiFeZTT85oFmKfznlPmjDtX8s83jYMoAb-ApuD63wgq6LDZNsUXG6gurZIVYaj2jzxJmmLdCdXbDqIHU_b6KiCEVi8v-YB0OSsW6MWaY3Yx"
            ]
            AF.request(url, method: method, parameters: params, headers: headers).validate().responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
