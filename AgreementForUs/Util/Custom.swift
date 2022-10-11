//
//  Box.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/05.
//

import UIKit

class CustomTextView:UITextView{
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        isScrollEnabled = true
        isUserInteractionEnabled = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        isEditable = false
        textAlignment = NSTextAlignment.natural
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func writeContractword(_ date:Date)->NSAttributedString{
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 M월 d일 HH시 mm분"
        let str = dateFormatter.string(from: date)
    
        let contractWord = """
상기 두 사람은 \(str), 아래와 같은 조건으로 상호 합의하에 성관계를 가짐을 확인합니다. \n
1.  해당행위는 강요, 협박, 약취, 유인, 매매춘 등의 사실이 없음.\n
2.  상호 민 형사상 성인임을 상대에게 고지하였음.\n
3.  피임은 두 사람이 공동으로 노력함.\n
4.  사진촬영, 녹음, 동영상 촬영 등의 행위를 일체하지 않음.\n
5.  해당행위에 대한 자료를 인터넷, 스마트폰 어플에 게시 및 SNS 유포 등, 가족,배우자, 지인등에게 성관계 혹은 이를 암시하는 어떠한 행동도 하지 않음.\n
6.  만일 위의 사항들을 위반할 시, 상대방은 모든 민/형사 소송으로부터 면책권을 가지며, 어긴 당사자는 십억 원을 배상할 책임이 있음.\n
7.  이 표준계약서는 각가 핸드폰에 저장보관하며, 유효기간은 지우지 않는한 영구함.
"""
        let thirdParagraphStyle = NSMutableParagraphStyle()
        thirdParagraphStyle.firstLineHeadIndent = 0
        thirdParagraphStyle.headIndent = 10
        attributedText = NSAttributedString(string: contractWord, attributes: [NSAttributedString.Key.paragraphStyle: thirdParagraphStyle, .font:UIFont.systemFont(ofSize: 19)])

        return attributedText
    }
}

class AgreeButtonView:UIView{
        
    let label1:UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.text = "동의합니다."
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let label2:UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = true
        label.text = "동의하지 않습니다."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let button1 = BoxView()
    let button2 = BoxView()
    
    lazy var stack1:UIStackView = {
       let st = UIStackView(arrangedSubviews: [button1, label1])
        st.axis = .horizontal
        st.spacing = 10
        st.distribution = .fill
        st.alignment = .center
        st.tag = 1
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var stack2:UIStackView = {
       let st = UIStackView(arrangedSubviews: [button2, label2])
        st.axis = .horizontal
        st.spacing = 10
        st.distribution = .fill
        st.alignment = .center
        st.tag = 2
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var stack3:UIStackView = {
       let st = UIStackView(arrangedSubviews: [stack1, stack2])
        st.axis = .vertical
        st.spacing = 5
        st.distribution = .fill
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stack3)
        
        NSLayoutConstraint.activate([
            
            button1.widthAnchor.constraint(equalTo: stack1.heightAnchor, multiplier: 0.45),
            button1.heightAnchor.constraint(equalTo: stack1.heightAnchor, multiplier: 0.45),
            button1.leadingAnchor.constraint(equalTo: stack1.leadingAnchor, constant: 10),

            
            label1.topAnchor.constraint(equalTo: stack1.topAnchor, constant: 10),
            label1.bottomAnchor.constraint(equalTo: stack1.bottomAnchor, constant: 10),
         
            button2.widthAnchor.constraint(equalTo: stack1.heightAnchor, multiplier: 0.45),
            button2.heightAnchor.constraint(equalTo: stack1.heightAnchor, multiplier: 0.45),
            button2.leadingAnchor.constraint(equalTo: stack1.leadingAnchor, constant: 10),
            
            label2.topAnchor.constraint(equalTo: stack2.topAnchor, constant: 10),
            label2.bottomAnchor.constraint(equalTo: stack2.bottomAnchor, constant: 10),
            
            stack1.topAnchor.constraint(equalTo: stack3.topAnchor),
            stack1.leadingAnchor.constraint(equalTo: stack3.leadingAnchor),
            stack1.trailingAnchor.constraint(equalTo: stack3.trailingAnchor),
            
            stack2.leadingAnchor.constraint(equalTo: stack3.leadingAnchor),
            stack2.trailingAnchor.constraint(equalTo: stack3.trailingAnchor),
            stack2.bottomAnchor.constraint(equalTo: stack3.bottomAnchor, constant: 10),
            
            stack3.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stack3.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stack3.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stack3.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        button1.tag = 1
        button2.tag = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BoxView:UIView{
    
    let image:UIImageView = {
       let image = UIImageView(image: UIImage(systemName: "checkmark"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isHidden = true
        return image
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        
        tintColor = .systemBlue
        
        addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor)
                                    ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class startButton:UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        self.layer.cornerRadius = 15
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.numberOfLines = 2
        titleLabel?.adjustsFontForContentSizeCategory = true
        contentHorizontalAlignment = .left
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 0, right:0)
        titleLabel?.adjustsFontSizeToFitWidth = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupText(first:String, second:String)->NSAttributedString{
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 10
        paragraph.alignment = .left
        let attributedText = NSMutableAttributedString(string: "\(first) \n", attributes: [.font : UIFont.preferredFont(forTextStyle: .headline), .paragraphStyle:paragraph, .foregroundColor:UIColor.black.cgColor])
        let toAddText = NSAttributedString(string: second, attributes: [.font : UIFont.preferredFont(forTextStyle: .footnote), .foregroundColor:UIColor.lightGray.cgColor, .paragraphStyle:paragraph])
        attributedText.append(toAddText)
        return attributedText
    }
}

class PasswordButton:UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0.5
        setTitleColor(Constants.buttonColor, for: .normal)
        backgroundColor = .white
        layer.borderColor = UIColor.systemGray.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.adjustsFontSizeToFitWidth = true
        layer.cornerRadius = 1
        titleLabel?.minimumScaleFactor = 0.1
        titleLabel?.font = .systemFont(ofSize: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AssistanceView:UIView{
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondaryLabel.cgColor
        backgroundColor = .white
        tintColor = .systemBlue
  
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func typePassword(){
        backgroundColor = .systemGray
    }
    
    func backSpace(){
        backgroundColor = .white
    }
}

