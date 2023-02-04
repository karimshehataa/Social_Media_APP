//
//  AuthRouter.swift
//  Networking
//
//  Created by karim  on 09/08/2022.
//

import Foundation
import Alamofire

enum AuthRouter: URLRequestConvertible {
    
    case getPosts(parameter:[String:Any])
    case getCommentsPost(parameter:[String:Any])
    case getUsers
    case getTags
    case createUser(parameter:[String:Any])
    case signInUser(parameter:[String:Any])
    case createComment(parameter:[String:Any])
    case createPost(parameters:[String:Any])
    
    var url: URL {
        let endpoint: String
        switch self {
        case .getPosts(let para):
            endpoint = Constants.AuthEndPoints.post
            var url = URLComponents(string: endpoint)!
            let paraKey = Array(para)[0].key
            let paraValue = Array(para)[0].value as? String
            url.queryItems = [
                URLQueryItem(name: paraKey, value: paraValue)
            ]
            print(endpoint)
            
        case .getCommentsPost(let para):
            endpoint = Constants.AuthEndPoints.post + "/\(para["id"] ?? "")" + "/\(Constants.AuthEndPoints.comment)"
//            print(endpoint)
            
        case .getUsers:
            endpoint = Constants.AuthEndPoints.user
            
        case .getTags:
            endpoint = Constants.AuthEndPoints.tag
            
        case .createUser:
            endpoint = Constants.AuthEndPoints.user + Constants.AuthEndPoints.createUser
            
        case .signInUser(let para):
            endpoint = Constants.AuthEndPoints.user
            var url = URLComponents(string: endpoint)!
            let paraKey = Array(para)[0].key
            let paraValue = Array(para)[0].value as? String
            url.queryItems = [
                URLQueryItem(name: paraKey, value: paraValue)
            ]
//            print(endpoint)
            
        case .createComment:
            endpoint = Constants.AuthEndPoints.comment + Constants.AuthEndPoints.createComment
            
        case .createPost:
            endpoint = Constants.AuthEndPoints.post + Constants.AuthEndPoints.createPost
        }
        
        return URL(string: Constants.baseURL)!.appendingPathComponent(endpoint)
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getPosts:
            return URLEncoding.default
        case .getCommentsPost:
            return URLEncoding.default
        case .getUsers:
            return JSONEncoding.default
        case .getTags:
            return JSONEncoding.default
        case .createUser:
            return JSONEncoding.default
        case .signInUser:
            return URLEncoding.default
        case .createComment:
            return JSONEncoding.default
        case .createPost:
            return JSONEncoding.default
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
        case .getCommentsPost:
            return .get
        case .getUsers:
            return .get
        case .getTags:
            return .get
        case .createUser:
            return .post
        case .signInUser:
            return .get
        case .createComment:
            return .post
        case .createPost:
            return .post
        }
    }
    
    var parameters: [String:Any]? {
        
        switch self {
        case .getPosts(let para):
            return para
        case .getCommentsPost(let para):
            return para
        case .getUsers:
            return nil
        case .getTags:
            return nil
        case .createUser(let para):
            return para
        case .signInUser(let para):
            return para
        case .createComment(let para):
            return para
        case .createPost(parameters: let para):
            return para
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        default:
            return ["app-id":"630a10f1919281b4285fdd69"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = header
        return try encoding.encode(urlRequest, with: parameters)
    }
}
