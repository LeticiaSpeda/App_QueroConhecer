//
//  PlacesTableViewCell.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 01/11/22.
//

import UIKit

final class PlacesTableViewCell: UITableViewCell {
    static let identifier = String(describing: PlacesTableViewCell.self)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImage(named: "cellIcon")
        let imgView = UIImageView(image: image)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleToFill
        imgView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return imgView
    }()
    
    private lazy var mainHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        configureHierarchy()
        configureConstraints()
        configureStyle()
    }
    
    private func configureHierarchy() {
        addSubview(mainHStack)
        mainHStack.addArrangedSubview(image)
        mainHStack.addArrangedSubview(titleLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            mainHStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            mainHStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            mainHStack.rightAnchor.constraint(equalTo: rightAnchor),
            mainHStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    
    private func configureStyle() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        backgroundColor = .white
    }
}
