//
//  BaseViewProtocol.swift
//  Networking
//
//  Created by karim  on 10/08/2022.
//

import Foundation
import UIKit

protocol BaseViewProtocol where Self:UIViewController {
    func showIndicator()
    func hideIndicator()
}

extension BaseViewProtocol {
    
    func showIndicator() {
        print("Should show activity indicator")
    }
    
    func hideIndicator() {
        print("Should hide activity indicator")
    }
    
}
