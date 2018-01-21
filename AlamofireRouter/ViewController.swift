//
//  ViewController.swift
//  AlamofireRouter
//
//  Created by Polina Fiksson on 17/01/2018.
//  Copyright © 2018 PolinaFiksson. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //alamofireGet()
        //alamofirePost()
       // alamofireDelete()
        
        //MARK: Get Todo #1
        
        Todo.todoByID(id: 1){ result in
            if let error = result.error {
                // got an error in getting the data, need to handle it
                print("error calling GET on /todos/")
                print(error)
                return
            }
            
            guard let todo = result.value else {
                print("error calling GET on /todos/ - result is nil")
                return
            }
            //otherwise it is a success
            print(todo.description())
            print(todo.title)
        }
        
        //MARK: Create new todo
        
        guard let newTodo = Todo(title: "My first Todo", id: nil, userId: 1, completedStatus: true) else {
            print("error: Something is wrong with the object creation")
            return
        }
        
        newTodo.save { result in
            
            guard result.error ==  nil else {
                // got an error in getting the data, need to handle it
                print("error calling POST on /todos/")
                print(result.error!)
                return
            }
            guard let todo = result.value else {
                print("error calling POST on /todos/. result is nil")
                return
            }
            //success:
            
            print(todo.description())
            print(todo.title)
            
        }
    }
    
}
    
  
        
        
    //Mark: GET request
    
//    func alamofireGet() {
//
//        //1. set up and send the async request to todoEndpoint
//        //2.Then we get the data (asynchronously) as JSON
//        //using the Router
//        Alamofire.request(TodoRouter.get(1)).responseJSON { (response) in
//
//            //3. check for errors
//            guard response.result.error == nil else {
//                // got an error in getting the data, need to handle it
//                print("error calling GET on /todos/1")
//                print(response.result.error!)
//                return
//            }
//            //4. make sure we got some JSON since that's what we expect
//            guard let json = response.result.value as? [String: Any] else {
//                print("didn't get todo object as JSON from API")
//                print("Error: \(response.result.error!)")
//                return
//            }
//            print(json)
//
//            //5. extract the title from the JSON
//            guard let todoTitle = json["title"] as? String else {
//                print("Could not get the title from JSON")
//                return
//            }
//            print("the title is: " + todoTitle)
//
//        }
//
//    }
    
    //Mark: POST request
    
//    func alamofirePost() {
//        let newTodo: [String: Any] = ["title": "My First Post", "completed": 0, "userId": 1]
//        Alamofire.request(TodoRouter.create(newTodo))
//            .responseJSON { response in
//                guard response.result.error == nil else {
//                    // got an error in getting the data, need to handle it
//                    print("error calling POST on /todos/1")
//                    print(response.result.error!)
//                    return
//                }
//                // make sure we got some JSON since that's what we expect
//                guard let json = response.result.value as? [String: Any] else {
//                    print("didn't get todo object as JSON from API")
//                    print("Error: \(response.result.error)")
//                    return
//                }
//                // get and print the title
//                guard let todoTitle = json["title"] as? String else {
//                    print("Could not get todo title from JSON")
//                    return
//                }
//                print("The title is: " + todoTitle)
//        }
//    }
    //MARK: DELETE request
//    func alamofireDelete() {
//        Alamofire.request(TodoRouter.delete(1))
//            .responseJSON { response in
//                guard response.result.error == nil else {
//                    // got an error in getting the data, need to handle it
//                    print("error calling DELETE on /todos/1")
//                    print(response.result.error!)
//                    return
//                }
//                print("DELETE ok")
//        }
//    }

    




