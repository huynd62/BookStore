//
//  EventService.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 06/12/2020.
//

import Foundation

class EventService{
    
    static let shared = EventService()
    
    let api = K2.eventAPI

    var events:[Event] = []
    

    func getEventsFromServer(){
        
        let task = URLSession(configuration: .default).dataTask(with: URL(string: api)!) { (data, response, error) in
            if error != nil{
                return
            }
            else{
                if (response as! HTTPURLResponse).statusCode == 201 {
                    if let data = data {
                        let decoder = JSONDecoder()
                        let safedata = try! decoder.decode(EventDetail.self, from: data)
                        for event in safedata.json_list{
                            self.events.append(event)
                        } 
                    }
                }
                
            }
        }
        task.resume()
        
    }
    
    
    

}
