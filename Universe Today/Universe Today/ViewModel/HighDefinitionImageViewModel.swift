//
//  HighDefinitionImageViewModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/18.
//

import UIKit

import RxRelay
import RxSwift

class HighDefinitionImageViewModel {
    let disposeBag = DisposeBag()
        
    let setLoadingImage = PublishRelay<Bool>()
    
    let hDImage = PublishRelay<UIImage>()
    
    func setApod() {
        
        ApodService.shared.setLoadingImage
            .subscribe{ [weak self] result in
                self?.setLoadingImage.accept(result)
            }
            .disposed(by: disposeBag)
        
        ApodService.shared.currentApodModel
            .subscribe{ result in
                ApodService.shared.setHDImage(stringUrl: result.hdurl)
            }
            .disposed(by: disposeBag)
        
        ApodService.shared.hdImage
        .subscribe{ [weak self] result in
            self?.hDImage.accept(result)
        }
        .disposed(by: disposeBag)
    }
    
}
