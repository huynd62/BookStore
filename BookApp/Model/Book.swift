//
//  Books.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/21/20.
//

import Foundation
import UIKit

class BookList:Decodable{
    var json_list:[Book]
}

class Book:Hashable,Equatable,Decodable{
    

    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id && lhs.hotsale == rhs.hotsale && lhs.name == rhs.name && lhs.mota == rhs.mota && lhs.tacgia == rhs.tacgia && lhs.price == rhs.price && lhs.theloai == rhs.theloai && lhs.nxb == rhs.nxb
    }
    
    func equalID(book:Book) -> Bool{
        self.id == book.id
    }
    var id:Int
    var name:String
    var price:Int
    var tacgia:String
    var mota:String
    var nxb:Int
    var theloai:Int
    var hotsale:Bool?
    
    var nhaxuatban:String {
        String(nxb)
    }
    var category:String{
        switch theloai {
        case 1:
            return "Truyện Tranh"
        case 2:
            return "Self-Help"
        case 3:
            return "CNTT"
        case 4:
           return  "Tiểu Thuyết"
        case 5:
            return "Kinh Tế-Chính Trị"
        default:
            return "Not Found"
        }
    }
    
    var nhaxuatban1:String {
        switch nxb {
        case 1:
            return "Kim Đồng"
        case 2:
            return "Raywenderlich"
        case 3:
            return "Đông A"
        case 4:
            return "NXB Trẻ"
        case 5:
            return "First News"
        case 6:
            return "Nhã Nam"
        case 7:
            return "Trí Thức"
        case 8:
            return "Thái Hà Books"
        default:
            return "Not Found"
        }
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    lazy var coverImage:UIImage? = nil
    
    var imageURL:String{
        "https://project-4th.herokuapp.com/callimage/\(id)"
    }
    
    init(id:Int,name:String,price:Int,nxb:Int,mota:String,tacgia:String,theloai:Int,hotsale:Bool) {
        
        self.id = id
        self.name = name
        self.price = price
        self.nxb = nxb
        self.mota = mota
        self.tacgia = tacgia
        self.theloai = theloai
        self.hotsale = hotsale
        
    }
}



