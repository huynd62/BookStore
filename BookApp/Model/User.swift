//
//  User.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 11/7/20.
//

import Foundation

class User {
    
    private var id:Int?
    private var username:String?
    static let theUser = User()

    init() {
        
    }
    func setid(id:Int){
        self.id = id
    }
    func setusername(username:String?){
        self.username = username
    }
    func getid()->Int{
        return self.id!
    }
    func getusername()->String{
        return self.username!
    }
    
}
