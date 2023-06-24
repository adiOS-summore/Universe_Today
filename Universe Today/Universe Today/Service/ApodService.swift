//
//  ApodService.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/16.
//

import UIKit

import RxSwift
import RxRelay
import Alamofire

class ApodService {
    
    static let shared = ApodService()
    
    let currentApodModel = BehaviorRelay<ApodModel>(value: ApodModel(title: "", explanation: "", url: "", hdurl: "", date: "", copyright: "", media_type: "", service_version: ""))
    
    let setLoadingImage = PublishRelay<Bool>()
    
    let hdImage = PublishRelay<UIImage>()
    
    let thumbnaiImage = PublishRelay<UIImage>()
    
    //MARK: RX를 사용했을때
    func setApod() {
        let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1"
        AF.request(myURL).responseDecodable(of: ApodModel.self){ (response) in
            switch response.result {
            case .failure(let err) :
                NSLog("setAPI/setApod Err : \(err)")
                //하단주석 1참고
                self.setRandomApod()
            case .success(let result) :
                self.currentApodModel.accept(result)
            }
        }
    }
    
    func setRandomApod() {
        self.setLoadingImage.accept(true)
        
        let myURL = "https://api.nasa.gov/planetary/apod?api_key=fBAxAPBbZF0M2JffWJb5751s5Y5bln4ec2nQ0sq1&count=1"
        AF.request(myURL).responseDecodable(of: Array<ApodModel>.self){ (response) in
            switch response.result {
            case .failure(let err) :
                NSLog("setAPI/setRandomApod Err : \(err)")
                //하단주석 1참고
                self.setRandomApod()
            case .success(let result) :
                guard let randomApod = result.first else {
                    NSLog("Error ApodService/setRandomApod/nil ")
                    return
                }
                self.currentApodModel.accept(randomApod)
            }
        }
    }
    
    func setHDImage (stringUrl:String) {
        AF.request( stringUrl, method: .get).response{ response in
            switch response.result {
            case .success(let responseData):
                self.hdImage.accept(UIImage(data:responseData!)!)
            case .failure(let error):
                NSLog("Error/setHDImage--->\(error)")
            }
        }
    }
    
    func setThumbnaiImage (stringUrl:String) {
        if stringUrl == "" { return }
        AF.request( stringUrl, method: .get).response{ response in
            switch response.result {
            case .success(let responseData):
                self.thumbnaiImage.accept(UIImage(data:responseData!)!)
            case .failure(let error):
                NSLog("Error/setThumbnaiImage--->\(error)")
            }
        }
    }
    
}


/*
 MARK: 하단주석 1
    받아온 값에 문제가 있을 경우 랜덤 이미지를 값을 출력시킴
    해당 문제를 완벽히 처리하고 싶으면 api가 뿌리는 모든 결과값을 가지고 처리를 해야 하는데
    문서에 나오지 않아서 확인하기가 어렵다.
 */
