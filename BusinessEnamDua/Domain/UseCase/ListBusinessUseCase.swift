//
//  ListBusinessUseCase.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import RxSwift

protocol ListBusinessUseCaseProtocol {
    func getSearchBusiness(location: String, limit: Int) -> Observable<Business>
}

final class ListBusinessUseCase: ListBusinessUseCaseProtocol {
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func getSearchBusiness(location: String, limit: Int) -> Observable<Business> {
        return repository.getSearchBusiness(location: location, limit: limit)
    }
}
