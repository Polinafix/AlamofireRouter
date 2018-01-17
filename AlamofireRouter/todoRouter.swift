//
//  todoRouter.swift
//  AlamofireRouter
//
//  Created by Polina Fiksson on 17/01/2018.
//  Copyright © 2018 PolinaFiksson. All rights reserved.
//

import Foundation
import Alamofire

enum TodoRouter: URLRequestConvertible {
    static let baseURLString = "https://jsonplaceholder.typicode.com/"
    
    case get(Int)
    case create([String: Any])
    case delete(Int)
    
    func asURLRequest() throws -> URLRequest {
        //TODO: implement
        //we’ll need a few elements that we’ll combine to create the url
        //request: the HTTP method, any parameters to pass, and the URL
        
        var method: HTTPMethod {
            switch self {
                case .get:
                    return .get
            case .create:
                return .post
            case .delete:
                return .delete
            }
        }
            
            let params: ([String:Any]?) = {
                
                switch self {
                case .get, .delete:
                    return nil
                case .create(let newTodo):
                    return(newTodo)
                }
            }()
            
            //build up the URL request. First we’ll need the URL. We have the base URL added above so we can combine it with the relative path for each case to get the full URL
            
            let url: URL = {
                
                let relativePath:String?
                
                switch self {
                case .get(let number):
                    relativePath = "todos/\(number)"
                case .create:
                    relativePath = "todos"
                case .delete(let number):
                    relativePath = "todos/\(number)"
                }
                
                var url = URL(string: TodoRouter.baseURLString)!
                if let relativePath = relativePath {
                    url = url.appendingPathComponent(relativePath)
                }
                return url
            }()
        
        //put everythong together to create a URL request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        //encode any parameters and add them to the request.
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
        }
    
}
