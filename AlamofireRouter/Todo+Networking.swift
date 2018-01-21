//
//  Todo+Networking.swift
//  AlamofireRouter
//
//  Created by Polina Fiksson on 19/01/2018.
//  Copyright © 2018 PolinaFiksson. All rights reserved.
//

import Foundation
import Alamofire

extension Todo {
    //initializer that will create a Todo object from JSON
    convenience init?(json:[String: Any]){
        /* check that we can get all of the required properties
         using a guard statement. If we don’t find everything that’s needed then we can return nil to indicate that we couldn’t create our object */
        guard let title = json["title"] as? String,
            let userId = json["userId"] as? Int,
            let completed = json["completed"] as? Bool
            else {
                return nil
        }
        
        let idValue = json["id"] as? Int
        
        //finally we can use the existing initializer to create a Todo
        self.init(title: title, id: idValue, userId: userId, completedStatus: completed)
    }
    
    //The Result struct packs up the result (our Todo object and/or an error).
    class func todoByID(id: Int, completionHandler: @escaping (Result<Todo>) -> Void) {
        Alamofire.request(TodoRouter.get(id)).responseJSON { (response) in
            let result = Todo.todoFromResponse(response: response)
            completionHandler(result)
        }
    }
    enum BackendError: Error {
        case objectSerialization(reason: String)
    }
    //turn a Todo into a dictionary with String keys
    func toJSON() -> [String: Any] {
        var json = [String: Any]()
        json["title"] = title
        if let id = id {
            json["id"] = id
        }
        json["userId"] = userId
        json["completed"] = completed
        return json
    }
    
    // POST / Create
    func save(completionHandler: @escaping (Result<Todo>) -> Void) {
        let fields = self.toJSON()
        Alamofire.request(TodoRouter.create(fields))
            .responseJSON { response in
                // handle response
                let result = Todo.todoFromResponse(response: response)
                completionHandler(result)
        }
    }
    
    private class func todoFromResponse(response: DataResponse<Any>) -> Result<Todo> {
        guard response.result.error == nil else {
            // got an error in getting the data, need to handle it
            print(response.result.error!)
            return .failure(response.result.error!)
        }
        // make sure we got JSON and it's a dictionary
        guard let json = response.result.value as? [String: Any] else {
            print("didn't get todo object as JSON from API")
            return .failure(BackendError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        // turn JSON in to Todo object
        guard let todo = Todo(json: json) else {
            return .failure(BackendError.objectSerialization(reason:
                "Could not create Todo object from JSON"))
        }
        return .success(todo)
    }
    
    
    
}
