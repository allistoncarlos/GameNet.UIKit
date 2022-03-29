//
//  ListDetailViewModel.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 29/03/22.
//

import Foundation

protocol ListDetailViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var apiResult: APIResult<[ListItemModel]>? { get set }
    var listType: ListType { get set }

    func fetchData(id: String)
}

class ListDetailViewModel: ObservableObject, ListDetailViewModelProtocol {
    private var service: ListServiceProtocol?

    var apiResult: APIResult<[ListItemModel]>? {
        didSet {
            renderData?()
        }
    }

    var listType: ListType = .custom

    var renderData: (() -> Void)?
    var savedData: (() -> Void)?

    init(service: ListServiceProtocol?) {
        self.service = service
    }

    func fetchData(id: String) {
        switch listType {
        case .finishedByYear:
            fetchFinishedByYearData(id: id)
        case .boughtByYear:
            fetchBoughtByYearData(id: id)
        case .custom:
            fetchCustomListData(id: id)
        }
    }

    private func fetchFinishedByYearData(id: String) {
        service?.getFinishedByYear(id: id) { result in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchBoughtByYearData(id: String) {
        service?.getBoughtByYear(id: id) { result in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchCustomListData(id: String) {

    }
}
