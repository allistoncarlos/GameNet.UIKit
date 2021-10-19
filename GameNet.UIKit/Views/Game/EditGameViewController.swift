//
//  EditGameViewController.swift
//  GameNet.UIKit
//
//  Created by Alliston Aleixo on 19/10/21.
//

import Foundation
import UIKit
import SwiftyFORM

protocol EditGameViewControllerDelegate {
    func savedData()
}

class EditGameViewController: FormViewController {
    // MARK: - Properties
    var gameId: String?
    var viewModel: EditGameViewModelProtocol?
    var delegate: EditGameViewControllerDelegate?
    
    // MARK: - FormFields
    lazy var nameFormItem: TextFieldFormItem = {
        let instance = TextFieldFormItem()
        instance.required("Nome é obrigatório")
        instance.title = "Nome"
        
        return instance
    }()
    
    lazy var platformPickerFormItem: OptionPickerFormItem = {
        let instance = OptionPickerFormItem()
        instance.title = "Plataforma"

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
        
        viewModel?.renderPlatformsData = { [weak self] in
            DispatchQueue.main.async {
                if let data = self?.viewModel?.platformsResult?.data.result {
                    self?.platformPickerFormItem.options = data.map({ (platform) -> OptionRowModel in
                        return OptionRowModel(platform.name, platform.id!)
                    })
                }
            }
        }
        
        if let gameId = gameId {
            viewModel?.renderData = { [weak self] in
                DispatchQueue.main.async {
                    if let data = self?.viewModel?.apiResult?.data {
                        self?.nameFormItem.value = data.name

                        self?.setupModalNavigationBar(title: data.name)
                    }
                }
            }
            
            viewModel?.fetchData(id: gameId)
        } else {
            self.setupModalNavigationBar(title: Constants.editGameViewTitle)
        }
        
        viewModel?.fetchPlatforms()
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
        builder += platformPickerFormItem
        builder += SectionFooterViewFormItem()
        
        builder += saveButton
    }
    
    // MARK: - Private funcs
    private func save() {
        formBuilder.validateAndUpdateUI()
        let result = formBuilder.validate()
        
        switch result {
        case .valid:
//            viewModel?.save(id: gameId, data: GameModel(
//                id: gameId,
//                name: T##String,
//                cover: T##String,
//                platformId: T##String,
//                platform: T##String))
            break
        case .invalid:
            break
        }
    }
}
