//
//  MainViewModel.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/16.
//

import UIKit

import RxRelay
import RxSwift

class MainViewModel {
    
    let explanationViewController = ExplanationViewController()
    let highDefinitionImageViewController = HighDefinitionImageViewController()
        
    let isLoadImage = PublishRelay<Bool>()
    
    let thumbnaiImage = PublishRelay<UIImage>()
    
    let disposeBag = DisposeBag()
    
    func setApod() {
        ApodService.shared.setApod()
        
        ApodService.shared.setLoadingImage
            .subscribe{ [weak self] result in
                self?.isLoadImage.accept(result)
            }
            .disposed(by: disposeBag)
        
        ApodService.shared.currentApodModel
            .subscribe{ result in
                ApodService.shared.setThumbnaiImage(stringUrl: result.url)
            }
            .disposed(by: disposeBag)
        
        ApodService.shared.thumbnaiImage
            .subscribe{ [weak self] result in
                self?.thumbnaiImage.accept(result)
            }
            .disposed(by: disposeBag)
    }
    
    func setRandomApod() {
        ApodService.shared.setRandomApod()
    }
    
    
}
