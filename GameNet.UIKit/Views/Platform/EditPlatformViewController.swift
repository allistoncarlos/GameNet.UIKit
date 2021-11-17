//
//  EditPlatformViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 17/10/21.
//

import Foundation
import UIKit
import SwiftyFORM

protocol EditPlatformViewControllerDelegate {
    func savedData()
}

class EditPlatformViewController: FormViewController {
    // MARK: - Properties
    var platformId: String?
    var viewModel: EditPlatformViewModelProtocol?
    var delegate: EditPlatformViewControllerDelegate?
    
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
        
        if let platformId = platformId {
            viewModel?.renderData = { [weak self] in
                DispatchQueue.main.async {
                    if let data = self?.viewModel?.apiResult?.data {
                        self?.nameFormItem.value = data.name
                        
                        self?.setupModalNavigationBar(title: data.name)
                    }
                }
            }
            
            viewModel?.fetchData(id: platformId)
        } else {
            self.setupModalNavigationBar(title: Constants.editPlatformViewTitle)
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
            viewModel?.save(id: platformId, data: PlatformModel(
                id: platformId,
                name: nameFormItem.value))
        case .invalid:
            break
        }
    }
}
