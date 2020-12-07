//
//  ViewController.swift
//  BookApp
//
//  Created by Nguyễn Đức Huy on 10/16/20.
//

import UIKit
import FBSDKLoginKit


class ViewController: UIViewController {
    
    
    let loginFBButton:FBLoginButton = {
        let fb = FBLoginButton()
        fb.translatesAutoresizingMaskIntoConstraints = false
        return fb
    }()
    
    let logo :UIImageView = {
        let v = UIImageView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(named: "logo")
        v.clipsToBounds = true
        v.layer.cornerRadius = 20
        return v
    }()
    
    let loginButton:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Đăng Nhập", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        return btn
    }()
    
    let loaderView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 10
        view.alpha = 0.4
        return view
    }()
    
    let loader:UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(frame: .zero)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.startAnimating()
        loader.color = .blue
        return loader
    }()
    
    @objc func loginClick(){
        let username = usernameTF.text
        let password = passwordTF.text
            
        DispatchQueue.main.async {
            self.view.addSubview(self.loaderView)
            self.loaderView.addSubview(self.loader)
            self.loader.alpha = 1.0
            
            NSLayoutConstraint.activate([
            
                self.loaderView.heightAnchor.constraint(equalToConstant: 50),
                self.loaderView.widthAnchor.constraint(equalTo: self.loaderView.heightAnchor),
                self.loaderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.loaderView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -100),
                
                
                self.loader.topAnchor.constraint(equalTo: self.loaderView.topAnchor),
                self.loader.bottomAnchor.constraint(equalTo: self.loaderView.bottomAnchor),
                self.loader.leadingAnchor.constraint(equalTo: self.loaderView.leadingAnchor),
                self.loader.trailingAnchor.constraint(equalTo: self.loaderView.trailingAnchor)
                
            
            ])
            
        }

        
        let api = K.loginAPI + "\(username!)" + "/" + "\(password!)"
        
        let task = URLSession(configuration: .default).dataTask(with: URL(string: api)!) { (data, response, error) in
            if error != nil{
                print("Error")
            }else{
                if (response as! HTTPURLResponse).statusCode == 201{
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        let message = try! decoder.decode(Message.self, from: safeData)
                        
                        User.theUser.setid(id: Int(message.message)!)
                        User.theUser.setusername(username: username!)
                        
                        DispatchQueue.main.async {
                            while BookService.myBooks.book.count == 0  && EventService.shared.events.count == 0 {
                                sleep(1)
                            }
                            self.loader.stopAnimating()
                            self.loader.removeFromSuperview()
                            self.loaderView.removeFromSuperview()
                            self.loader.startAnimating()
                            let homevc = HomeScreenVC()
                            homevc.modalPresentationStyle = .fullScreen
                            self.present(homevc, animated: true, completion: nil)
                        }
                        
                        
                    }
                }
                if [202,203].contains((response as! HTTPURLResponse).statusCode){
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        let message = try! decoder.decode(Message.self, from: safeData)
                        
                        DispatchQueue.main.async {
                            
                            self.loader.stopAnimating()
                            self.loader.removeFromSuperview()
                            self.loaderView.removeFromSuperview()
                            self.loader.startAnimating()    
                            
                            let alert = UIAlertController(title: "Thông Báo", message: message.message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Xác Nhận", style: .destructive, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        
                    }
                }
            }
        }
        task.resume()
        
        
    }
    @objc func signUpClick(){
        print("Click SignUp")
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
    let signUpButton:UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Đăng Ký", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(signUpClick), for: .touchUpInside)
        return btn
    }()
    
    
    let usernameIcon:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "person.fill")
        return view
    }()
    
    let passwordIcon:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "lock.fill")
        return view
    }()
    
    let loginView : UIView = {
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
    
    let passwordView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    let usernameTF:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Tài khoản"
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.clearButtonMode = .always
        return tf
    }()
    
    
    let fbLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Hoặc đăng nhập bằng tài khoản FaceBook"
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
    let passwordTF:UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Mật khẩu"
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.clearButtonMode = .always
        tf.isSecureTextEntry = true
        return tf
    }()
    
    var loginButtonView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    var signUpButtonView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fbButtonView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        return view
    }()
    @objc func fbLoginButtonClick(){
        //        if let token = AccessToken.current, !token.isExpired {
        //            let homevc = HomeScreenVC()
        //            homevc.modalPresentationStyle = .overFullScreen
        //            self.present(homevc, animated: true, completion: nil)
        //        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        loginFBButton.translatesAutoresizingMaskIntoConstraints = false
        loginFBButton.addTarget(self, action: #selector(fbLoginButtonClick), for: .touchUpInside)
        
        loginButtonView.addSubview(loginButton)
        signUpButtonView.addSubview(signUpButton)
        
        self.view.addSubview(logo)
        self.view.addSubview(loginView)
        self.view.addSubview(fbLabel)
        loginView.addSubview(usernameView)
        loginView.addSubview(passwordView)
        
        loginView.addSubview(loginButtonView)
        loginView.addSubview(signUpButtonView)
        
        usernameView.addSubview(usernameIcon)
        usernameView.addSubview(usernameTF)
        usernameTF.delegate = self
        
        passwordView.addSubview(passwordIcon)
        passwordView.addSubview(passwordTF)
        passwordTF.delegate = self
        
        self.view.addSubview(fbButtonView)
        fbButtonView.addSubview(loginFBButton)
        
        let safeContent = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            
            logo.topAnchor.constraint(equalTo: safeContent.topAnchor,constant: 40),
            logo.leadingAnchor.constraint(equalTo: safeContent.leadingAnchor,constant: 50),
            logo.trailingAnchor.constraint(equalTo: safeContent.trailingAnchor,constant: -50),
            logo.heightAnchor.constraint(equalToConstant: 100),
            
            loginView.centerYAnchor.constraint(equalTo: safeContent.centerYAnchor,constant: -80),
            loginView.leadingAnchor.constraint(equalTo: safeContent.leadingAnchor,constant: 20),
            loginView.trailingAnchor.constraint(equalTo: safeContent.trailingAnchor,constant: -20),
            loginView.heightAnchor.constraint(equalToConstant: 300),
            
            
            usernameView.topAnchor.constraint(equalTo: loginView.topAnchor,constant: 50),
            usernameView.leadingAnchor.constraint(equalTo: loginView.leadingAnchor,constant: 20),
            usernameView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor,constant: -20),
            usernameView.heightAnchor.constraint(equalToConstant: 50),
            
            
            passwordView.topAnchor.constraint(equalTo: usernameView.bottomAnchor,constant: 30),
            passwordView.leadingAnchor.constraint(equalTo: loginView.leadingAnchor,constant: 20),
            passwordView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor,constant: -20),
            passwordView.heightAnchor.constraint(equalToConstant: 50),
            
            usernameIcon.topAnchor.constraint(equalTo: usernameView.topAnchor,constant: 10),
            usernameIcon.leadingAnchor.constraint(equalTo: usernameView.leadingAnchor,constant: 20),
            usernameIcon.bottomAnchor.constraint(equalTo: usernameView.bottomAnchor,constant: -10),
            usernameIcon.widthAnchor.constraint(equalToConstant: 30),
            
            usernameTF.leadingAnchor.constraint(equalTo: usernameIcon.trailingAnchor,constant: 5),
            usernameTF.topAnchor.constraint(equalTo: usernameIcon.topAnchor),
            usernameTF.trailingAnchor.constraint(equalTo: usernameView.trailingAnchor,constant: -5
            ),
            usernameTF.bottomAnchor.constraint(equalTo: usernameIcon.bottomAnchor),
            
            
            passwordIcon.topAnchor.constraint(equalTo: passwordView.topAnchor,constant: 10),
            passwordIcon.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor,constant: 20),
            passwordIcon.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor,constant: -10),
            passwordIcon.widthAnchor.constraint(equalToConstant: 30),
            
            passwordTF.topAnchor.constraint(equalTo: passwordIcon.topAnchor),
            passwordTF.leadingAnchor.constraint(equalTo: passwordIcon.trailingAnchor,constant: 5),
            passwordTF.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor,constant: -5),
            passwordTF.bottomAnchor.constraint(equalTo: passwordIcon.bottomAnchor),
            
            
            loginButtonView.topAnchor.constraint(equalTo: passwordView.bottomAnchor,constant: 20),
            loginButtonView.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButtonView.widthAnchor.constraint(equalToConstant: 150),
            
            loginButton.topAnchor.constraint(equalTo: loginButtonView.topAnchor),
            loginButton.leadingAnchor.constraint(equalTo: loginButtonView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginButtonView.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: loginButtonView.bottomAnchor),
            
            signUpButtonView.topAnchor.constraint(equalTo: loginButtonView.bottomAnchor,constant: 20),
            signUpButtonView.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            signUpButtonView.widthAnchor.constraint(equalToConstant: 150),
            
            signUpButton.topAnchor.constraint(equalTo: signUpButtonView.topAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: signUpButtonView.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: signUpButtonView.trailingAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: signUpButtonView.bottomAnchor),
            
            
            fbLabel.topAnchor.constraint(equalTo: loginView.bottomAnchor,constant: 20),
            fbLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            fbLabel.heightAnchor.constraint(equalToConstant:  20),
            fbLabel.widthAnchor.constraint(equalToConstant:  300),
            
            fbButtonView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            fbButtonView.topAnchor.constraint(equalTo: fbLabel.bottomAnchor,constant: 20),
            fbButtonView.heightAnchor.constraint(equalToConstant: 50),
            fbButtonView.widthAnchor.constraint(equalToConstant: 220),
            
            loginFBButton.topAnchor.constraint(equalTo: fbButtonView.topAnchor,constant: 5),
            loginFBButton.leadingAnchor.constraint(equalTo: fbButtonView.leadingAnchor,constant: 5),
            loginFBButton.trailingAnchor.constraint(equalTo: fbButtonView.trailingAnchor,constant: -5),
            loginFBButton.bottomAnchor.constraint(equalTo: fbButtonView.bottomAnchor,constant: -5)
            
        ])

        
    }    
    
}
extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
