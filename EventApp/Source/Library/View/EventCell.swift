//
//  EventCell.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 30/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit


final class EventCell: UITableViewCell {
    
    private let timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    private let dateLabel = UILabel()
    
    private let eventNameLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        (timeRemainingLabels + [dateLabel, eventNameLabel, backgroundImageView, verticalStackView]).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        timeRemainingLabels.forEach {
            $0.font = .systemFont(ofSize: 28, weight: .semibold)
            $0.textColor = .white
        }
        
        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
        
        eventNameLabel.font = .systemFont(ofSize: 34, weight: .bold)
        eventNameLabel.textColor = .white
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
    }
    
    private func setupHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
        
        timeRemainingLabels.forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperViewEdges([.left, .top, .right])
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        
        backgroundImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackView.pinToSuperViewEdges([.top, .right, .bottom], constant: 15)
        eventNameLabel.pinToSuperViewEdges([.left, .bottom], constant: 15)
    }
    
    func update(with viewModel: EventCellViewModel) {
        timeRemainingLabels.forEach {
            $0.text = ""
        }
        viewModel.timeRemainingStrings.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        
        viewModel.loadImage(completion: { image in
            self.backgroundImageView.image = image
        })
     
    }
}
