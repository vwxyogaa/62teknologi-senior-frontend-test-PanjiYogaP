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
    
    func getBusinessById(id: String) -> Observable<Business.BusinessElement> {
        let url = URL(string: Constants.urlPath + "/" + id)!
        let data: Observable<Business.BusinessElement> = APIManager.shared.executeQuery(url: url, method: .get)
        return data
    }
    
    func getReviewsById(id: String) -> Observable<Reviews> {
        let url = URL(string: Constants.urlPath + "/" + id + "/reviews")!
        let data: Observable<Reviews> = APIManager.shared.executeQuery(url: url, method: .get)
        return data
    }
}
