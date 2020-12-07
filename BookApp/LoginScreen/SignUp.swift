//
//  SignUp.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 11/6/20.
//

import Foundation
import UIKit

class SignUpViewController:UIViewController{
    
    let logo :UIImageView = {
        let v = UIImageView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(named: "logo")
        v.clipsToBounds = true
        v.layer.cornerRadius = 20
        return v
    }()
    
    let signUpView : UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGroupedBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    let usernameView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    let usernameIcon:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "person.fill")
        return view
    }()
    let usernameTF:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Tài khoản trên 6 ký tự"
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.clearButtonMode = .always
        return tf
    }()
    
    let adressView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    let adressIcon:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "location.circle")
        return view
    }()
    let adressTF:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Địa Chỉ"
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.clearButtonMode = .always
        return tf
    }()
    
    let phoneView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    let phoneIcon:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "phone.fill")
        return view
    }()
    let phoneTF:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Số Điện Thoại"
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.clearButtonMode = .always
        tf.keyboardType = .numberPad
        return tf
    }()
    
    
    let passwordView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    let passwordIcon:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "lock")
        return view
    }()
    let passwordTF:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Mật khẩu"
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.clearButtonMode = .always
        tf.isSecureTextEntry = true
        tf.textContentType = .oneTimeCode
        return tf
    }()
    
    
    let xacnhanpasswordView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    let xacnhanpasswordIcon:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "lock.fill")
        return view
    }()
    let xacnhanpasswordTF:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Xác Nhận Lại Mật khẩu"
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.clearButtonMode = .always
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    let signUpButton:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Đăng Ký", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(signupClick), for: .touchUpInside)
        return btn
    }()
    
    @objc func signupClick(){
        //Validate
        var isFilled = true
        var isValidated = false
        for tf in [usernameTF,adressTF,phoneTF,passwordTF,xacnhanpasswordTF]{
            if tf.text!.count == 0 {
                isFilled = false
            }
        }
        if isFilled == true{
            if usernameTF.text!.count < 6{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Thông Báo", message: "Tài Khoản Phải Trên 6 Ký Tự", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Xác Nhận", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            if passwordTF.text! != xacnhanpasswordTF.text!{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Thông Báo", message: "Mật Khẩu Phải Trùng Với Mật Khẩu Xác Nhận", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Xác Nhận", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            isValidated = true
        }else{
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Thông Báo", message: "Xin Hãy Điền Đủ Thông Tin", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Xác Nhận", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        if isValidated == true {
            let un = usernameTF.text!
            let pw = passwordTF.text!
            let dc = adressTF.text!
            let phone = phoneTF.text!

            let api = K.signupAPi
            
            let para:[String:Any] = [
                "signup_info" : [
                    "un":un,
                    "pw":pw,
                    "dc":dc,
                    "phone":phone
                ]
            ]
            
            var request = URLRequest(url: URL(string: api)!)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: para, options: []) else {return}
            request.httpBody = httpBody
            request.timeoutInterval = 20
            
            let task = URLSession(configuration: .default).dataTask(with: request) {
                [weak self]
                (data, response, error) in
                if error != nil {
                    print(error!)
                }
                if (response as! HTTPURLResponse).statusCode == 201 {
                    if let data = data {
                        let decoder = JSONDecoder()
                        let message = try! decoder.decode(Message.self, from: data)
                        
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Thông Báo", message: message.message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Xác Nhận", style: .destructive,handler: { (action) in
                                if let self = self{
                                    self.thoatClick()
                                }
                            }))
                            if let self = self{
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        
                    }
                }
                if [202,203,500].contains((response as! HTTPURLResponse).statusCode){
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        let message = try! decoder.decode(Message.self, from: safeData)
                        
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Thông Báo", message: message.message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Xác Nhận", style: .destructive, handler: nil))
                            if let self = self{
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
                
            }
            task.resume()
        }
    }
    let thoatButton:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Thoát", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(thoatClick), for: .touchUpInside)
        return btn
    }()
    
    @objc func thoatClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(logo)
        self.view.addSubview(signUpView)
        signUpView.addSubview(usernameView)
        signUpView.addSubview(adressView)
        signUpView.addSubview(phoneView)
        signUpView.addSubview(passwordView)
        signUpView.addSubview(xacnhanpasswordView)
        self.view.addSubview(signUpButton)
        self.view.addSubview(thoatButton)
        
        usernameView.addSubview(usernameIcon)
        usernameView.addSubview(usernameTF)
        usernameTF.delegate = self
        
        adressView.addSubview(adressIcon)
        adressView.addSubview(adressTF)
        adressTF.delegate = self
        
        phoneView.addSubview(phoneIcon)
        phoneView.addSubview(phoneTF)
        phoneTF.delegate = self
        
        passwordView.addSubview(passwordIcon)
        passwordView.addSubview(passwordTF)
        passwordTF.delegate = self
        
        xacnhanpasswordView.addSubview(xacnhanpasswordIcon)
        xacnhanpasswordView.addSubview(xacnhanpasswordTF)
        xacnhanpasswordTF.delegate = self
        
        let safeContent = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: safeContent.topAnchor,constant: 40),
            logo.leadingAnchor.constraint(equalTo: safeContent.leadingAnchor,constant: 50),
            logo.trailingAnchor.constraint(equalTo: safeContent.trailingAnchor,constant: -50),
            logo.heightAnchor.constraint(equalToConstant: 100),
            
            
            signUpView.centerYAnchor.constraint(equalTo: safeContent.centerYAnchor,constant: 10),
            signUpView.leadingAnchor.constraint(equalTo: safeContent.leadingAnchor,constant: 20),
            signUpView.trailingAnchor.constraint(equalTo: safeContent.trailingAnchor,constant: -20),
            signUpView.heightAnchor.constraint(equalToConstant: 450),
            
            
            usernameView.topAnchor.constraint(equalTo: signUpView.topAnchor,constant: 40),
            usernameView.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor,constant: 20),
            usernameView.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor,constant: -20),
            usernameView.heightAnchor.constraint(equalToConstant: 50),
            
            usernameIcon.topAnchor.constraint(equalTo: usernameView.topAnchor,constant: 10),
            usernameIcon.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor,constant: 20),
            usernameIcon.bottomAnchor.constraint(equalTo: usernameView.bottomAnchor,constant: -10),
            usernameIcon.widthAnchor.constraint(equalToConstant: 30),
            
            usernameTF.leadingAnchor.constraint(equalTo: usernameIcon.trailingAnchor,constant: 5),
            usernameTF.topAnchor.constraint(equalTo: usernameIcon.topAnchor),
            usernameTF.trailingAnchor.constraint(equalTo: usernameView.trailingAnchor,constant: -5
            ),
            usernameTF.bottomAnchor.constraint(equalTo: usernameIcon.bottomAnchor),
            
            
            //MARK:- adressUIView
            adressView.topAnchor.constraint(equalTo: usernameView.bottomAnchor,constant: 30),
            adressView.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor,constant: 20),
            adressView.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor,constant: -20),
            adressView.heightAnchor.constraint(equalToConstant: 50),
            
            adressIcon.topAnchor.constraint(equalTo: adressView.topAnchor,constant: 10),
            adressIcon.leadingAnchor.constraint(equalTo: adressView.leadingAnchor,constant: 20),
            adressIcon.bottomAnchor.constraint(equalTo: adressView.bottomAnchor,constant: -10),
            adressIcon.widthAnchor.constraint(equalToConstant: 30),
            
            
            adressTF.leadingAnchor.constraint(equalTo: adressIcon.trailingAnchor,constant: 5),
            adressTF.topAnchor.constraint(equalTo: adressIcon.topAnchor),
            adressTF.trailingAnchor.constraint(equalTo: adressView.trailingAnchor,constant: -5
            ),
            adressTF.bottomAnchor.constraint(equalTo: adressIcon.bottomAnchor),
            
            
            phoneView.topAnchor.constraint(equalTo: adressView.bottomAnchor,constant: 30),
            phoneView.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor,constant: 20),
            phoneView.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor,constant: -20),
            phoneView.heightAnchor.constraint(equalToConstant: 50),
            
            phoneIcon.topAnchor.constraint(equalTo: phoneView.topAnchor,constant: 10),
            phoneIcon.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor,constant: 20),
            phoneIcon.bottomAnchor.constraint(equalTo: phoneView.bottomAnchor,constant: -10),
            phoneIcon.widthAnchor.constraint(equalToConstant: 30),
            
            
            phoneTF.leadingAnchor.constraint(equalTo: phoneIcon.trailingAnchor,constant: 5),
            phoneTF.topAnchor.constraint(equalTo: phoneIcon.topAnchor),
            phoneTF.trailingAnchor.constraint(equalTo: phoneView.trailingAnchor,constant: -5
            ),
            phoneTF.bottomAnchor.constraint(equalTo: phoneIcon.bottomAnchor),
            
            
            passwordView.topAnchor.constraint(equalTo: phoneView.bottomAnchor,constant: 30),
            passwordView.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor,constant: 20),
            passwordView.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor,constant: -20),
            passwordView.heightAnchor.constraint(equalToConstant: 50),
            
            passwordIcon.topAnchor.constraint(equalTo: passwordView.topAnchor,constant: 10),
            passwordIcon.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor,constant: 20),
            passwordIcon.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor,constant: -10),
            passwordIcon.widthAnchor.constraint(equalToConstant: 30),
            
            
            passwordTF.leadingAnchor.constraint(equalTo: passwordIcon.trailingAnchor,constant: 5),
            passwordTF.topAnchor.constraint(equalTo: passwordIcon.topAnchor),
            passwordTF.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor,constant: -5
            ),
            passwordTF.bottomAnchor.constraint(equalTo: passwordIcon.bottomAnchor),
            
            
            xacnhanpasswordView.topAnchor.constraint(equalTo: passwordView.bottomAnchor,constant: 30),
            xacnhanpasswordView.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor,constant: 20),
            xacnhanpasswordView.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor,constant: -20),
            xacnhanpasswordView.heightAnchor.constraint(equalToConstant: 50),
            
            xacnhanpasswordIcon.topAnchor.constraint(equalTo: xacnhanpasswordView.topAnchor,constant: 10),
            xacnhanpasswordIcon.leadingAnchor.constraint(equalTo: xacnhanpasswordView.leadingAnchor,constant: 20),
            xacnhanpasswordIcon.bottomAnchor.constraint(equalTo: xacnhanpasswordView.bottomAnchor,constant: -10),
            xacnhanpasswordIcon.widthAnchor.constraint(equalToConstant: 30),
            
            
            xacnhanpasswordTF.leadingAnchor.constraint(equalTo: xacnhanpasswordIcon.trailingAnchor,constant: 5),
            xacnhanpasswordTF.topAnchor.constraint(equalTo: xacnhanpasswordIcon.topAnchor),
            xacnhanpasswordTF.trailingAnchor.constraint(equalTo: xacnhanpasswordView.trailingAnchor,constant: -5
            ),
            xacnhanpasswordTF.bottomAnchor.constraint(equalTo: xacnhanpasswordIcon.bottomAnchor),
            
            
            signUpButton.topAnchor.constraint(equalTo: signUpView.bottomAnchor,constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: signUpView.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 150),
            
            thoatButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor,constant: 20),
            thoatButton.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor),
            thoatButton.widthAnchor.constraint(equalToConstant: 150),
            
        ])
        
        
    }
    
}
extension SignUpViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
