//
//  ContractView.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/05.
//

import UIKit

class ContractView:UIView{
       
    let contractTextView:CustomTextView = {
        let label = CustomTextView()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let agreeButtonView:AgreeButtonView = {
       let view = AgreeButtonView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(contractTextView)
        addSubview(agreeButtonView)
        
        NSLayoutConstraint.activate([
            contractTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            contractTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contractTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contractTextView.bottomAnchor.constraint(equalTo: agreeButtonView.topAnchor),
            
            agreeButtonView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            agreeButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            agreeButtonView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        print("its\(agreeButtonView.button1.bounds.height)")
        print("its\(agreeButtonView.bounds.height)")
        
//        button1.heightAnchor.constraint(equalToConstant: theHeight).isActive = true
//        button1.widthAnchor.constraint(equalToConstant: theHeight).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    }
