//
//  SellArea.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/20/20.
//

import Foundation
import UIKit

class SellArea:UIView{

    let sachbanchay = SachBanChay(frame: .zero, label: "Sách Bán Chạy", theloai: nil)
    let comicBooks = SachBanChay(frame: .zero,label: "Truyện Tranh",theloai: 1)
    let selfhelpBooks = SachBanChay(frame: .zero,label: "Self-Help",theloai: 2)
    let novelBooks = SachBanChay(frame: .zero,label: "Tiểu Thuyết",theloai: 4)
    
    
    let uiblock : UIView = {
        let block = UIView(frame: .zero)
        block.translatesAutoresizingMaskIntoConstraints = false
        block.backgroundColor = .systemPink
        return block
    }()
    
    
    let mainScrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.layer.cornerRadius = 20
        sv.showsVerticalScrollIndicator = false
        sv.isScrollEnabled = true
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        
    }
    
    override func layoutSubviews() {
        self.addSubview(mainScrollView)
        mainScrollView.contentSize = CGSize(width: self.frame.width, height: CGFloat(1500))
        mainScrollView.addSubview(sachbanchay)
        mainScrollView.addSubview(selfhelpBooks)
        mainScrollView.addSubview(comicBooks)
        mainScrollView.addSubview(novelBooks)
//        mainScrollView.addSubview(namelable)
//        mainScrollView.addSubview(uiblock)
        let scrollFrame = mainScrollView.frameLayoutGuide
        let scrollContentView = mainScrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            
            scrollFrame.topAnchor.constraint(equalTo: self.topAnchor),
            scrollFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollFrame.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollFrame.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            sachbanchay.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            sachbanchay.topAnchor.constraint(equalTo: scrollContentView.topAnchor,constant: 20),
            sachbanchay.trailingAnchor.constraint(equalTo: scrollFrame.trailingAnchor,constant : -10),
            sachbanchay.heightAnchor.constraint(equalToConstant: 250),
            
            
            selfhelpBooks.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            selfhelpBooks.topAnchor.constraint(equalTo: sachbanchay.bottomAnchor,constant: 30),
            selfhelpBooks.trailingAnchor.constraint(equalTo: scrollFrame.trailingAnchor,constant : -10),
            selfhelpBooks.heightAnchor.constraint(equalToConstant: 250),
            
            comicBooks.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            comicBooks.topAnchor.constraint(equalTo: selfhelpBooks.bottomAnchor,constant: 30),
            comicBooks.trailingAnchor.constraint(equalTo: scrollFrame.trailingAnchor,constant : -10),
            comicBooks.heightAnchor.constraint(equalToConstant: 250),
            
            novelBooks.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            novelBooks.topAnchor.constraint(equalTo: comicBooks.bottomAnchor,constant: 30),
            novelBooks.trailingAnchor.constraint(equalTo: scrollFrame.trailingAnchor,constant : -10),
            novelBooks.heightAnchor.constraint(equalToConstant: 250),
 
        
            
//            namelable.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 100),
//            namelable.topAnchor.constraint(equalTo: sachbanchay.bottomAnchor,constant: 100),
//
//
//            uiblock.widthAnchor.constraint(equalToConstant: 200),
//            uiblock.heightAnchor.constraint(equalTo: uiblock.widthAnchor),
//            uiblock.topAnchor.constraint(equalTo: namelable.bottomAnchor, constant: 50),
//            uiblock.leadingAnchor.constraint(equalTo: namelable.leadingAnchor)
            
            
            
        ])
    }
    
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}


