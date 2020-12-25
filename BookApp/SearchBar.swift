//
//  SearchBar.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/16/20.
//

import Foundation
import UIKit

class SearchBar : UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = "Tìm sách theo tên"
        self.searchTextField.backgroundColor = .white
        let color = #colorLiteral(red: 0.5169081092, green: 0.4013616443, blue: 0.9968962073, alpha: 1)
        self.barTintColor = color
        self.searchBarStyle = .minimal
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 40)
        ])

    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.resignFirstResponder()
    }
}
