//
//  Cart.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/22/20.
//

import Foundation

class Cart{
    
    static var theCart = Cart()
    
    var cartDict:[Book:Int] = [Book:Int]()

    func getBooksArray()->[Book]{
        var booksArray = [Book]()
        for book in cartDict.keys{
            if cartDict[book] != nil{
                booksArray.append(book)
            }
        }
        return booksArray
    }
    
    func getBookJSON()->[String:Int]{
        var result = [String:Int]()
        for book in cartDict.keys{
            if cartDict[book] != nil{
                result[String(book.id)] = cartDict[book]
            }
        }
        return result
    }
    
    func clearTheCart(){
        self.cartDict.removeAll()
    }

    func addToMyCart(book:Book,soluong:Int){
    
        if cartDict.keys.contains(book){
            cartDict[book]! += soluong
        }else{
            cartDict[book] = soluong
        }
    }
    
}
