//
//  TopSellersCell.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/19/20.
//

import Foundation

import UIKit

class TopSellersCell: UICollectionViewCell {
    
    
    var event:Event? = nil{
        didSet{
            fetchEventImage()
        }
    }
    
    var eventImage:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    var loader:UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(frame: .zero)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.backgroundColor = .clear
        loader.layer.cornerRadius = 20
        loader.color = .blue
        loader.startAnimating()
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.layer.cornerRadius = 20
        setupCell()
    }
    
    func setupCell(){
        contentView.addSubview(eventImage)
        eventImage.addSubview(loader)
        NSLayoutConstraint.activate([

            eventImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            loader.topAnchor.constraint(equalTo: eventImage.topAnchor),
            loader.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor),
            loader.leadingAnchor.constraint(equalTo: eventImage.leadingAnchor),
            loader.bottomAnchor.constraint(equalTo: eventImage.bottomAnchor)
            
        ])
    }
    
    func geteventimage(){
        
    }
    func fetchEventImage(){
        if self.event?.image != nil {
            self.loader.stopAnimating()
            self.eventImage.image = self.event?.image
        }else{
            self.loader.startAnimating()
            let temp = self.event?.imageURL
            let task = URLSession(configuration: .default).dataTask(with: URL(string: self.event!.imageURL)!) { (data, response, error) in
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
        if backURL! == self.event!.imageURL{
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.event?.image = image
                self.eventImage.image = image
            }
        }else{
            print("not matched")
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

}
