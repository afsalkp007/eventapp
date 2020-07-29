//
//  TitleSubtitleCell.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit


final class TitleSubtitleCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    private let constant: CGFloat = 15
    
    private let datePickerView = UIDatePicker()
    private let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    private let photoImageView = UIImageView()
    
    private var viewModel: TitleSubtitleCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func update(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subTitle
        subtitleTextField.placeholder = viewModel.placeholder
        
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolBar
        
        photoImageView.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image
        
        photoImageView.image = viewModel.image
    }
    
    private func setupViews() {
        verticalStackView.axis = .vertical
//        verticalStackView.alignment = .fill
//        verticalStackView.distribution = .fillProportionally
        verticalStackView.spacing = viewModel?.type == .image ? 15 : verticalStackView.spacing
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        verticalStackView.isLayoutMarginsRelativeArrangement = true
        verticalStackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        [verticalStackView, titleLabel, subtitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        toolBar.setItems([doneButton], animated: false)
        datePickerView.datePickerMode = .date
        photoImageView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        photoImageView.layer.cornerRadius = 10
        photoImageView.clipsToBounds = true
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: leftAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: rightAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        photoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func tappedDone() {
        viewModel?.udpate(datePickerView.date)
    }
    
    func heightForRow() {
        
    }
}
