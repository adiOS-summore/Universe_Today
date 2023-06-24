//
//  ExplanationViewModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/18.
//

import UIKit

import RxRelay
import RxSwift

class ExplanationViewModel {
    
    let disposeBag = DisposeBag()
    
    let title = PublishRelay<String>()
    let explanation = PublishRelay<String>()
    let copyright = PublishRelay<String>()
    
    func setApod() {
        
        ApodService.shared.currentApodModel
            .subscribe(onNext: { [weak self] result in
                self?.title.accept(result.title)
                self?.explanation.accept(result.explanation.addNewline())
                self?.copyright.accept(result.copyright != nil ? "Copyright : " + result.copyright! : "")
            })
            .disposed(by: disposeBag)
        
    }
}
