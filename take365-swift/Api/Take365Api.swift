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
    
    private let base = "https://take365.org/api/"
    
    private var decoder: JSONDecoder
    
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
    
    func register(userName: String, email: String, password: String) {
        AF.request(m("user/register"), method: .post)
    }
    
    func login(accessToken: String, success: @escaping (LoginResponse) -> Void, failed: @escaping (BaseResponse.Error?) -> Void) {
        AF.request(m("auth/reuse-token"), method: .post, parameters: ["accessToken": accessToken]).responseDecodable(of: LoginResponse.self) { response in
            self.handleLoginResponse(response, success: success, failed: failed)
        }
    }
    
    func login(userName: String, password: String, success: @escaping (LoginResponse) -> Void, failed: @escaping (BaseResponse.Error?) -> Void) {
        let params = [
            "username": userName,
            "password": password
        ]
        
        AF.request(m("auth/login"), method: .post, parameters: params).responseDecodable { (response: DataResponse<LoginResponse, AFError>) in
            self.handleLoginResponse(response, success: success, failed: failed)
        }.validate(statusCode: 200..<300)
    }
    
    func getStoryList(success: @escaping (StoryListResponse) -> Void, failed: @escaping (BaseResponse.Error?) -> Void) {
        let accessToken = UserDefaults.standard.string(forKey: "accessToken")
        AF.request(m("story/list?accessToken=\(accessToken!)&username=me&maxItems=100"), method: .get).responseDecodable(of: StoryListResponse.self) { response in
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
}
