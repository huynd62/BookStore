//
//  TopBooks.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/17/20.
//

import Foundation
import UIKit

class TopBooks : UIView {

    var topBooks : [TopSellerModelTest] = [
        TopSellerModelTest(color: UIColor.red, name: "RED"),
        TopSellerModelTest(color: UIColor.blue, name: "BLUE"),
        TopSellerModelTest(color: UIColor.green, name: "GREEN"),
        TopSellerModelTest(color: UIColor.purple, name: "PURPLE"),
        TopSellerModelTest(color: UIColor.cyan, name: "CYAN")
    ]
    
    var topEvents:[Event] = [
//        Event(name: "Back to school", image: UIImage(named: "salebanner")!),
//        Event(name: "Back to school", image: UIImage(named: "salebanner")!),
//        Event(name: "Back to school", image: UIImage(named: "salebanner")!),

    ]
    
    let cellIdentifier = "topSellersCell"
    
    private lazy var flowLayout:UICollectionViewFlowLayout = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        fl.minimumLineSpacing = 0
        return fl
    }()
    
    private lazy var topSellerCV:UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TopSellersCell.self, forCellWithReuseIdentifier: cellIdentifier)
        cv.backgroundColor  = .clear
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceHorizontal = false
        cv.dataSource = self
        cv.delegate = self
        cv.layer.cornerRadius = 20
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        let color = #colorLiteral(red: 0.5169081092, green: 0.4013616443, blue: 0.9968962073, alpha: 1)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
  
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(topSellerCV)
        
        NSLayoutConstraint.activate([
            
            topSellerCV.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            topSellerCV.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            topSellerCV.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            topSellerCV.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -10),
            topSellerCV.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            topSellerCV.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:  -40)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


//MARK:- UICollectionView Datasource
extension TopBooks : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventService.shared.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let info = EventService.shared.events[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TopSellersCell
        cell.eventImage.image = nil
        cell.layer.cornerRadius = 20
        cell.event = info
        return cell
    }
}
//MARK:- UICollectionViewFlowLayoutDelegate
extension TopBooks:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heigth = collectionView.frame.height
        let width = collectionView.frame.width 
        return CGSize(width: width, height: heigth)
    }
}



