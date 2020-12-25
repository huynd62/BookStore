//
//  BookDetail.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/21/20.
//

import Foundation
import UIKit




class BookDetail:UIViewController{
    
    weak var book:Book?
    var soluong:Int = 0
    weak var cart = Cart.theCart
    var isSearched:Bool? = nil
    var recommendDataSource = [Book]()
    var isRecommended:Bool? = nil
    //MARK:- Detail
    
    let authorLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.sizeToFit()
        lb.text = "Tác Giả : "
        return lb
    }()
    
    let priceLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.sizeToFit()
        lb.text = "Giá : "
        return lb
    }()
    
    let publisher:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.sizeToFit()
        lb.text = "Nhà Xuất Bản : "
        return lb
    }()
    
    let theloai:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.sizeToFit()
        lb.text = "Thể Loại: "
        return lb
    }()
    
    let bookDescription :UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Mô tả : "
        lb.sizeToFit()
        lb.numberOfLines = 0
        return lb
    }()
    
    let stack:UIStackView = {
        let st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        st.distribution = .fill
        st.backgroundColor = .lightText
        st.layer.cornerRadius = 10
        return st
    }()
    
    //MARK:- Book's name Label
    
    let booksNameLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    
    //MARK:- Book's Image
    var makeOuterView:(CGRect)->UIView = {
        frame in
        let view = UIView(frame: frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }
    
    var outerBookImageView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10).cgPath
        view.backgroundColor = .clear
        return view
    }()
    
    var bookImageView:UIImageView = {
        let bookImageView = UIImageView(frame: .zero)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.clipsToBounds = true
        bookImageView.layer.cornerRadius = 10
        bookImageView.backgroundColor = .clear
        return bookImageView
    }()
    
    //MARK:- Cart Buttons , fucntions
    
    let addCartButton:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        btn.setTitle("Thêm Vào Giỏ Hàng", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    @objc func stepperChangedValue(){
        stepperLabel.text = String(Int(stepper.value))
        self.soluong = Int(stepper.value)
    }
    
    let stepper:UIStepper = {
        let sp = UIStepper(frame: .zero)
        sp.translatesAutoresizingMaskIntoConstraints = false
        sp.value = 0.0
        sp.minimumValue = 0
        sp.maximumValue = 100
        sp.autorepeat = true
        sp.addTarget(self, action: #selector(stepperChangedValue), for: .valueChanged)
        return sp
    }()
    
    let stepperLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = ""
        lb.textAlignment = .center
        lb.numberOfLines = 1
        return lb
    }()
    
    let stepperView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addToCartButtonView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cartStack:UIStackView = {
        let st = UIStackView(frame: .zero)
        st.translatesAutoresizingMaskIntoConstraints = false
        st.isUserInteractionEnabled = true
        st.axis = .horizontal
        st.distribution = .fillEqually
        return st
    }()
    
    @objc func addToCart(){
        if self.soluong != 0 {
            self.cart!.addToMyCart(book: book!, soluong: self.soluong)
            
            let alert = UIAlertController(title: "Thông Báo", message: "Đã Thêm Mặt Hàng Này Vào Giỏ", preferredStyle: .alert)
            
            //            let imageCorrect = UIImageView(frame: .zero)
            //            imageCorrect.translatesAutoresizingMaskIntoConstraints = false
            //            imageCorrect.image = UIImage(named: "correct")
            //            imageCorrect.backgroundColor = .clear
            //            alert.view.addSubview(imageCorrect)
            //            let h = imageCorrect.heightAnchor.constraint(equalToConstant: 50)
            //            let w = imageCorrect.widthAnchor.constraint(equalTo: imageCorrect.heightAnchor)
            
            //            alert.view.addConstraint(h)
            //            alert.view.addConstraint(w)
            
            alert.addAction(UIAlertAction(title: "Xác Nhận", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK:- Decor section
    let itemView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40
        view.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.2862745098, blue: 0.368627451, alpha: 1)
        return view
    }()
    
    //MARK:- Recommendation Books
    let recommendStack :UIStackView = {
        let st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        st.alignment = .leading
        st.distribution = .fill
        st.alpha = 0
        st.spacing = 0
        return st
    }()
    
    let recommedLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Độc Giả Khác Cũng Quan Tâm"
        lb.font = .boldSystemFont(ofSize: 10)
        lb.alpha = 0
        return lb
    }()
    
    private lazy var flowLayout:UICollectionViewFlowLayout = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        fl.minimumLineSpacing = 0
        return fl
    }()
    let recommendcell = "recommendCell"
    let recommendcontainer:UIView = {
        let v = UIView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alpha = 0
        return v
    }()
    private lazy var recommendCV:UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SachCollectionViewCell.self, forCellWithReuseIdentifier: recommendcell)
        cv.backgroundColor  = .clear
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceHorizontal = false
//        cv.layer.cornerRadius = 20
        cv.alpha = 0
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var beforeRecommend:NSLayoutConstraint?
    var afterRecommend:NSLayoutConstraint?
    
    //MARK:- Layout Subviews
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(itemView)
        self.view.addSubview(outerBookImageView)
        outerBookImageView.addSubview(bookImageView)
        self.view.addSubview(booksNameLabel)
        
        self.view.addSubview(stack)
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(authorLabel)
        stack.addArrangedSubview(publisher)
        stack.addArrangedSubview(theloai)
        stack.addArrangedSubview(bookDescription)
        
        
        self.view.addSubview(cartStack)
        cartStack.addArrangedSubview(stepperView)
        cartStack.addArrangedSubview(addToCartButtonView)
        stepperView.addSubview(stepperLabel)
        stepperView.addSubview(stepper)
        addToCartButtonView.addSubview(addCartButton)
        
        
        
        beforeRecommend = outerBookImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -150)
        beforeRecommend?.priority = UILayoutPriority(998)
        
        afterRecommend = outerBookImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -255)
        afterRecommend?.priority = UILayoutPriority(999)
        
        self.view.addSubview(self.recommendCV)
        self.view.addSubview(self.recommedLabel)
        
        
        //        recommendcontainer.addSubview(recommendCV)
        //        recommendStack.addArrangedSubview(recommedLabel)
        //        recommendStack.addArrangedSubview(recommendcontainer)
        
        
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: -200),
            itemView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            itemView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            itemView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -500),
            
            outerBookImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //            outerBookImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -150),
            beforeRecommend!,
            outerBookImageView.heightAnchor.constraint(equalToConstant: 300),
            outerBookImageView.widthAnchor.constraint(equalToConstant: 200),
            
            bookImageView.topAnchor.constraint(equalTo: outerBookImageView.topAnchor),
            bookImageView.bottomAnchor.constraint(equalTo: outerBookImageView.bottomAnchor),
            bookImageView.leadingAnchor.constraint(equalTo: outerBookImageView.leadingAnchor),
            bookImageView.trailingAnchor.constraint(equalTo: outerBookImageView.trailingAnchor),
            
            
            booksNameLabel.topAnchor.constraint(equalTo: outerBookImageView.bottomAnchor,constant: 20),
            booksNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            booksNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            booksNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            stack.topAnchor.constraint(equalTo: booksNameLabel.bottomAnchor,constant: 10),
            stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10),
            stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -10),
            stack.heightAnchor.constraint(equalToConstant: 150),
            
            
            cartStack.topAnchor.constraint(equalTo: stack.bottomAnchor,constant: 10),
            cartStack.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            cartStack.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            cartStack.heightAnchor.constraint(equalToConstant: 100),
            
            
            stepperLabel.topAnchor.constraint(equalTo: stepperView.topAnchor,constant: 5),
            stepperLabel.leadingAnchor.constraint(equalTo: stepperView.leadingAnchor,constant: 5),
            stepperLabel.trailingAnchor.constraint(equalTo: stepperView.trailingAnchor,constant: -5),
            stepperLabel.heightAnchor.constraint(equalToConstant: 50),
            
            stepper.topAnchor.constraint(equalTo: stepperLabel.bottomAnchor,constant: 5),
            stepper.centerXAnchor.constraint(equalTo: stepperView.centerXAnchor),
            
            addCartButton.centerXAnchor.constraint(equalTo: addToCartButtonView.centerXAnchor),
            addCartButton.centerYAnchor.constraint(equalTo: addToCartButtonView.centerYAnchor),
            addCartButton.leadingAnchor.constraint(equalTo: addToCartButtonView.leadingAnchor,constant: 10),
            addCartButton.trailingAnchor.constraint(equalTo: addToCartButtonView.trailingAnchor,constant: -10),
            addCartButton.topAnchor.constraint(equalTo: addToCartButtonView.topAnchor,constant: 20),
            addCartButton.bottomAnchor.constraint(equalTo: addToCartButtonView.bottomAnchor,constant: -20)
            
        ])
    }
    
    //MARK:- Initializer
    func clickrating(isSearched:Bool){
        let id = User.theUser.getid()
        let idbook = self.book!.id
        var para:[String:Any]
        
        if isSearched == true{
            para = [
                "id":id,
                "isSearched":"yes",
                "idbook":idbook
            ]
        }else{
            para = [
                "id":id,
                "isSearched":"no",
                "idbook":idbook
            ]
        }
        var request = URLRequest(url: URL(string: K.clickrateAPI)!)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: para, options: []) else {return}
        request.httpBody = httpBody
        //        request.timeoutInterval = 20
        let task = URLSession(configuration: .default).dataTask(with: request) {
            (data, response, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
        task.resume()
        
    }
    func recommend(){
        let idbook = self.book!.id
        let para:[String:Any] = [
            "id_book":idbook
        ]
        var request = URLRequest(url: URL(string: K.recommendAPI)!)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: para, options: []) else {return}
        request.httpBody = httpBody
        //        request.timeoutInterval = 20
        let task = URLSession(configuration: .default).dataTask(with: request) {
            [weak self]
            (data, response, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            if (response as! HTTPURLResponse).statusCode == 201{
                if let safedata = data{
                    let decoder = JSONDecoder()
                    let message = try! decoder.decode(RecommendMessage.self, from: safedata)
                    if let self = self{
                        self.recommendDataSource = BookService.myBooks.book.filter({ (book) -> Bool in
                            print("Here we are book id = \(book.id)")
                            return message.message.contains(book.id)
                        })
                        
                        DispatchQueue.main.async {
                            print(message.message)
                            
                            
                            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                                
                                self.afterRecommend?.isActive = true
                                
                                //                                self.view.addSubview(self.recommendCV)
                                //                                self.view.addSubview(self.recommedLabel)
                                
                                //                                NSLayoutConstraint.activate([
                                //
                                //                                    self.recommedLabel.topAnchor.constraint(equalTo: self.cartStack.bottomAnchor ,constant: 5),
                                //                                    self.recommedLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 15),
                                //                                    self.recommedLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                //                                    self.recommedLabel.heightAnchor.constraint(equalToConstant: 20),
                                //
                                //
                                //
                                //                                    self.recommendCV.topAnchor.constraint(equalTo: self.recommedLabel.bottomAnchor ,constant: 5),
                                //                                    self.recommendCV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 15),
                                //                                    self.recommendCV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                //                                    self.recommendCV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                //
                                //                                ])
                                
                                
                                UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseInOut, animations: {
                                    self.recommendStack.alpha = 1
                                    self.recommedLabel.alpha = 1
                                    self.recommendCV.alpha = 1
                                }, completion: nil)
                                self.view.layoutIfNeeded()
                            }, completion: nil)
                            
                            NSLayoutConstraint.activate([
                                
                                self.recommedLabel.topAnchor.constraint(equalTo: self.cartStack.bottomAnchor ,constant: 5),
                                self.recommedLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 15),
                                self.recommedLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                self.recommedLabel.heightAnchor.constraint(equalToConstant: 20),
                                
                                
                                
                                self.recommendCV.topAnchor.constraint(equalTo: self.recommedLabel.bottomAnchor ,constant: 0),
                                self.recommendCV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 15),
                                self.recommendCV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                self.recommendCV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                
                            ])
                            self.recommendCV.reloadData()
                            
                        }
                        
                        
                        
                    }
                    
                }
            }
            
            if (response as! HTTPURLResponse).statusCode == 203{
                //                if let safedata = data{
                //                    let decoder = JSONDecoder()
                //                    let message = try! decoder.decode(Message.self, from: safedata)
                //                    DispatchQueue.main.async {
                //                        let alert = UIAlertController(title: "Thông Báo", message: message.message, preferredStyle: .alert)
                //                        alert.addAction(UIAlertAction(title: "Xác Nhận", style: .destructive, handler: nil))
                //                        if let self = self{
                //                            self.present(alert, animated: true, completion: nil)
                //                        }
                //                    }
                //                }
            }
        }
        task.resume()
        
        
    }
    
    
    init(book:Book,isSearched:Bool = false,isRecommended:Bool = false){
        super.init(nibName: nil, bundle: nil)
        self.book = book
        self.isSearched = isSearched
        self.isRecommended = isRecommended
        if self.isRecommended == false{
            self.recommend()
        }
        outerBookImageView = makeOuterView(.zero)
        bookImageView.image = book.coverImage
        booksNameLabel.text = book.name
        authorLabel.text! += book.tacgia
        bookDescription.text! += book.mota
        publisher.text! += book.nhaxuatban1
        theloai.text! += book.category
        priceLabel.text! += String(book.price) + " VND"
        stepperLabel.text = String(Int(stepper.value))
        
        print("the Book Detail is init")
        
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("the BookDetail is deallocated")
    }
}

extension BookDetail:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("hoho = \(recommendDataSource.count)")
        return recommendDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let book = recommendDataSource[indexPath.item]
        print("aha")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendcell, for: indexPath) as! SachCollectionViewCell
        cell.alpha = 0
        cell.booksImageView.image = nil
        cell.booksImageView.layer.cornerRadius = 5
        cell.book = book
        cell.fetchBookImage()
        cell.booksName.text = book.name
        cell.booksName.numberOfLines = 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = self.recommendDataSource[indexPath.item]
        let detailVC = BookDetail(book: book, isSearched: false,isRecommended: true)
        detailVC.modalPresentationStyle = .automatic
        self.present(detailVC, animated: true, completion: nil)
    }
    
}

extension BookDetail:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(165)
        let width = UIScreen.main.bounds.width / CGFloat(5.0)
        return CGSize(width: width, height: height)
    }
}


