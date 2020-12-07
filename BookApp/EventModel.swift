//
//  EventModel.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/29/20.
//

import Foundation
import UIKit


class EventDetail:Decodable{
    var json_list:[Event]
}

class Event:Decodable{
        
    var id:Int
    var name:String
    
    var imageURL:String {
        "https://project-4th.herokuapp.com/iosapi/eventimage/" + String(id)
    }
    
    lazy var image:UIImage? = nil
    
    
    init(name:String,id:Int){
        self.name = name
        self.id = id
    }
    
}
