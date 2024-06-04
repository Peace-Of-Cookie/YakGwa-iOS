//
//  YakGwaPrimaryButton.swift
//
//
//  Created by Kim Dongjoo on 6/3/24.
//

import UIKit
import Util

public class YakGwaPrimaryButton: UIButton, UIComponentBased {
    
    /// 버튼 타이틀
    public var title: String = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func attribute() {
        self.titleLabel?.font = UIFont.sb14
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = UIColor.primary700
        self.layer.cornerRadius = 12
    }
    
    public func layout() {
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
}
