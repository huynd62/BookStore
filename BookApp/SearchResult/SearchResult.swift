//
//  SearchResult.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/23/20.
//

import Foundation
import UIKit


class SearchResult:UIViewController{

    var data:[Book] = [Book]()
    
    var searchTerm:String?
    
    let searchResultLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "KẾT QUẢ TÌM KIẾM CHO"
        return lb
    }()
    
    let cellIdentifier = "searchCell"
    
    let resultTableView :UITableView = {
        let tb = UITableView(frame: .zero)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.showsVerticalScrollIndicator = false
        tb.separatorStyle = .none
        return tb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.isUserInteractionEnabled = true
        resultTableView.register(searchResultCell.self, forCellReuseIdentifier: cellIdentifier)
        resultTableView.dataSource = self
        resultTableView.delegate = self
        
        self.view.addSubview(searchResultLabel)
        self.view.addSubview(resultTableView)
        
        let safeContent = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            searchResultLabel.topAnchor.constraint(equalTo: safeContent.topAnchor,constant: 20),
            searchResultLabel.leadingAnchor.constraint(equalTo: safeContent.leadingAnchor,constant: 10),
            searchResultLabel.heightAnchor.constraint(equalToConstant: 70),
            searchResultLabel.widthAnchor.constraint(equalToConstant:300),
            
            resultTableView.topAnchor.constraint(equalTo: searchResultLabel.bottomAnchor,constant: 50),
            resultTableView.leadingAnchor.constraint(equalTo: safeContent.leadingAnchor,constant: 20),
            resultTableView.trailingAnchor.constraint(equalTo: safeContent.trailingAnchor,constant: -20),
            resultTableView.bottomAnchor.constraint(equalTo: safeContent.bottomAnchor,constant: -20)
            
        ])
    }
    
    init(searchTerm:String){
        super.init(nibName: nil, bundle: nil)
        print("Search is init")
        self.searchTerm = searchTerm
        self.data = BookService.myBooks.book.filter({ (book) -> Bool in
            return book.name.lowercased().contains(searchTerm.lowercased())
        })
    }
    
    deinit {
        print("search is deinit")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class searchResultCell:UITableViewCell {
    
    var book:Book?
    {
        didSet{
            self.imageURL = book?.imageURL
            self.fetchBookImage()
        }
    }
    
    var imageURL:String?
    
    
    let outerView :UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let nameLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = ""
        return lb
    }()
    
    let priceLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = ""
        return lb
    }()
    
    var bookImageView:UIImageView =  {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
    
    override func layoutSubviews() {
        contentView.addSubview(outerView)
        outerView.addSubview(bookImageView)
        bookImageView.addSubview(loaderView)
        outerView.addSubview(priceLabel)
        outerView.addSubview(nameLabel)
        
        let outerViewBottomConstraint = outerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10)
        outerViewBottomConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([

            outerView.topAnchor.constraint(equalTo: contentView.topAnchor ,constant: 10),
            outerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            outerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            outerViewBottomConstraint,
            
            loaderView.topAnchor.constraint(equalTo: bookImageView.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: bookImageView.trailingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: bookImageView.bottomAnchor),
            
            bookImageView.topAnchor.constraint(equalTo: outerView.topAnchor,constant: 5),
            bookImageView.leadingAnchor.constraint(equalTo: outerView.leadingAnchor,constant: 20),
            bookImageView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor,constant: -5),
            bookImageView.heightAnchor.constraint(equalToConstant: 100),
            bookImageView.widthAnchor.constraint(equalToConstant: 60),
            
            
            nameLabel.topAnchor.constraint(equalTo: bookImageView.topAnchor,constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor,constant: 5),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.widthAnchor.constraint(equalToConstant: 300),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 3),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            
        ])
 
    }
    
    func fetchBookImage(){
        if self.book?.coverImage != nil {
            self.loaderView.stopAnimating()
            self.bookImageView.image = self.book?.coverImage
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
                self.bookImageView.image = image
            }
        }else{
            print("not matched")
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SearchResult:UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let book = self.data[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! searchResultCell
        cell.bookImageView.image = nil
        cell.book = book
        cell.nameLabel.text = book.name
        cell.layoutIfNeeded()
        return cell
    }
    
    
    
}

extension SearchResult:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.data[indexPath.item]
        let detailVC = BookDetail(book: book, isSearched: true)
        detailVC.modalPresentationStyle = .automatic
        self.present(detailVC, animated: true, completion: nil)
    }
    
}
