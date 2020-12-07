//
//  HeaderView.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/16/20.
//

import Foundation
import UIKit



protocol openCartVC:class{
    func opentheCartVC()
}

class Header:UIView{
    
    var openCartDelegate:openCartVC?
    
    let searchBar = SearchBar()
    
    //    let userButton: UIButton = {
    //        let ub = UIButton(frame: .zero)
    //        ub.translatesAutoresizingMaskIntoConstraints = false
    //        ub.setImage(UIImage(systemName: "cart.fill"), for: .normal)
    //        ub.addTarget(self, action: #selector(prin), for: .touchUpInside)
    //        return ub
    //    }()
    
    let cartButton = UIButton.makeBarButton(systemImageName: "cart.fill")
    let optionButton = UIButton.makeBarButton(systemImageName: "option")
    
    
    @objc func cartSelected(){
        print("You have clicked the Cart button")
        openCartDelegate?.opentheCartVC()
    }
    @objc func optionSelected(){
        print("You have clicked the Option button")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let color = #colorLiteral(red: 0.5169081092, green: 0.4013616443, blue: 0.9968962073, alpha: 1)
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchBar)
        //        self.addSubview(userButton)
        let stackButton:UIStackView = {
            let stack = UIStackView(arrangedSubviews: [cartButton,optionButton])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.alignment = .center
            return stack
        }()
        cartButton.addTarget(self, action: #selector(cartSelected), for: .touchUpInside)
        optionButton.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
        self.addSubview(stackButton)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -100),
            self.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 10),
            
            //            userButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            //            userButton.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor),
            //            userButton.topAnchor.constraint(equalTo: searchBar.topAnchor)
            
            stackButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            stackButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            stackButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
