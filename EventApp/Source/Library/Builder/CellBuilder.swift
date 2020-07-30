//
//  CellBuilder.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 29/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit


struct CellBuilder {
    
    func makeTitleSubtitleCellViewModel(
        _ cellType: TitleSubtitleCellViewModel.CellType,
        onCellUpdate: (() -> Void)? = nil
    ) -> TitleSubtitleCellViewModel {
        switch cellType {
            
        case .text:
            return TitleSubtitleCellViewModel(
                title: "Name",
                subTitle: "",
                placeholder: "Add name",
                type: .text,
                onCellUpdate: onCellUpdate
            )
        case .date:
            return TitleSubtitleCellViewModel(
                title: "Date",
                subTitle: "",
                placeholder: "Add a date",
                type: .date,
                onCellUpdate: onCellUpdate
            )
        case .image:
            return TitleSubtitleCellViewModel(
                title: "Background",
                subTitle: "",
                placeholder: "",
                type: .image,
                onCellUpdate: onCellUpdate
            )
        }
    }
}
