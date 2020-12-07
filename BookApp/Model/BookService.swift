//
//  BookService.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/25/20.
//

import Foundation
import UIKit



class BookService{
    
    let serviceAPIURL = "https://project-4th.herokuapp.com/iosapi/getbooks"
    
    static var myBooks = BookService()
    
        
    var book:[Book] = []
    
    func getTheBooks(){
        let task = URLSession(configuration: .default).dataTask(with: URL(string: serviceAPIURL)!) { (data, response, error) in
            if error != nil {
                print("there was an error")
                print(error!.localizedDescription)
            }else{
                if let safeData = data {
                    let decoder = JSONDecoder()
                    let decodedData = try! decoder.decode(BookList.self, from: safeData)
                    for book in decodedData.json_list{
                        self.book.append(book)
                    }
                }
            }
        }
        task.resume()
    }
    
    
    
}

