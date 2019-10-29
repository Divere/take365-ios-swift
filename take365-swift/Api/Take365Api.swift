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
    
    let base = "https://take365.org/api/"
    
    var decoder: JSONDecoder
    var debug = false
    
    init() {
        decoder = JSONDecoder()
        
        #if DEBUG
        debug = true
        #endif
    }
    
    func m(_ methodName: String) -> String {
        return "\(base)\(methodName)"
    }
    
    func errorBody(_ data: Data) -> BaseResponse {
        return try! decoder.decode(BaseResponse.self, from: data)
    }
    
    func register(userName: String, email: String, password: String) {
        AF.request(m("user/register"), method: .post)
    }
    
    func login(userName: String, password: String, success: @escaping (LoginResponse) -> Void, failed: @escaping (BaseResponse.Error?) -> Void) {
        let params = [
            "username": userName,
            "password": password
        ]
        
        AF.request(m("auth/login"), method: .post, parameters: params).responseDecodable { (response: DataResponse<LoginResponse, AFError>) in
            switch(response.result){
            case .success:
                success(response.value!)
                break
            case .failure:
                failed(self.errorBody(response.data!).errors?.last)
                break
            }
        }.validate(statusCode: 200..<300)
    }
    
}
