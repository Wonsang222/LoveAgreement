//
//  PasswordController.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/22.
//

import UIKit

class PasswordController:UIViewController{
    
    //MARK: - Properties

    lazy var count:Int = 0 {
        didSet{
            if count == 4{
                DispatchQueue.main.async {
                    self.passwordView.clear()
                }
                passwordView.checkupPassword()
                setUpButtons2()
            }
        }
    }
    
    lazy var count2:Int = 0 {
        didSet{
            if count2 == 4{
                matchPassword()
            }
        }
    }
    
    var firstVisit:Bool
    let passwordView = PasswordView()
    var passwordArray = [String]()
    var passwordIdentifier = [String]()
    let defaults = UserDefaults.standard
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        start()
    }
    
    override func loadView() {
        view = passwordView
    }
    
        init(firstVisit: Bool) {
            self.firstVisit = firstVisit
    
            super.init(nibName: nil, bundle: nil)
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView?.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.titleView?.isHidden = false
    }
    
    //MARK: - Actions
    func start(){
        if firstVisit{
            count = 0
            count2 = 0
            passwordArray = [String]()
            passwordIdentifier = [String]()
            passwordView.setupPassword()
            setUpButtons()
        } else{
            passwordView.loginPassword()
            passwordIdentifier = [String]()
            count2 = 0
            setUpButtons2()
        }
    }
    
    func setUpButtons(){
        for button in passwordView.buttonArray{
            button.removeTarget(nil, action: nil, for: .allEvents)
            button.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
        }
        passwordView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setUpButtons2(){
        for button in passwordView.buttonArray{
            button.removeTarget(nil, action: nil, for: .allEvents)
            button.addTarget(self, action: #selector(numberButtonTapped2(_:)), for: .touchUpInside)
        }
        passwordView.backButton.addTarget(self, action: #selector(backButtonTapped2), for: .touchUpInside)
    }
    
    @objc func numberButtonTapped(_ sender:UIButton){
        
        if passwordArray.count < 3{
            passwordArray.append(sender.currentTitle!)
            count += 1
            passwordView.passwordViewArary[passwordArray.count - 1].typePassword()
        }
        else if passwordArray.count == 3 {
            passwordArray.append(sender.currentTitle!)
            count += 1
            DispatchQueue.main.async {
                self.passwordView.clear()
            }
        }
    }
    
    @objc func numberButtonTapped2(_ sender:UIButton){
        if passwordIdentifier.count < 3{
            passwordIdentifier.append(sender.currentTitle!)
            count2 += 1
            DispatchQueue.main.async {
                self.passwordView.passwordViewArary[self.passwordIdentifier.count - 1].typePassword()
            }
            return
        }
        else if passwordIdentifier.count == 3 {
            passwordIdentifier.append(sender.currentTitle!)
            count2 += 1
            DispatchQueue.main.async {
                self.passwordView.clear()
            }
            return
        }
    }
    
    @objc func backButtonTapped(){
        if passwordArray.count > 0 {
            passwordArray.popLast()
            DispatchQueue.main.async {
                self.passwordView.passwordViewArary[self.passwordArray.count].backSpace()
            }
        }
        return
    }
    
    @objc func backButtonTapped2(){
        if passwordIdentifier.count > 0 {
            passwordIdentifier.popLast()
            DispatchQueue.main.async {
                self.passwordView.passwordViewArary[self.passwordIdentifier.count].backSpace()
            }
        }
    }
    
    func matchPassword(){
        if passwordArray.elementsEqual(passwordIdentifier){
            if firstVisit{
                defaults.set(passwordArray, forKey: "UserPassword")
            }
            navigationController?.popToRootViewController(animated: true)
        }
        else{
            if firstVisit{
                resetAlarmPopup("비밀번호가 틀렸습니다", "비밀번호를 재설정합니다")
                start()
            }else{
                resetAlarmPopup("비밀번호가 틀렸습니다", "비밀번호를 다시 입력해주세요")
                start()
            }
        }
    }
    
    func resetAlarmPopup(_ value:String, _ value2:String){
        let alert = UIAlertController(title: value, message: value2, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(success)
        
        self.present(alert, animated: true, completion: nil)
    }
}



