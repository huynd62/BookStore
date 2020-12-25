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



enum cateicon{
    case hot
    case economic
    case comic
    case cntt
    case selfhelp
    case novel
    
    var image:UIImage{
        switch self {
        case .hot:
            return UIImage(systemName: "flame.fill")!
        case .selfhelp:
            return UIImage(systemName: "graduationcap")!
        case .comic:
            return UIImage(systemName: "crown")!
        case .cntt:
            return UIImage(systemName: "desktopcomputer")!
        case .economic:
            return UIImage(systemName: "bitcoinsign.circle")!
        case .novel:
            return UIImage(systemName: "books.vertical")!
    }
    }
}
class SachBanChay:UIView{

    var HomeVC:clickAtBook?
    
    var topsellers : [Book] = []
    
    let cellIdentifier = "sachcvsell"
    
    enum Section {
        case main
    }

    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Book>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Book>
    
    private lazy var dataSource = makeDataSource()

    
    let sachbanchayLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Sách Bán Chạy"
        lb.textAlignment = .left
        lb.font = .boldSystemFont(ofSize: 23.0)
        lb.layer.cornerRadius = 20
        return lb
    }()
    let bookSymbol:UIImageView = {
        let m = UIImageView(frame: .zero)
        m.translatesAutoresizingMaskIntoConstraints = false
//        m.image = UIImage(systemName: "flame.fill")
        m.tintColor = .red
        return m
    }()
    let categoryView:UIView = {
        let v = UIView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
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
//        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    lazy var stack:UIStackView = {
//        let st = UIStackView(arrangedSubviews: [sachbanchayLabel,sachbanchayCollectionView])
        let st = UIStackView(arrangedSubviews: [])
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
        categoryView.addSubview(bookSymbol)
        categoryView.addSubview(sachbanchayLabel)
        stack.addArrangedSubview(categoryView)
        stack.addArrangedSubview(sachbanchayCollectionView)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            bookSymbol.topAnchor.constraint(equalTo: categoryView.topAnchor),
            bookSymbol.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor),
            bookSymbol.bottomAnchor.constraint(equalTo: categoryView.bottomAnchor),
            bookSymbol.widthAnchor.constraint(equalToConstant: 30),
            
            sachbanchayLabel.leadingAnchor.constraint(equalTo: bookSymbol.trailingAnchor,constant: 10),
            sachbanchayLabel.topAnchor.constraint(equalTo: bookSymbol.topAnchor),
            sachbanchayLabel.bottomAnchor.constraint(equalTo: bookSymbol.bottomAnchor),
            sachbanchayLabel.trailingAnchor.constraint(equalTo: categoryView.trailingAnchor),
            
            
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    
    //MARK:- Diffable Data source
    
    func makeDataSource() -> DataSource{
        let dataSource = DataSource(collectionView: sachbanchayCollectionView) { (collectionView, indexPath, book) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! SachCollectionViewCell
            
            cell.booksImageView.image = nil
            cell.book = book
            cell.fetchBookImage()
            cell.booksName.text = book.name
            return cell
        }
        return dataSource
    }
    
    func applySnapshot(animatingDifferences:Bool = true){
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(topsellers)
        dataSource.apply(snapshot,animatingDifferences: animatingDifferences)
    }
    
    init(frame:CGRect,label:String,theloai:Int? = nil,icon:cateicon,iconcolor:UIColor){
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.sachbanchayLabel.text = label
        self.bookSymbol.image = icon.image
        self.bookSymbol.tintColor = iconcolor
        if theloai != 0{
            self.topsellers = BookService.myBooks.book.filter({ (book) -> Bool in
                book.theloai == theloai
            })
        }else{
            self.topsellers = BookService.myBooks.book.filter({ (book) -> Bool in
                book.hotsale == true
            })
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
//        let book = topsellers[indexPath.item]
        guard let book = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
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

