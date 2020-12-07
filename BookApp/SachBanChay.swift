//
//  SachBanChay.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/21/20.
//

import Foundation
import UIKit


protocol clickAtBook:class{
    func showBoolDetail(book:Book)
}


class SachBanChay:UIView{

    var HomeVC:clickAtBook?
    
    var topsellers : [Book] = []
    
    let cellIdentifier = "sachcvsell"
    
    let sachbanchayLabel:UILabel = {
        let lb = UILabel(frame: .zero)
//        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Sách Bán Chạy"
        lb.textAlignment = .left
        return lb
    }()
    
    let flowLayout :UICollectionViewFlowLayout = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        return fl
    }()
    
    lazy var sachbanchayCollectionView :UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SachCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    lazy var stack:UIStackView = {
        let st = UIStackView(arrangedSubviews: [sachbanchayLabel,sachbanchayCollectionView])
        st.axis = .vertical
        st.spacing = 20
        return st
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func layoutSubviews() {
        self.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    init(frame:CGRect,label:String,theloai:Int? = nil){
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.sachbanchayLabel.text = label
        if theloai != nil{
            self.topsellers = BookService.myBooks.book.filter({ (book) -> Bool in
                book.theloai == theloai
            })
        }else{
            self.topsellers = BookService.myBooks.book
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SachBanChay:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topsellers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let book = topsellers[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SachCollectionViewCell
        cell.booksImageView.image = nil
        cell.book = book
        cell.fetchBookImage()
        cell.booksName.text = book.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = topsellers[indexPath.item]
        HomeVC?.showBoolDetail(book: book)
    }
    
}

extension SachBanChay:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(200)
        let width = UIScreen.main.bounds.width / CGFloat(4.5)
        return CGSize(width: width, height: height)
    }
}

