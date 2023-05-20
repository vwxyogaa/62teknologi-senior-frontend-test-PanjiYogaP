//
//  Injection.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

final class Injection {
    func provideListBusiness() -> ListBusinessUseCaseProtocol {
        let repository = provideRepository()
        return ListBusinessUseCase(repository: repository)
    }
    
    func provideSearchBusiness() -> SearchBusinessUseCaseProtocol {
        let repository = provideRepository()
        return SearchBusinessUseCase(repository: repository)
    }
}

extension Injection {
    func provideRepository() -> RepositoryProtocol {
        let remoteDataSource = RemoteDataSource()
        return Repository.sharedInstance(remoteDataSource)
    }
}
