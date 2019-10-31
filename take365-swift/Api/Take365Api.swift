//
//  Take365Api.swift
//  take365-swift
//
//  Created by Evgeniy Eliseev on 29.10.2019.
//  Copyright © 2019 Evgeniy Eliseev. All rights reserved.
//

import Foundation
import Alamofire

class Take365Api {
    
    private static var _instance: Take365Api? = nil
    static var instance: Take365Api {
        get {
            if(_instance == nil) {
                _instance = Take365Api()
            }
            return _instance!
        }
    }
    
    private let base = "https://take365.vasa.tech/api/"
    
    private var decoder: JSONDecoder
    private var aaf = AAF()
    
    var onInvalidAccessToken: (() -> Void)? = nil
    
    init() {
        decoder = JSONDecoder()
    }
    
    private func m(_ methodName: String) -> String {
        return "\(base)\(methodName)"
    }
    
    private func errorBody(_ data: Data) -> BaseResponse {
        return try! decoder.decode(BaseResponse.self, from: data)
    }
    
    private func onErrorResponse(_ responseData: Data?, error: AFError, next: @escaping (BaseResponse.Error?) -> Void) {
        if(responseData == nil) {
            next(nil)
            return
        }
        
        let response = self.errorBody(responseData!)
        if(response.errors != nil) {
            guard let code = response.errors?[0].code else {
                next(response.errors![0])
                return
            }
            
            print(code)
            switch code {
            case "AUTH_BAD_TOKEN":
                onInvalidAccessToken?()
                break
            default: break
            }
        } else {
            print(String(bytes: responseData!, encoding: String.Encoding.utf8))
            print(error)
            next(BaseResponse.Error(code: "", value: "Unrecoverable error. Please wait while developer will fix it.", field: ""))
        }
    }
    
    fileprivate func handleLoginResponse(_ response: DataResponse<LoginResponse, AFError>, success: @escaping (LoginResponse) -> Void, failed: @escaping (BaseResponse.Error?) -> Void) {
        switch(response.result){
        case .success(let value):
            success(value)
            break
        case .failure(let error):
            self.onErrorResponse(response.data, error: error, next: failed)
            break
        }
    }
    
    func resetAccessToken() {
        aaf.headers.remove(name: "accessToken")
    }
    
    func setAccessToken(accessToken: String) {
        aaf.headers.remove(name: "accessToken")
        aaf.headers.add(name: "Authorization", value: "Bearer \(accessToken)")
    }
    
    private func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    func register(userName: String, email: String, password: String) {
        aaf.request(m("user/register"), method: .post)
    }
    
    func login(accessToken: String, success: @escaping (LoginResponse) -> Void, failed: @escaping (BaseResponse.Error?) -> Void) {
        aaf.request(m("auth/reuse-token"), method: .post, parameters: ["accessToken": accessToken]).responseDecodable(of: LoginResponse.self) { response in
            self.handleLoginResponse(response, success: success, failed: failed)
        }
    }
    
    func login(userName: String, password: String, success: @escaping (LoginResponse) -> Void, failed: @escaping (BaseResponse.Error?) -> Void) {
        let params = [
            "username": userName,
            "password": password
        ]
        
        aaf.request(m("auth/login"), method: .post, parameters: params).responseDecodable { (response: DataResponse<LoginResponse, AFError>) in
            self.handleLoginResponse(response, success: success, failed: failed)
        }
    }
    
    func getStoryList(success: @escaping (StoryListResponse) -> Void, failed: @escaping (BaseResponse.Error?) -> Void) {
        aaf.request(m("story/list?username=me&maxItems=100"), method: .get).responseDecodable(of: StoryListResponse.self) { response in
            switch(response.result) {
            case .success(let value):
                success(value)
                break
            case .failure(let error):
                self.onErrorResponse(response.data, error: error, next: failed)
                break
            }
        }
    }
    
    func getFeed(success: @escaping (GetFeedResponse) -> Void, failed: @escaping (BaseResponse.Error?) -> Void) {
        aaf.request(m("feed/feed"), method: .get).responseDecodable(of: GetFeedResponse.self) { response in
            switch(response.result) {
            case .success(let value):
                success(value)
                break
            case .failure(let error):
                self.onErrorResponse(response.data, error: error, next: failed)
                break
            }
        }
    }
    
    class AAF {
        var headers = HTTPHeaders()
        
        func request(_ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        interceptor: RequestInterceptor? = nil) -> DataRequest {
            return AF.request(url, method: method, parameters: parameters, headers: self.headers, interceptor: interceptor)
                .validate(statusCode: 200..<300)
        }
    }
    
    
}
