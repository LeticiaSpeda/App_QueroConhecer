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
//    
//    private lazy var viewHome: UIView = {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }()
    
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
//        addSubview(viewHome)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
//            viewHome.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
//            viewHome.leadingAnchor.constraint(equalTo: leadingAnchor),
//            viewHome.trailingAnchor.constraint(equalTo: trailingAnchor),
//            viewHome.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureStyle() {
        accessoryType = .disclosureIndicator
        backgroundColor = .white
    }
}
