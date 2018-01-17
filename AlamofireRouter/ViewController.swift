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
        
        alamofireGet()
        //alamofirePost()
       // alamofireDelete()
        
    
        
        
    }
    
    func alamofireGet() {
        
        //1. set up and send the async request to todoEndpoint
        //2.Then we get the data (asynchronously) as JSON
        //using the Router
        Alamofire.request(TodoRouter.get(1)).responseJSON { (response) in
            
            //3. check for errors
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /todos/1")
                print(response.result.error!)
                return
            }
            //4. make sure we got some JSON since that's what we expect
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(response.result.error!)")
                return
            }
            print(json)
            
            //5. extract the title from the JSON
            guard let todoTitle = json["title"] as? String else {
                print("Could not get the title from JSON")
                return
            }
            print("the title is: " + todoTitle)
            
        }
        
    }
    
    func alamofirePost() {
        let newTodo: [String: Any] = ["title": "My First Post", "completed": 0, "userId": 1]
        Alamofire.request(TodoRouter.create(newTodo))
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /todos/1")
                    print(response.result.error!)
                    return
                }
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    print("Error: \(response.result.error)")
                    return
                }
                // get and print the title
                guard let todoTitle = json["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
        }
    }
    
    func alamofireDelete() {
        Alamofire.request(TodoRouter.delete(1))
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling DELETE on /todos/1")
                    print(response.result.error!)
                    return
                }
                print("DELETE ok")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

