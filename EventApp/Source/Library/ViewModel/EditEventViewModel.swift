//
//  EditEventViewModel.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 02/08/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

final class EditEventViewModel {
    
    enum Mode {
        case add
        case edit(Event)
    }
    
    let title = "Edit"
    var onUpdate: (() -> Void)?
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    
    weak var coordinator: EditEventCoordinator?
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    
    private let cellBuilder: CellBuilder
    private let eventService: EventServiceProtocol
    private let event: Event
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter
    }()
    
    init(
        event: Event,
        cellBuilder: CellBuilder,
        eventService: EventServiceProtocol = EventService()
    ) {
        self.event = event
        self.cellBuilder = cellBuilder
        self.eventService = eventService
    }
    
    func viewDidLoad() {
        setupCells()
        onUpdate?()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
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
        guard
            let name = nameCellViewModel?.subTitle,
            let dateString = dateCellViewModel?.subTitle,
            let image = backgroundImageCellViewModel?.image,
            let date = dateFormatter.date(from: dateString)
            else { return }
        eventService.perform(
            .update(event),
            data: EventService.EventInputData(
                name: name,
                date: date,
                image: image
            )
        )
        coordinator?.didFinishUpdateEvent()
    }
    
    func updateCell(indexPath: IndexPath, subTitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleViewModel):
            titleSubtitleViewModel.update(subTitle)
        }
    }
}

private extension EditEventViewModel {
    func setupCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate?()
        }
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self] in
            self?.onUpdate?()
        }
        
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
        
        guard
            let name = event.name,
            let date = event.date,
            let imageData = event.image,
            let image = UIImage(data: imageData)
            else { return }
        nameCellViewModel.update(name)
        dateCellViewModel.udpate(date)
        backgroundImageCellViewModel.update(image)
    }
}
