//
//  BookListCell.swift
//  FinalProject
//
//  Created by Nguyễn Đức Huy on 9/22/20.
//

import SwiftUI

struct BookListCell: View {
    let book:Book
    var body: some View {
        VStack(){
            Image(uiImage: book.coverImage)
                .resizable()
                .frame(width:100, height:150)
                .cornerRadius(10)
            
            Text(book.name)
                .frame(maxWidth:200)
                .foregroundColor(Color.gray)
                .font(.subheadline)
        }
    }
}

struct BookListCell_Previews: PreviewProvider {
    static var previews: some View {
        BookListCell(book:  Book(id: 1, coverImage: #imageLiteral(resourceName: "conan1"), name: "Conan tap 1", nxb: "Kim Dong", dongia: 19000, theloai: "TruyenTranh"))
    }
}
