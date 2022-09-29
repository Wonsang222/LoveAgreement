//
//  RecordHeader.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/26.
//

import UIKit


class RecordHeader:UIView{
    
    let label1:UILabel = {
        let label=UILabel()
        label.text = "Date"
        label.textAlignment = .center
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2:UILabel = {
        let label=UILabel()
        label.text = "상대"
        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label3:UILabel = {
        let label=UILabel()
        label.text = "위도"
        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label4:UILabel = {
        let label=UILabel()
        label.text = "경도"
        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var stack:UIStackView = {
       let st = UIStackView(arrangedSubviews: [label1, label2, label3, label4])
        st.axis = .horizontal
        st.distribution = .fill
        st.spacing = 0
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
     
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            label1.topAnchor.constraint(equalTo: stack.topAnchor),
            label1.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            label1.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            label1.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.4),
            
            label2.topAnchor.constraint(equalTo: stack.topAnchor),
            label2.leadingAnchor.constraint(equalTo: label1.trailingAnchor),
            label2.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            label2.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.3),
            
            label3.topAnchor.constraint(equalTo: stack.topAnchor),
            label3.leadingAnchor.constraint(equalTo: label2.trailingAnchor),
            label3.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            label3.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.15),
            
            label4.topAnchor.constraint(equalTo: stack.topAnchor),
            label4.leadingAnchor.constraint(equalTo: label3.trailingAnchor),
            label4.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            label4.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.15),
            
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
