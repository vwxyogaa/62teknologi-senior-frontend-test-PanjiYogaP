//
//  RemoteDataSource.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import Foundation
import RxSwift

final class RemoteDataSource {
    func getSearchBusiness(location: String, limit: Int) -> Observable<Business> {
        let url = URL(string: Constants.urlPath + "/search?location=\(location)&limit=\(limit)")!
        let data: Observable<Business> = APIManager.shared.executeQuery(url: url, method: .get)
        return data
    }
}
