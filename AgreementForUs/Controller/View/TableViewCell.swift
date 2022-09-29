//
//  TableViewCell.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/26.
//

import UIKit

class TableViewCell:UITableViewCell{
    
    let label1:UILabel = {
       let label = UILabel()
        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2:UILabel = {
       let label = UILabel()
        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        label.textColor = .black
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.font = .preferredFont(forTextStyle: .callout)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label3:UILabel = {
       let label = UILabel()
        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        label.textColor = .black
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label4:UILabel = {
       let label = UILabel()
        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        label.textColor = .black
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stack)
        
        backgroundColor = .white
        
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
            label4.leadingAnchor.constraint(equalTo: label2.trailingAnchor),
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
