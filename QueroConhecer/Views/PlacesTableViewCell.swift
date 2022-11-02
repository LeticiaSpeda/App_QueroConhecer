//
//  PlacesTableViewCell.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 01/11/22.
//

import UIKit

final class PlacesTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: PlacesTableViewCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "teste"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        
        ])
    }
    
    private func configureStyle() {
        accessoryType = .disclosureIndicator
        backgroundColor = .white
    }
    
}
