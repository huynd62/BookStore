//
//  CartCell.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/22/20.
//

import Foundation
import UIKit



class CartCell:UITableViewCell{
    

    var bookImageView:UIImageView =  {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let nameLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.8
        lb.numberOfLines = 1
        return lb
    }()
    let priceLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let totalLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        return lb
    }()
    
    let soluongLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let outerView :UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .systemGroupedBackground
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let stepper:UIStepper = {
        let st = UIStepper(frame: .zero)
        st.translatesAutoresizingMaskIntoConstraints = false
        st.minimumValue = 0
        st.maximumValue = 100
        st.autorepeat = true
        st.isEnabled = true
//        st.addTarget(self, action: #selector(stepperClicked), for: .valueChanged)
        return st
    }()
    
    @objc func stepperClicked(){
        print("hello every body")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(outerView)
        contentView.isUserInteractionEnabled = true
        outerView.addSubview(bookImageView)
        outerView.addSubview(nameLabel)
        outerView.addSubview(priceLabel)
        outerView.addSubview(soluongLabel)
        outerView.addSubview(totalLabel)
        outerView.addSubview(stepper)
        
        let outerViewBottomConstraint = outerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10)
        outerViewBottomConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            
            outerView.topAnchor.constraint(equalTo: contentView.topAnchor ,constant: 10),
            outerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            outerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            outerViewBottomConstraint,

            
            //set book's image constraint
            
            bookImageView.topAnchor.constraint(equalTo: outerView.topAnchor,constant: 5),
            bookImageView.leadingAnchor.constraint(equalTo: outerView.leadingAnchor,constant: 20),
            bookImageView.bottomAnchor.constraint(equalTo: outerView.bottomAnchor,constant: -5),
            bookImageView.heightAnchor.constraint(equalToConstant: 100),
            bookImageView.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: bookImageView.topAnchor,constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor,constant: 5),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.widthAnchor.constraint(equalToConstant: 150),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 3),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            
            soluongLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,constant: 3),
            soluongLabel.leadingAnchor.constraint(equalTo:priceLabel.leadingAnchor),
            soluongLabel.heightAnchor.constraint(equalToConstant: 30),
            
            totalLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            totalLabel.heightAnchor.constraint(equalToConstant: 30),
            totalLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor,constant: 70),
            
            stepper.topAnchor.constraint(equalTo: soluongLabel.topAnchor),
            stepper.leadingAnchor.constraint(equalTo: totalLabel.leadingAnchor,constant: -20),
            stepper.heightAnchor.constraint(equalToConstant: 30)

            
        ])
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
}
