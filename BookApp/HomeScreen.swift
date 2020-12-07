//
//  HomwScreen.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/16/20.
//

import Foundation
import UIKit

class HomeScreenVC:UIViewController,UIGestureRecognizerDelegate{
    
    
    var detailVC:BookDetail?
    let headerView = Header()
    let topBooks = TopBooks()
    var isSellAreaUp : Bool  = false
    var isSearching : Bool = false

    let sellArea = SellArea(frame: .zero)
    

    let tapSellAreaGesture = UITapGestureRecognizer()
    let tapHomeScreen =  UITapGestureRecognizer()
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == tapHomeScreen && touch.view?.isDescendant(of: sellArea) == true{
            return false
        }
        return true
    }

    
    var sellArea1TopAnchor:NSLayoutConstraint?
    var sellArea2TopAnchor:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("we are in home screen")
        let contentLayout = view.safeAreaLayoutGuide
        let color = #colorLiteral(red: 0.9935851693, green: 0.8900092244, blue: 0.7914281487, alpha: 1)
        
        self.view.isUserInteractionEnabled = true
  
        
        headerView.searchBar.delegate = self
        
        tapSellAreaGesture.delegate = self
        tapSellAreaGesture.numberOfTapsRequired = 2
        tapSellAreaGesture.addTarget(self, action: #selector(tapToSellArea))
        self.sellArea.addGestureRecognizer(tapSellAreaGesture)
        
        tapHomeScreen.delegate = self
        tapHomeScreen.numberOfTapsRequired = 1
        tapHomeScreen.addTarget(self, action: #selector(taphome))
        self.view.addGestureRecognizer(tapHomeScreen)

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
        self.headerView.openCartDelegate = self

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
