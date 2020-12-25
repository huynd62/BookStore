//
//  HomwScreen.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/16/20.
//

import Foundation
import UIKit

class HomeScreenVC:UIViewController,UIGestureRecognizerDelegate,BookServiceUpdate{
    
    
    weak var detailVC:BookDetail?
    let headerView = Header()
    let topBooks = TopBooks()
    var isSellAreaUp : Bool  = false
    var isSearching : Bool = false
    var infoViewAdded:Bool?
    var isInfoShown:Bool = false
    let updateView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.alpha = 0.7
        return view
    }()
    let updateSpin:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        view.color = .green
        return view
    }()
    
    let infoView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = #colorLiteral(red: 0.5169081092, green: 0.4013616443, blue: 0.9968962073, alpha: 1)
        let color1 = #colorLiteral(red: 0.9935851693, green: 0.8900092244, blue: 0.7914281487, alpha: 1)
        view.backgroundColor = .clear
        view.alpha = 0.0
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        return view
    }()
    
    
    let usernamelabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = User.theUser.getusername()
        label.font = .boldSystemFont(ofSize: 23.0)
        label.textAlignment = .center
        return label
    }()
    
    let usernameIcon:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "person.fill")
//                view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let logOutButton:UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.attributedTitle(for: .disabled)
        
        button.setTitle("Đăng Xuất", for: .normal)
        button.addTarget(self, action: #selector(logOutClick), for: .touchUpInside)
        
        return button
    }()
    
    
    let sellArea = SellArea(frame: .zero)
    
    
    let tapSellAreaGesture = UITapGestureRecognizer()
    let tapHomeScreen =  UITapGestureRecognizer()
    let swipeUpdate = UISwipeGestureRecognizer()
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == tapHomeScreen && touch.view?.isDescendant(of: sellArea) == true{
            return false
        }
        return true
    }
    
    
    var sellArea1TopAnchor:NSLayoutConstraint?
    var sellArea2TopAnchor:NSLayoutConstraint?
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        BookService.myBooks.updateDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("we are in home screen")
        let contentLayout = view.safeAreaLayoutGuide
        let color = #colorLiteral(red: 0.9935851693, green: 0.8900092244, blue: 0.7914281487, alpha: 1)
        
        
        
        self.view.isUserInteractionEnabled = true
        BookService.myBooks.updateDelegate = self
        
        headerView.searchBar.delegate = self
        
        tapSellAreaGesture.delegate = self
        tapSellAreaGesture.numberOfTapsRequired = 2
        tapSellAreaGesture.addTarget(self, action: #selector(tapToSellArea))
        self.sellArea.addGestureRecognizer(tapSellAreaGesture)
        
        tapHomeScreen.delegate = self
        tapHomeScreen.numberOfTapsRequired = 1
        tapHomeScreen.addTarget(self, action: #selector(taphome))
        self.view.addGestureRecognizer(tapHomeScreen)
        
        
        swipeUpdate.delegate = self
        swipeUpdate.direction = .down
        swipeUpdate.numberOfTouchesRequired = 1
        swipeUpdate.addTarget(self, action: #selector(update))
        self.view.addGestureRecognizer(swipeUpdate)
        
        sellArea1TopAnchor = sellArea.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 20)
        sellArea2TopAnchor = sellArea.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 300)
        sellArea1TopAnchor?.priority = UILayoutPriority(999)
        sellArea2TopAnchor?.priority = UILayoutPriority(998)
        
        view.backgroundColor = color
        
        
        //            UIColor(red: 22.0/225.0, green: 160.0/225.0, blue: 133.0/225.0, alpha: 1.0)
        view.addSubview(headerView)
        view.addSubview(topBooks)
        view.addSubview(sellArea)
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: contentLayout.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentLayout.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.searchBar.topAnchor.constraint(equalTo: contentLayout.topAnchor,constant: 20),
            
            topBooks.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 30),
            topBooks.leadingAnchor.constraint(equalTo: contentLayout.leadingAnchor),
            topBooks.trailingAnchor.constraint(equalTo: contentLayout.trailingAnchor),
            topBooks.heightAnchor.constraint(equalToConstant: 200),
            
            sellArea2TopAnchor!,
            //            sellArea.topAnchor.constraint(equalTo: topBooks.bottomAnchor,constant: 20),
            sellArea.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            sellArea.leadingAnchor.constraint(equalTo: contentLayout.leadingAnchor,constant: 5),
            sellArea.trailingAnchor.constraint(equalTo: contentLayout.trailingAnchor,constant: -5)
        ])
        
        self.sellArea.comicBooks.HomeVC = self
        self.sellArea.selfhelpBooks.HomeVC = self
        self.sellArea.sachbanchay.HomeVC = self
        self.sellArea.novelBooks.HomeVC = self
        self.sellArea.economicBooks.HomeVC = self
        self.sellArea.itBooks.HomeVC = self
        self.headerView.openCartDelegate = self
        self.headerView.openprofileDelegate = self
        
    }
    
    //MARK:- Gesture Functions
    @objc func tapToSellArea(){
        self.isSellAreaUp.toggle()
        if self.isSellAreaUp == true {
            self.sellArea1TopAnchor?.priority = UILayoutPriority(999)
            self.sellArea1TopAnchor?.isActive = true
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                self.topBooks.alpha = 0
                //                self.sellArea.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }else{
            self.sellArea1TopAnchor?.priority = UILayoutPriority(997)
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                self.topBooks.alpha = 1
                //                self.sellArea.transform = CGAffineTransform(scaleX: 1.0, y: 2.0/3.0 )
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func taphome(){
        if self.isSearching == true {
            self.isSearching.toggle()
            self.headerView.searchBar.text = ""
            self.headerView.searchBar.endEditing(true)
        }
    }
    
    
    
    @objc func update(){
        print("hoho i can swipe")
        self.updateView.alpha = 1.0
        DispatchQueue.main.async {
            self.view.addSubview(self.updateView)
            self.updateView.addSubview(self.updateSpin)
            NSLayoutConstraint.activate([
                self.updateView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
                self.updateView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                self.updateView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                self.updateView.heightAnchor.constraint(equalToConstant: 30),
                
                
                self.updateSpin.topAnchor.constraint(equalTo: self.updateView.topAnchor),
                self.updateSpin.bottomAnchor.constraint(equalTo: self.updateView.bottomAnchor),
                self.updateSpin.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.updateSpin.widthAnchor.constraint(equalToConstant: 30)
            ])
        }
        print("We are upating the source . Please wait")
        BookService.myBooks.updateBooks()
        
    }
    
    func bookIsUpdated(){
        
        
        print("we update the books. Let's chill")
        
        self.sellArea.comicBooks.topsellers = BookService.myBooks.book.filter({ (book) -> Bool in
            book.theloai == 1
        })
        self.sellArea.sachbanchay.topsellers = BookService.myBooks.book.filter({ (book) -> Bool in
            book.hotsale == true
        })
        self.sellArea.novelBooks.topsellers = BookService.myBooks.book.filter({ (book) -> Bool in
            book.theloai == 4
        })
        self.sellArea.selfhelpBooks.topsellers = BookService.myBooks.book.filter({ (book) -> Bool in
            book.theloai == 2
        })
        self.sellArea.economicBooks.topsellers = BookService.myBooks.book.filter({ (book) -> Bool in
            book.theloai == 5
        })
        self.sellArea.itBooks.topsellers = BookService.myBooks.book.filter({ (book) -> Bool in
            book.theloai == 3
        })
        
        
        DispatchQueue.main.async {
            self.sellArea.comicBooks.applySnapshot(animatingDifferences: true)
            self.sellArea.sachbanchay.applySnapshot(animatingDifferences: true)
            self.sellArea.selfhelpBooks.applySnapshot(animatingDifferences: true)
            self.sellArea.novelBooks.applySnapshot(animatingDifferences: true)
            self.sellArea.economicBooks.applySnapshot(animatingDifferences: true)
            self.sellArea.itBooks.applySnapshot(animatingDifferences: true)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 1.5) {
                self.updateView.alpha = 0.0
            }
        }
        DispatchQueue.main.async {
            self.updateView.removeFromSuperview()
        }
        
    }
    
    func noUpdateAvailable() {
        print("There is no book to update.It's OK. Don't worry")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("This is not good , you are inside the main Async")
            UIView.animate(withDuration: 1.5) {
                self.updateView.alpha = 0.0
            }
        }
        DispatchQueue.main.async {
            self.updateView.removeFromSuperview()
        }
    }
    
}
//MARK:- ShowBookDetailDelegate
extension HomeScreenVC:clickAtBook{
    func showBoolDetail(book: Book) {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }
            
            let detailVC = BookDetail(book: book)
            self.present(detailVC, animated: true)
        }
    }
    
}
extension HomeScreenVC:openCartVC{
    
    func opentheCartVC() {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else {return}
            
            let cartVC = CartViewController()
            let navigationVC = UINavigationController(rootViewController: cartVC)
            navigationVC.modalPresentationStyle = .fullScreen
            let appearance = UINavigationBarAppearance()
            appearance.shadowColor = nil
            appearance.shadowImage = nil
            appearance.backgroundColor = .white
            navigationVC.navigationBar.standardAppearance = appearance
            self.present(navigationVC, animated: true, completion: nil)
            
        }
    }
    
}

extension HomeScreenVC:profileDelegate{
    
    @objc func logOutClick(){
        print("log out clicked")
        
        let alert = UIAlertController(title: "Thông Báo", message: "Bạn có muốn đăng xuất ?", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Có", style: .default, handler:{_ in
            
            User.theUser.setid(id: -1)
            User.theUser.setusername(username: "")
            
            UserDefaults.standard.set(false, forKey: "isLogedIn")
            UserDefaults.standard.set("", forKey: "username")
            UserDefaults.standard.set(-1,forKey: "userid")
            
            
//            self.dismiss(animated: true, completion: nil)
            
            self.openProfile()
            self.usernamelabel.text = ""
            Cart.theCart.clearTheCart()
            DispatchQueue.main.async {
                let newlogin = ViewController()
                newlogin.modalPresentationStyle = .fullScreen
                self.navigationController?.addChild(newlogin)
                self.present(newlogin, animated: true, completion: nil)
            }

        } )
        let action2 = UIAlertAction(title: "Không", style: .default, handler: nil)
        alert.addAction(action2)
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openProfile() {
        print("say oh yeah")
        
        usernamelabel.text = User.theUser.getusername()
        
        DispatchQueue.main.async {
            

            self.view.addSubview(self.infoView)
            self.infoView.addSubview(self.usernameIcon)
            self.infoView.addSubview(self.logOutButton)
            self.infoView.addSubview(self.usernamelabel)
            NSLayoutConstraint.activate([
                self.infoView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
                self.infoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.infoView.widthAnchor.constraint(equalToConstant: 200),
                self.infoView.heightAnchor.constraint(equalToConstant: 200),
                
                
                self.usernameIcon.topAnchor.constraint(equalTo: self.infoView.topAnchor,constant: 20),
                self.usernameIcon.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor,constant: 75),
                self.usernameIcon.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor,constant: -75),
                self.usernameIcon.heightAnchor.constraint(equalToConstant: 50),
                
                
                self.usernamelabel.topAnchor.constraint(equalTo: self.usernameIcon.bottomAnchor),
                self.usernamelabel.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor),
                self.usernamelabel.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor),
                self.usernamelabel.heightAnchor.constraint(equalToConstant: 50),
                
                
                self.logOutButton.topAnchor.constraint(equalTo: self.usernamelabel.bottomAnchor,constant: 20),
                self.logOutButton.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor,constant: 25),
                self.logOutButton.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor,constant: -25),
                self.logOutButton.heightAnchor.constraint(equalToConstant: 30),
                
                
            ])
            
        }
        
        if self.isInfoShown == false{
            DispatchQueue.main.async {
                self.infoView.center.x += self.view.bounds.width
                UIView.animate(withDuration: 0.5) {
                    self.infoView.alpha = 0.9
                    //                    NSLayoutConstraint.activate([
                    //                        self.infoView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
                    //                        self.infoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    //                        self.infoView.widthAnchor.constraint(equalToConstant: 200),
                    //                        self.infoView.heightAnchor.constraint(equalToConstant: 200)
                    //                    ])
                    self.topBooks.alpha = 0.0
                    self.infoView.center.x -= self.view.bounds.width
//                    self.view.mask = UIView(frame: self.view.frame)
//                    self.view.mask?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//                    self.infoView.mask = UIView(frame: self.infoView.frame)
//                    self.infoView.mask?.backgroundColor = .black
                }
            }
            self.isInfoShown.toggle()
        }else{
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5) {
                    self.infoView.alpha = 0.0
                    self.topBooks.alpha = 1.0
                    //                    self.infoView.center.x += self.view.bounds.width
                    //                    self.infoView.center.x -= self.view.bounds.width
                    
                }
                
            }
            self.isInfoShown.toggle()
        }
    }
    
    
}

extension HomeScreenVC:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchView = SearchResult(searchTerm: searchBar.text!)
        searchView.modalPresentationStyle = .automatic
        searchBar.endEditing(true)
        searchBar.text = ""
        self.present(searchView, animated: true, completion: nil)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text! == "" || searchText.count == 0{
            searchBar.endEditing(true)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearching = true
    }
    
}
