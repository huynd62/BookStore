//
//  CartViewController.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/22/20.
//

import Foundation
import UIKit

class CartViewController:UIViewController{
    
    
    
    let cartTableView = CartTableView()
    
    let totalView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGroupedBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    let thanhtienLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "THÀNH TIỀN "
        return lb
    }()
    
    
    let dathangButton:UIButton = {
        let bt = UIButton(frame: .zero)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(dathang), for: .touchUpInside)
        bt.setTitle("ĐẶT HÀNG", for: .normal)
        bt.backgroundColor = .blue
        bt.layer.cornerRadius = 20
        return bt
    }()
    
    @objc func dathang(){
        
        if Int(moneyLabel.text!) == 0{
            let alert = UIAlertController(title: "Thông Báo", message: "Mời Bạn Đặt Mặt Hàng Vào Giỏ", preferredStyle: .alert)
            let action = UIAlertAction(title: "Xác Nhận", style: .destructive, handler: nil )
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let id = User.theUser.getid()
        let cart_info = Cart.theCart.getBookJSON()
        let total = moneyLabel.text!
        
        let para:[String:Any] = [
            "id":id,
            "cart_info":cart_info,
            "total":total
        ]
        
        var request = URLRequest(url: URL(string: K.orderAPI)!)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: para, options: []) else {return}
        request.httpBody = httpBody
        request.timeoutInterval = 20
        
        let task = URLSession(configuration: .default).dataTask(with: request) {
            [weak self]
            (data, response, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                if (response as! HTTPURLResponse).statusCode == 201{
                    if let safedata = data{
                        let decoder = JSONDecoder()
                        let message = try! decoder.decode(Message.self, from: safedata)
                        Cart.theCart.clearTheCart()
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Thông Báo", message: message.message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Xác Nhận", style: .destructive, handler: nil))
                            if let self = self{
                                self.cartTableView.tableView.reloadData()
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        
                    }
                }
            }
            
        }
        
        task.resume()
 
    }

    
    let moneyLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "VND"
        lb.font = lb.font.withSize(30)
        lb.textAlignment = .center
        return lb
    }()
    
    let cartLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Giỏ Hàng"
        lb.numberOfLines = 1
        return lb
    }()
    
    func setUpNavigationBar(){

        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.backward"), style: .plain, target: self, action: #selector(dismissCart))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func dismissCart(){
        self.dismiss(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.isUserInteractionEnabled = true
        self.reCalculateTotal()
        cartTableView.totalChangeDelegate = self
        
        
        self.view.addSubview(cartLabel)
        self.view.addSubview(cartTableView.tableView)
        self.view.addSubview(totalView)
        
        totalView.addSubview(thanhtienLabel)
        totalView.addSubview(moneyLabel)
        
        self.view.addSubview(dathangButton)
        
        
        let safeContent = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            cartLabel.topAnchor.constraint(equalTo: safeContent.topAnchor,constant: 10),
            cartLabel.leadingAnchor.constraint(equalTo: safeContent.leadingAnchor,constant: 10),
            cartLabel.heightAnchor.constraint(equalToConstant: 60),
            cartLabel.widthAnchor.constraint(equalToConstant: 100),

            cartTableView.tableView.topAnchor.constraint(equalTo: cartLabel.bottomAnchor,constant: 10),
            cartTableView.tableView.leadingAnchor.constraint(equalTo: safeContent.leadingAnchor),
            cartTableView.tableView.trailingAnchor.constraint(equalTo: safeContent.trailingAnchor),
            cartTableView.tableView.bottomAnchor.constraint(equalTo: safeContent.bottomAnchor,constant: -300),
            
            totalView.topAnchor.constraint(equalTo: cartTableView.tableView.bottomAnchor,constant: 20),
            totalView.leadingAnchor.constraint(equalTo: cartTableView.tableView.leadingAnchor,constant: 20),
            totalView.trailingAnchor.constraint(equalTo: cartTableView.tableView.trailingAnchor,constant: -20),
            totalView.heightAnchor.constraint(equalToConstant: 100),
            
            
//            thanhtienLabel.centerYAnchor.constraint(equalTo: totalView.centerYAnchor),
            thanhtienLabel.topAnchor.constraint(equalTo: totalView.topAnchor,constant: 10),
            thanhtienLabel.leadingAnchor.constraint(equalTo: totalView.leadingAnchor,constant: 10),
            thanhtienLabel.bottomAnchor.constraint(equalTo: totalView.bottomAnchor,constant: -10),
            thanhtienLabel.widthAnchor.constraint(equalToConstant: 100),
            
            
            moneyLabel.topAnchor.constraint(equalTo: totalView.topAnchor,constant: 5),
            moneyLabel.trailingAnchor.constraint(equalTo: totalView.trailingAnchor,constant: -10),
            moneyLabel.bottomAnchor.constraint(equalTo: totalView.bottomAnchor,constant: -5),
            moneyLabel.widthAnchor.constraint(equalToConstant: 200),
            
            
            dathangButton.topAnchor.constraint(equalTo: totalView.bottomAnchor,constant: 30),
            dathangButton.centerXAnchor.constraint(equalTo: safeContent.centerXAnchor),
            dathangButton.widthAnchor.constraint(equalToConstant: 300),
            dathangButton.heightAnchor.constraint(equalToConstant: 100)
            
            
        ])
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        print("cart is init")
        setUpNavigationBar()

    }
    deinit {
        print("Cart is deinit")
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CartViewController:totalChangedDelegate{
    
    func reCalculateTotal(){
        var total = 0
        for book in Cart.theCart.cartDict.keys{
            if Cart.theCart.cartDict[book] != nil{
                total += Cart.theCart.cartDict[book]! * book.price
            }
        }
        print(total)
        self.moneyLabel.text = String(total)
    }
    
    
}

