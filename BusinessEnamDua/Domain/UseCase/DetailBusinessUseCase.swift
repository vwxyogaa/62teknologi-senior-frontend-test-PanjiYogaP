//
//  DetailBusinessUseCase.swift
//  BusinessEnamDua
//
//  Created by yxgg on 21/05/23.
//

import RxSwift

protocol DetailBusinessUseCaseProtocol {
    func getBusinessById(id: String) -> Observable<Business.BusinessElement>
    func getReviewsById(id: String) -> Observable<Reviews>
}

final class DetailBusinessUseCase: DetailBusinessUseCaseProtocol {
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    func getBusinessById(id: String) -> Observable<Business.BusinessElement> {
        repository.getBusinessById(id: id)
    }
    
    func getReviewsById(id: String) -> Observable<Reviews> {
        repository.getReviewsById(id: id)
    }
}

