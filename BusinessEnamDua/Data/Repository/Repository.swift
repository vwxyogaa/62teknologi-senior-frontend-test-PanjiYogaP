//
//  Repository.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import Foundation
import RxSwift

protocol RepositoryProtocol {
    func getSearchBusiness(location: String, limit: Int) -> Observable<Business>
}

final class Repository: NSObject {
    typealias BEDInstance = (RemoteDataSource) -> Repository
    fileprivate let remote: RemoteDataSource
    
    init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: BEDInstance = { remote in
        return Repository(remote: remote)
    }
}

extension Repository: RepositoryProtocol {
    func getSearchBusiness(location: String, limit: Int) -> Observable<Business> {
        return remote.getSearchBusiness(location: location, limit: limit)
    }
}
