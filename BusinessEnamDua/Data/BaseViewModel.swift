//
//  BaseViewModel.swift
//  BusinessEnamDua
//
//  Created by yxgg on 20/05/23.
//

import RxRelay
import RxCocoa

class BaseViewModel {
    let _isLoading = BehaviorRelay<Bool>(value: false)
    let _errorMessage = BehaviorRelay<String?>(value: nil)
    
    var isLoading: Driver<Bool> {
        return _isLoading.asDriver()
    }
    
    var errorMessage: Driver<String?> {
        return _errorMessage.asDriver()
    }
}
