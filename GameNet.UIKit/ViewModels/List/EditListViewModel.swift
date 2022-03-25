//
//  EditListViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 22/11/21.
//

import Foundation

protocol EditListViewModelProtocol: AnyObject {
    var renderData: (() -> Void)? { get set }
    var savedData: (() -> Void)? { get set }

    var apiResult: APIResult<ListModel>? { get set }

    func fetchData(id: String)
    func save(id: String?, data: ListModel)
}

class EditListViewModel: ObservableObject, EditListViewModelProtocol {
    private var service: ServiceBox<ListService>?

    var apiResult: APIResult<ListModel>? {
        didSet {
            renderData?()
        }
    }

    var renderData: (() -> Void)?
    var savedData: (() -> Void)?

    init(service: ServiceBox<ListService>?) {
        self.service = service
    }

    func fetchData(id: String) {
        service?.object.get(id: id, completion: { (result) in
            switch result {
            case .success(let apiResult):
                self.apiResult = apiResult
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    func save(id: String?, data: ListModel) {
        service?.object.save(id: id, model: data, completion: { (result) in
            switch result {
            case .success:
                self.savedData!()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
