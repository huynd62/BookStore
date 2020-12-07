//
//  ResponseModel.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/30/20.
//

import Foundation

struct Response:Codable{
    var json_list:[Message]
}
struct Message:Codable{
    var message:String
}
struct RecommendMessage:Codable{
    var message:[Int]
}
