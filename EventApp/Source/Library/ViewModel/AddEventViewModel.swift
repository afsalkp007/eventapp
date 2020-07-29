//
//  AddEventViewModel.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 28/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit


final class AddEventViewModel {
    
    let title = "Add"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    
    var coordinator: AddEventCoordinator?
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    
    func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func heightForRow(indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row] {
        case .titleSubtitle(let subtitleViewModel):
            return subtitleViewModel.heightForRow()
        }
    }
    
    func didSelectRow(_ indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else {
                return
            }
            coordinator?.showImagePicker(completion: { image in
                titleSubtitleCellViewModel.update(image)
            })
        }
    }
    
    func tappedDone() {
        print(#function)
    }
    
    func updateCell(indexPath: IndexPath, subTitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleViewModel):
            titleSubtitleViewModel.update(subTitle)
        }
    }
}

private extension AddEventViewModel {
    func setupCells() {
        nameCellViewModel = TitleSubtitleCellViewModel(title: "Name", subTitle: "", placeholder: "Add name", type: .text, onCellUpdate: {})
        dateCellViewModel = TitleSubtitleCellViewModel(title: "Date", subTitle: "", placeholder: "Add a date", type: .date, onCellUpdate: { [weak self] in
            self?.onUpdate()
        })
        backgroundImageCellViewModel = TitleSubtitleCellViewModel(title: "Background", subTitle: "", placeholder: "", type: .image, onCellUpdate: { [weak self] in
            self?.onUpdate()
        })
        
        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageCellViewModel = backgroundImageCellViewModel else { return }
        
        cells = [
            .titleSubtitle(
                nameCellViewModel
            ),
            .titleSubtitle(
                dateCellViewModel
            ),
            .titleSubtitle(
                backgroundImageCellViewModel
            )
        ]
    }
}






