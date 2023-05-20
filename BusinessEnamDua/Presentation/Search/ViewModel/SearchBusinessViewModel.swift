//
//  SearchBusinessViewModel.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import RxSwift
import RxCocoa

class SearchBusinessViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let searchBusinessUseCase: SearchBusinessUseCaseProtocol
    
    private let _listBusiness = BehaviorRelay<[Business.BusinessElement]?>(value: nil)
    
    private var location: String?
    
    // MARK: - Pagination
    private var listBusinessResults = [Business.BusinessElement]()
    private var listBusinessResultsCount = 0
    private var listBusinessPage = 1
    private var listBusinessSize = 20
    private var listBusinessCanLoadNextPage = false
    
    init(searchBusinessUseCase: SearchBusinessUseCaseProtocol) {
        self.searchBusinessUseCase = searchBusinessUseCase
    }
}

extension SearchBusinessViewModel {
    // MARK: - List Business
    var listBusiness: Driver<[Business.BusinessElement]?> {
        return _listBusiness.asDriver()
    }
    
    var listBusinessCount: Int {
        return _listBusiness.value?.count ?? 0
    }
    
    func listBusiness(at index: Int) -> Business.BusinessElement? {
        return _listBusiness.value?[safe: index]
    }
    
    func getSearchBusiness() {
        self._isLoading.accept(true)
        searchBusinessUseCase.getSearchBusiness(location: location ?? "", limit: 20)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self.listBusinessResults.append(contentsOf: result.businesses ?? [])
                self.listBusinessResultsCount += result.businesses?.count ?? 0
                if self.listBusinessResults.count == self.listBusinessResultsCount {
                    self.listBusinessPage += 1
                    self.listBusinessCanLoadNextPage = false
                    self._listBusiness.accept(self.listBusinessResults)
                }
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    func loadListBusinessNextPage(index: Int) {
        if !listBusinessCanLoadNextPage {
            if listBusinessCount - 2 == index {
                listBusinessCanLoadNextPage = true
                getSearchBusiness()
            }
        }
    }
}

extension SearchBusinessViewModel {
    // MARK: - Query
    func setLocation(location: String?) {
        listBusinessPage = 1
        _listBusiness.accept(nil)
        self.location = location
        getSearchBusiness()
    }
}
