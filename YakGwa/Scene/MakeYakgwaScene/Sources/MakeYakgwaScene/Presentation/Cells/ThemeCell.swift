//
//  ThemeCell.swift
//
//
//  Created by Ekko on 6/4/24.
//

import UIKit

import Common

final class ThemeCell: UICollectionViewCell {
    static let identifier = "ThemeCell"
    
    private let themeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Yakgwa_Theme_Default", in: .module, with: nil)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.m12
        label.textColor = .neutralBlack
        label.text = "테마명"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        themeImageView.image = nil
        themeLabel.text = nil
    }
    
    private func setUI() {
        self.contentView.layer.cornerRadius = 12
        self.contentView.backgroundColor = .neutralWhite
        
        self.contentView.addSubview(themeImageView)
        themeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
        }
        
        self.contentView.addSubview(themeLabel)
        themeLabel.snp.makeConstraints {
            $0.top.equalTo(themeImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-8)
            $0.centerX.equalToSuperview()
        }
    }
    
    func configure(with theme: MeetTheme) {
        themeLabel.text = theme.name
    }
}
