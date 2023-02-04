//
//  Network.swift
//  Networking
//
//  Created by karim  on 07/08/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias networkCompletion<T> = (AFResult<T>) -> ()

protocol NetworkProtocol {
    
    func request<T>(ـ request: URLRequestConvertible, decodeTo type: T.Type, completionHandler: @escaping networkCompletion<T>) where T: Codable
    
    func cancelALLRequests()
}

class Network: NetworkProtocol {
    
    private let networkMiddleware = NetworkMiddleware()
    
    //Use a networkmiddleware to append the headers globally
    private lazy var manager: Session = {
        let manager = networkMiddleware.sessionManager
        //        manager.adapter = networkMiddleware
        return manager
    }()
    
    func request<T>(ـ request: URLRequestConvertible, decodeTo type: T.Type, completionHandler: @escaping (AFResult<T>) -> ()) where T : Decodable, T : Encodable {
        print(request)
        manager.request(request).responseJSON { [weak self] response in
            guard let self = self else {return}
            completionHandler(self.process(response: response, decodedTo: type))
        }
        
    }
    
    func cancelALLRequests() {
        AF.session.getAllTasks { tasks in tasks.forEach { $0.cancel() } }
        
    }
    
    
    private func process<T>(response: AFDataResponse<Any>, decodedTo Type: T.Type) -> AFResult<T> where T: Codable {
        
        switch response.result {
            
        case .success:
            guard let data = response.data else {
                return .failure(NSError.create(description:"Something went wrong") as! AFError)
            }
            #if DEBUG
            print(JSON(response.value ?? [:]))
            #endif
            
            do {
                let data = try JSONDecoder.decodeFromData(Type, data: data)
                return .success(data)
            } catch {
                #if DEBUG
                debugPrint(error)
                #endif
                return .failure(AFError.responseSerializationFailed(reason: .customSerializationFailed(error: NSError.create(description: "Server Error."))))
            }
            
        case .failure(let error):
            #if DEBUG
            debugPrint("#DEBUG#", error.localizedDescription)
            #endif
            if error.localizedDescription.contains("JSON") {
                return .failure(AFError.responseSerializationFailed(reason: .customSerializationFailed(error: NSError.create(description: "Server Error."))))
            }
            return .failure(error)
        }
        
    }
    
    class NetworkMiddleware: RequestAdapter {
        func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
            var urlRequest = urlRequest
            urlRequest.setValue("en", forHTTPHeaderField: "X-localization")
            urlRequest.setValue("ios", forHTTPHeaderField: "os")
            completion(.success(urlRequest))
            //        if let token = UserDefaultsHelper.apiToken {
            //            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            //        }
        }
        
        let sessionManager: Session = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = configuration.headers.dictionary
            configuration.timeoutIntervalForResource = 60
            configuration.timeoutIntervalForRequest = 60
            return Session(configuration: configuration)
        }()
    }
}

