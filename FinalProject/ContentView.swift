//
//  ContentView.swift
//  FinalProject
//
//  Created by Nguyễn Đức Huy on 9/22/20.
//

import SwiftUI
import UIKit
import Combine


struct ContentView: View {
    var data:[Book] = [
        Book(id: 1, coverImage: #imageLiteral(resourceName: "conan1"), name: "Conan tập 1", nxb: "Kim Dong", dongia: 19000, theloai: "TruyenTranh"),
        Book(id: 2, coverImage: #imageLiteral(resourceName: "conan2"), name: "Conan tập 2", nxb: "Kim Dong", dongia: 19000, theloai: "TruyenTranh"),
        Book(id: 3, coverImage: #imageLiteral(resourceName: "conan3"), name: "Conan tập 3", nxb: "Kim Dong", dongia: 19000, theloai: "TruyenTranh"),
        Book(id: 4, coverImage: #imageLiteral(resourceName: "conan4"), name: "Conan tập 4", nxb: "Kim Dong", dongia: 19000, theloai: "TruyenTranh"),
        Book(id: 5, coverImage: #imageLiteral(resourceName: "conan5"), name: "Conan tập 5 Tập đặc biệt", nxb: "Kim Dong", dongia: 19000, theloai: "TruyenTranh"),
        Book(id: 6, coverImage: #imageLiteral(resourceName: "conan6"), name: "Conan tập 6 ", nxb: "Kim Dong", dongia: 19000, theloai: "TruyenTranh"),
        Book(id: 7, coverImage: #imageLiteral(resourceName: "nhagiakim"), name: "Nhà giả kim", nxb: "Nhã Nam", dongia: 19000, theloai: "TruyenTranh")
    ]
    var body: some View {
        
        VStack(spacing:1){
            SearchBar()
            ScrollView(.horizontal,showsIndicators:false){
                HStack{
                    ForEach(data){
                        book in
                        
                        BookListCell(book: book)
                    }
                }.frame(height:200)
            }
            Spacer()
            
        }
        Spacer()
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Host: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
