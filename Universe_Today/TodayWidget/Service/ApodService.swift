//
//  ApodService.swift
//  Universe_Today
//
//  Created by 원태영 on 2023/06/24.
//

import Foundation

final class ApodService {
    /*
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
     */
}
