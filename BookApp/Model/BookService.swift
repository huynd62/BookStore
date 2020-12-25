//
//  BookService.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/25/20.
//

import Foundation
import UIKit



protocol BookServiceUpdate:class {
    func bookIsUpdated()
    func noUpdateAvailable()
}

class BookService{
    
    let serviceAPIURL = "https://project-4th.herokuapp.com/iosapi/getbooks"
    
    static var myBooks = BookService()
    
    weak var updateDelegate:BookServiceUpdate?
        
    var book:[Book] = []
    var updateBook:[Book] = []
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
    
    func updateBooks(){
        print("We are inside the updatebook function that call the api.")
        let task = URLSession(configuration: .default).dataTask(with: URL(string: serviceAPIURL)!) { (data, response, error) in
            if error != nil {
                print("there was an error")
                print(error!.localizedDescription)
            }else{
                if let safeData = data {
                    let decoder = JSONDecoder()
                    let decodedData = try! decoder.decode(BookList.self, from: safeData)
                    for book in decodedData.json_list{
                        self.updateBook.append(book)
                    }
                }
            }
            print("Inside the completion handler")
            print("let say: we have : \(self.updateBook.count) books. We have to find out which book was update")
            var i = 0
            var bookUpdate = [Book]()
            for book in self.updateBook{
                if self.book.contains(book){
                    continue
                }else{
                    bookUpdate.append(book)
                    i += 1
                }
            }
            self.updateBook = []
            if i != 0{
                for i in 0...bookUpdate.count - 1{
                    for j in 0...self.book.count - 1{
                        if bookUpdate[i].equalID(book: self.book[j]){
                            self.book[j] = bookUpdate[i]
                            bookUpdate.remove(at: i)
                            break
                        }
                    }
                }
                if bookUpdate.count > 0 {
                    for book in bookUpdate{
                        self.book.append(book)
                    }
                }
                self.updateDelegate?.bookIsUpdated()
            }else{

                self.updateDelegate?.noUpdateAvailable()
            }
        }
        task.resume()
    }
    
    
    
    
}

