//
//  Todo.swift
//  AlamofireRouter
//
//  Created by Polina Fiksson on 19/01/2018.
//  Copyright © 2018 PolinaFiksson. All rights reserved.
//

import Foundation

class Todo {
    var title: String
    var id: Int?
    var userId: Int
    var completed: Bool

    required init?(title: String, id: Int?, userId: Int, completedStatus: Bool) {
        self.title = title
        self.id = id
        self.userId = userId
        self.completed = completedStatus
}
    func description() -> String {
        return "ID: \(String(describing: self.id)), " +
            "User ID: \(self.userId)" +
            "Title: \(self.title)\n" +
            "Completed: \(self.completed)\n"
    }
}
