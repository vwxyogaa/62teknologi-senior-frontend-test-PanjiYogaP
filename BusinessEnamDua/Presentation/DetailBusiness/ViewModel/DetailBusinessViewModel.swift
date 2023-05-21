//
//  DetailBusinessViewModel.swift
//  BusinessEnamDua
//
//  Created by yxgg on 21/05/23.
//

import RxSwift
import RxCocoa

class DetailBusinessViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let detailBusinessUseCase: DetailBusinessUseCaseProtocol
    
    private let _business = BehaviorRelay<Business.BusinessElement?>(value: nil)
    private let _photosBusiness = BehaviorRelay<[String]?>(value: nil)
    private let _reviews = BehaviorRelay<[Reviews.Review]?>(value: nil)
    
    init(detailBusinessUseCase: DetailBusinessUseCaseProtocol) {
        self.detailBusinessUseCase = detailBusinessUseCase
    }
}

extension DetailBusinessViewModel {
    // MARK: - Business
    var business: Driver<Business.BusinessElement?> {
        return _business.asDriver()
    }
    
    func getBusinessById(id: String) {
        self._isLoading.accept(true)
        detailBusinessUseCase.getBusinessById(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._business.accept(result)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}

extension DetailBusinessViewModel {
    // MARK: - Photos Business
    var photosBusiness: Driver<[String]?> {
        return _photosBusiness.asDriver()
    }
    
    var photosBusinessCount: Int {
        return _photosBusiness.value?.count ?? 0
    }
    
    func photosBusiness(at index: Int) -> String? {
        return _photosBusiness.value?[safe: index]
    }
    
    func getPhotoBusiness(id: String) {
        self._isLoading.accept(true)
        detailBusinessUseCase.getBusinessById(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._photosBusiness.accept(result.photos)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}

extension DetailBusinessViewModel {
    // MARK: - Reviews
    var reviews: Driver<[Reviews.Review]?> {
        return _reviews.asDriver()
    }
    
    var reviewsCount: Int {
        return _reviews.value?.count ?? 0
    }
    
    func review(at index: Int) -> Reviews.Review? {
        return _reviews.value?[safe: index]
    }
    
    func getReviewsById(id: String) {
        self._isLoading.accept(true)
        detailBusinessUseCase.getReviewsById(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isLoading.accept(false)
                self._reviews.accept(result.reviews)
            } onError: { error in
                self._isLoading.accept(false)
                self._errorMessage.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
