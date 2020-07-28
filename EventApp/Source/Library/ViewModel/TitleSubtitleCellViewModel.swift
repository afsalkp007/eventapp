//
//  TitleSubtitleCellViewModel.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import Foundation


final class TitleSubtitleCellViewModel {
    let title: String
    private(set) var subTitle: String
    let placeholder: String
    
    init(title: String, subTitle: String, placeholder: String) {
        self.title = title
        self.subTitle = subTitle
        self.placeholder = placeholder
    }
}
