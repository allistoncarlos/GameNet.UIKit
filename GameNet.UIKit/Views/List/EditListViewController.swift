//
//  EditListViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 22/11/21.
//

import Foundation
import UIKit
import SwiftyFORM

protocol EditListViewControllerDelegate {
    func savedData()
}

class EditListViewController: FormViewController, StoryboardCoordinated {
    // MARK: - Properties
    var listId: String?
    var viewModel: EditListViewModelProtocol?
    var delegate: EditListViewControllerDelegate?
    
    // MARK: - FormFields
    lazy var nameFormItem: TextFieldFormItem = {
        let instance = TextFieldFormItem()
        instance.required("Nome é obrigatório")
        instance.title = "Nome"
        
        return instance
    }()
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.savedData = { [weak self] in
            DispatchQueue.main.async {
                self?.delegate?.savedData()
            }
        }
        
        if let listId = listId {
            viewModel?.renderData = { [weak self] in
                DispatchQueue.main.async {
                    if let data = self?.viewModel?.apiResult?.data,
                        let name = data.name {
                        self?.nameFormItem.value = name
                        
                        self?.setupModalNavigationBar(title: name)
                    }
                }
            }
            
            viewModel?.fetchData(id: listId)
        } else {
            self.setupModalNavigationBar(title: Constants.editListViewTitle)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - FormViewController
    override func populate(_ builder: FormBuilder) {
        lazy var saveButton: ButtonFormItem = {
            let instance = ButtonFormItem()
            instance.title("Salvar")
            instance.backgroundColor(Constants.primaryColor)
            instance.action = { [weak self] in
                self?.save()
            }
            
            return instance
        }()
        
        builder += nameFormItem
        builder += SectionFooterViewFormItem()
        
        builder += saveButton
    }
    
    // MARK: - Private funcs
    private func save() {
        formBuilder.validateAndUpdateUI()
        let result = formBuilder.validate()
        
        switch result {
        case .valid:
            viewModel?.save(id: listId, data: ListModel(
                id: listId,
                name: nameFormItem.value))
        case .invalid:
            break
        }
    }
}
