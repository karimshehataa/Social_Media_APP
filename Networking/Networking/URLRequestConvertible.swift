//
//  URLRequestConvertible.swift
//  Networking
//
//  Created by karim  on 07/08/2022.
//

import Foundation
import Alamofire

protocol URLRequestConvertible: Alamofire.URLRequestConvertible {
    
    var url: URL { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: Any]? { get }
    
    var encoding: ParameterEncoding { get }
    
    var header: HTTPHeaders { get }
    
}
