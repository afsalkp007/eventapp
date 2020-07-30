//
//  TitleSubtitleCellViewModel.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit


final class TitleSubtitleCellViewModel {
    
    enum CellType {
        case text
        case date
        case image
    }
    
    let title: String
    private(set) var subTitle: String
    private(set) var image: UIImage?
    let placeholder: String
    let type: CellType
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    private(set) var onCellUpdate: (() -> Void)?
    
    init(title: String, subTitle: String, placeholder: String, type: CellType, onCellUpdate: (() -> Void)?) {
        self.title = title
        self.subTitle = subTitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    func update(_ subtitle: String) {
        self.subTitle = subtitle
    }
    
    func udpate(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subTitle = dateString
        onCellUpdate?()
    }
    
    func update(_ image: UIImage) {
        self.image = image
        onCellUpdate?()
    }
    
    func heightForRow() -> CGFloat {
        switch type {
        case .image:
            return 265.0
        default:
            return 80.0
        }
    }
}
