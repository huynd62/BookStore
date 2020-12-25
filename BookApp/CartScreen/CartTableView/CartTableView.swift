//
//  CartTableView.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/22/20.
//

import Foundation
import UIKit


protocol totalChangedDelegate:class{
    func reCalculateTotal()
}
class CartTableView:UITableViewController{
    
    let cellIdentifier = "cartCell"
    var cart = Cart.theCart.getBooksArray()
    weak var totalChangeDelegate:totalChangedDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CartCell.self, forCellReuseIdentifier: cellIdentifier)

    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cart = Cart.theCart.getBooksArray()
        return cart.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let book = cart[indexPath.item]
        var totalPrice:Int = 0
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CartCell
        cell.isUserInteractionEnabled = true
        cell.bookImageView.image = book.coverImage
        cell.nameLabel.text = book.name
        cell.priceLabel.text = "ĐG: " + String(book.price)
        if Cart.theCart.cartDict[book] != nil{
            cell.soluongLabel.text = "SL: " + String(Cart.theCart.cartDict[book]!)
            cell.stepper.value = Double(Cart.theCart.cartDict[book]!)
            cell.stepper.tag = indexPath.item
            cell.stepper.addTarget(self, action: #selector(hello), for: .valueChanged)
            totalPrice = book.price * Cart.theCart.cartDict[book]!
        }else{
            cell.soluongLabel.text = "Có Lỗi Xẩy Ra"
        }
        cell.totalLabel.text = String(totalPrice)
        cell.layoutIfNeeded()
        return cell
    }
    
    @objc func hello(sender:UIStepper){
        if sender.value == 0.0{
            Cart.theCart.cartDict[self.cart[sender.tag]] = nil
        }else{
            Cart.theCart.cartDict[self.cart[sender.tag]] = Int(sender.value)
        }
        print("-----Your Cart ---------")
        for book in Cart.theCart.cartDict.keys{
            if Cart.theCart.cartDict[book] != nil{
                print("\(book.name) : \(Cart.theCart.cartDict[book]!)")
            }
        }
        print("--------------------------")
        self.totalChangeDelegate?.reCalculateTotal()
        tableView.reloadData()
    }

    init(){
        super.init(nibName: nil, bundle: nil)
        self.tableView.isUserInteractionEnabled = true
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 210
        tableView.showsVerticalScrollIndicator = false
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}




