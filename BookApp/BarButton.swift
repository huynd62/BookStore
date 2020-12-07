//
//  BarButton.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/16/20.
//

import Foundation
import UIKit

extension UIButton{
    static func makeBarButton(systemImageName : String)->UIButton{
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: systemImageName), for: .normal)
        return btn
    }
    static func makeBarButton(imageName : String)->UIButton{
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: imageName), for: .normal)
        return btn
    }
}
