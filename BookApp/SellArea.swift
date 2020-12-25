//
//  SellArea.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/20/20.
//

import Foundation
import UIKit

class SellArea:UIView{

    let sachbanchay = SachBanChay(frame: .zero, label: "Sách Bán Chạy", theloai: 0,icon: .hot,iconcolor: .red)
    let comicBooks = SachBanChay(frame: .zero,label: "Truyện Tranh",theloai: 1,icon: .comic,iconcolor: .red)
    let selfhelpBooks = SachBanChay(frame: .zero,label: "Self-Help",theloai: 2,icon: .selfhelp,iconcolor: .red)
    let novelBooks = SachBanChay(frame: .zero,label: "Tiểu Thuyết",theloai: 4,icon: .novel,iconcolor: .red)
    let itBooks = SachBanChay(frame: .zero,label: "Công Nghệ Thông Tin",theloai: 3,icon: .cntt,iconcolor: .red)
    let economicBooks = SachBanChay(frame: .zero,label: "Kinh Tế - Chính Trị",theloai: 5,icon: .economic,iconcolor: .red)
    
    
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
        mainScrollView.contentSize = CGSize(width: self.frame.width, height: CGFloat(1700))
        mainScrollView.addSubview(sachbanchay)
        mainScrollView.addSubview(selfhelpBooks)
        mainScrollView.addSubview(comicBooks)
        mainScrollView.addSubview(novelBooks)
        mainScrollView.addSubview(economicBooks)
        mainScrollView.addSubview(itBooks)
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
            
            economicBooks.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            economicBooks.topAnchor.constraint(equalTo: novelBooks.bottomAnchor,constant: 30),
            economicBooks.trailingAnchor.constraint(equalTo: scrollFrame.trailingAnchor,constant : -10),
            economicBooks.heightAnchor.constraint(equalToConstant: 250),
            
            
            itBooks.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            itBooks.topAnchor.constraint(equalTo: economicBooks.bottomAnchor,constant: 30),
            itBooks.trailingAnchor.constraint(equalTo: scrollFrame.trailingAnchor,constant : -10),
            itBooks.heightAnchor.constraint(equalToConstant: 250),
            
            
            
            
            
 
        
            
//            namelable.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 100),
//            namelable.topAnchor.constraint(equalTo: sachbanchay.bottomAnchor,constant: 100),
//
//
//            uiblock.widthAnchor.constraint(equalToConstant: 200),
//            uiblock.heightAnchor.constraint(equalTo: uiblock.widthAnchor),
//            uiblock.topAnchor.constraint(equalTo: namelable.bottomAnchor, constant: 50),
//            uiblock.leadingAnchor.constraint(equalTo: namelable.leadingAnchor)
            
            
            
        ])
        sachbanchay.applySnapshot(animatingDifferences: false)
        selfhelpBooks.applySnapshot(animatingDifferences: false)
        comicBooks.applySnapshot(animatingDifferences: false)
        novelBooks.applySnapshot(animatingDifferences: false)
        economicBooks.applySnapshot(animatingDifferences: false)
        itBooks.applySnapshot(animatingDifferences: false)
        
    }
    
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}


