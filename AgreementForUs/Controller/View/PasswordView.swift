//
//  PasswordView.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/22.
//

import UIKit



class PasswordView:UIView{
    
    
    //MARK: - Properties
    
    lazy var buttonArray = [button0, button1, button2, button3, button4, button5, button6, button7, button8, button9]
    
    lazy var passwordViewArary = [passwordView1, passwordView2, passwordView3, passwordView4]
    
    let mainLabel:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let passwordView1:AssistanceView = {
       let pv = AssistanceView()
        return pv
    }()
    
    let passwordView2:AssistanceView = {
       let pv = AssistanceView()
        return pv
    }()
    
    let passwordView3:AssistanceView = {
       let pv = AssistanceView()
        return pv
    }()
    
    let passwordView4:AssistanceView = {
       let pv = AssistanceView()
        return pv
    }()
    
    lazy var passwordStackView:UIStackView = {
       let st = UIStackView(arrangedSubviews: [passwordView1, passwordView2, passwordView3, passwordView4])
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .fill
        st.spacing = 15
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    let button0:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("0", for: .normal)
        return button
    }()
    
    let button1:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("1", for: .normal)
        return button
    }()
    
    let button2:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("2", for: .normal)
        return button
    }()
    
    let button3:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("3", for: .normal)
        return button
    }()
    
    let button4:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("4", for: .normal)
        return button
    }()
    
    let button5:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("5", for: .normal)
        return button
    }()
    
    let button6:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("6", for: .normal)
        return button
    }()
    
    let button7:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("7", for: .normal)
        return button
    }()
    
    let button8:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("8", for: .normal)
        return button
    }()
  
    let button9:PasswordButton = {
       let button = PasswordButton()
        button.setTitle("9", for: .normal)
        return button
    }()
    
    lazy var backButton:PasswordButton = {
       let button = PasswordButton()
        button.setImage(UIImage(systemName: "arrow.left.square"), for: .normal)
        let pointSize: CGFloat = 30
        button.tintColor = .black
        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
        button.setPreferredSymbolConfiguration(imageConfig, forImageIn: .normal)
        return button
    }()
    
    let nothingButton:PasswordButton = {
       let button = PasswordButton()
        button.isEnabled = false
        return button
    }()
    
    lazy var stack1:UIStackView = {
       let st = UIStackView(arrangedSubviews: [button1, button2, button3])
        st.spacing = 0
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var stack2:UIStackView = {
       let st = UIStackView(arrangedSubviews: [button4, button5, button6])
        st.spacing = 0
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var stack3:UIStackView = {
       let st = UIStackView(arrangedSubviews: [button7, button8, button9])
        st.spacing = 0
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var stack4:UIStackView = {
       let st = UIStackView(arrangedSubviews: [nothingButton, button0, backButton])
        st.spacing = 0
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var stack5:UIStackView = {
        let st = UIStackView(arrangedSubviews: [stack1, stack2, stack3, stack4])
        st.axis = .vertical
        st.spacing = 0
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(passwordStackView)
        addSubview(mainLabel)
        addSubview(stack5)
        
        NSLayoutConstraint.activate([
            
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 20),
            
            passwordStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordStackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 30),
            passwordStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.06),
            passwordStackView.widthAnchor.constraint(equalTo: passwordStackView.heightAnchor, multiplier: 4, constant: 45),
        
            stack5.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stack5.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack5.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack5.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Actions
    
    func setupPassword(){
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineSpacing = 10
        let attributedText = NSMutableAttributedString(string: "비밀번호를 설정합니다.\n", attributes: [.font : UIFont.preferredFont(forTextStyle: .headline), .foregroundColor:UIColor.white.cgColor, .paragraphStyle: paragraph])
        let toAddText = NSAttributedString(string: "비밀번호 4자리를 입력해주세요", attributes: [.font : UIFont.preferredFont(forTextStyle: .subheadline), .foregroundColor:UIColor.white.cgColor, .paragraphStyle: paragraph])
        attributedText.append(toAddText)
        mainLabel.attributedText = attributedText
    }
    
    func checkupPassword(){
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineSpacing = 6
        let attributedText = NSMutableAttributedString(string: "비밀번호를 확인합니다.\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 20), .foregroundColor:UIColor.white.cgColor, .paragraphStyle: paragraph])
        let toAddText = NSAttributedString(string: "비밀번호 4자리를 재입력해주세요", attributes: [.font : UIFont.systemFont(ofSize: 20), .foregroundColor:UIColor.white.cgColor, .paragraphStyle: paragraph])
        attributedText.append(toAddText)
        mainLabel.attributedText = attributedText
    }
    
    func loginPassword(){
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineSpacing = 6
        let attributedText = NSMutableAttributedString(string: "로그인하기 위해.\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 20), .foregroundColor:UIColor.white.cgColor, .paragraphStyle: paragraph])
        let toAddText = NSAttributedString(string: "비밀번호 4자리를 재입력해주세요", attributes: [.font : UIFont.systemFont(ofSize: 20), .foregroundColor:UIColor.white.cgColor, .paragraphStyle: paragraph])
        attributedText.append(toAddText)
        mainLabel.attributedText = attributedText
    }
    
    
    func clear(){
        for i in 0..<passwordViewArary.count - 1 {
            passwordViewArary[i].backSpace()
        }
    }
    
}
