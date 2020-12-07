//
//  SachCollectionViewCell.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/21/20.
//

import UIKit

class SachCollectionViewCell: UICollectionViewCell {
    
    var book:Book?
    {
        didSet{
            self.imageURL = book?.imageURL
        }
    }
    
    var imageURL:String?
    
    var booksImageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    let loaderView:UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(frame: .zero)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.backgroundColor = .clear
        loader.layer.cornerRadius = 10
        loader.color = .blue
        loader.startAnimating()
        return loader
    }()
    
    var booksName:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(booksImageView)
        contentView.addSubview(booksName)
        contentView.backgroundColor = .clear
        booksImageView.addSubview(loaderView)
        
        NSLayoutConstraint.activate([
            
            booksImageView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 5),
            booksImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            booksImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            booksImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -70),
            
            booksName.topAnchor.constraint(equalTo: booksImageView.bottomAnchor,constant: 5),
            booksName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            booksName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            booksName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            loaderView.topAnchor.constraint(equalTo: booksImageView.topAnchor),
            loaderView.bottomAnchor.constraint(equalTo: booksImageView.bottomAnchor),
            loaderView.leadingAnchor.constraint(equalTo: booksImageView.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: booksImageView.trailingAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func fetchBookImage(){
        if self.book?.coverImage != nil {
            self.loaderView.stopAnimating()
            self.booksImageView.image = self.book?.coverImage
        }else{
            self.loaderView.startAnimating()
            let temp = self.imageURL
            let task = URLSession(configuration: .default).dataTask(with: URL(string: self.book!.imageURL)!) { (data, response, error) in
                let backURL = temp
                if error != nil{
                    print("there was an error here")
                }else{
                    if let safeData = data {
                        DispatchQueue.main.async {
                            self.checkAndRender(backURL: backURL,image: UIImage(data: safeData))
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func checkAndRender(backURL:String?,image:UIImage?){
        if backURL! == self.imageURL!{
            DispatchQueue.main.async {
                self.loaderView.stopAnimating()
                self.book?.coverImage = image
                self.booksImageView.image = image
            }
        }else{
            print("not matched")
        }
    }
    
    func getTheBookToTest()->Book{
        return self.book!
    }
    
    func getTheURLToTest()->String?{
        return self.imageURL
    }
}
