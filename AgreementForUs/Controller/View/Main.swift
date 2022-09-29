//
//  Main.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/07.
//

import UIKit
import os

class Main:UIView{
    
    //MARK: - Properties
    
    let mainImage:UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "MainIcon")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let mainLabel:UILabel = {
       let label = UILabel()
        label.text = "안전한 둘만의 사랑 계약서"
        label.textColor = .white
        label.font = .systemFont(ofSize: 100)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topButton:startButton = {
       let button = startButton()
        let text = button.setupText(first: "바로 시작해볼까요?", second: "블루투스로 주고 받는 계약서")
        button.setAttributedTitle(text, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let downButton:startButton = {
       let button = startButton()
        let text = button.setupText(first: "기록을 확인해볼까요?", second: "탭해서 확인하세요.")
        button.setAttributedTitle(text, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStack:UIStackView = {
       let st = UIStackView(arrangedSubviews: [topButton, downButton])
        st.axis = .vertical
        st.alignment = .center
        st.distribution = .equalSpacing
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var stack:UIStackView = {
        let st = UIStackView(arrangedSubviews: [topVacantLabel,mainImage, mainLabel, buttonStack, vacantLabel])
        st.axis = .vertical
        st.distribution = .equalSpacing
        st.alignment = .center
        st.translatesAutoresizingMaskIntoConstraints = false
        
        return st
    }()
    
    let vacantLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topVacantLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.backgroundColor
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            topVacantLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            topVacantLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            
            topButton.topAnchor.constraint(equalTo: buttonStack.topAnchor),
            topButton.leadingAnchor.constraint(equalTo: buttonStack.leadingAnchor),
            topButton.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor),
            topButton.heightAnchor.constraint(equalTo: buttonStack.heightAnchor, multiplier: 0.45),
            
            downButton.bottomAnchor.constraint(equalTo: buttonStack.bottomAnchor),
            downButton.leadingAnchor.constraint(equalTo: buttonStack.leadingAnchor),
            downButton.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor),
            downButton.heightAnchor.constraint(equalTo: buttonStack.heightAnchor, multiplier: 0.45),
            
            
            mainImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15),
            mainImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15),
            mainImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            mainLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            
            buttonStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            buttonStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            vacantLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            vacantLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
