//
//  String+.swift
//  Universe Today
//
//  Created by Ruyha on 2023/02/10.
//

import UIKit

extension String {
    
    //문장이 한번에 읽기가 힘들어 개행을 해주는 친구.
    func addNewline()-> String {
        self.replacingOccurrences(of: ".", with: ".\n\n")
    }
    
}
