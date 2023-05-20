//
//  ListBusinessViewModel.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import RxSwift
import RxCocoa

class ListBusinessViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let listBusinessUseCase: ListBusinessUseCaseProtocol
    
    private let _listBusiness = BehaviorRelay<[Business.BusinessElement]?>(value: nil)
    
    // MARK: - Pagination
    private var listBusinessResults = [Business.BusinessElement]()
    private var listBusinessResultsCount = 0
    private var listBusinessPage = 1
    private var listBusinessCanLoadNextPage = false
    
    init(listBusinessUseCase: ListBusinessUseCaseProtocol) {
        self.listBusinessUseCase = listBusinessUseCase
        super.init()
        getSearchBusiness()
    }
    
    func refresh() {
        listBusinessResults = []
        listBusinessResultsCount = 0
        listBusinessPage = 1
        getSearchBusiness()
    }
}

extension ListBusinessViewModel {
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
        listBusinessUseCase.getSearchBusiness(location: "NYC", limit: 20)
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
