//
//  File.swift
//  
//
//  Created by Ekko on 5/29/24.
//

import UIKit

import CoreKit

public final class LoginViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Yakgwa_Title", in: .module, with: nil)
        return imageView
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Kakao_Login_Button", in: .module, with: nil), for: .normal)
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Apple_Login_Button", in: .module, with: nil), for: .normal)
        return button
    }()
    
    private lazy var loginButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kakaoLoginButton, appleLoginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Initializers
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Layout
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(104)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(loginButtonStack)
        loginButtonStack.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-32)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
