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
    var imagePickerController = UIImagePickerController()
    var cell: GameCoverCell?
    
    // MARK: - FormFields
    lazy var imageFormItem: CustomFormItem = {
        let instance = CustomFormItem()
        instance.createCell = { [weak self] _ in
            self?.cell = try GameCoverCell.createCell()
            self?.cell?.selectImageDelegate = self
            
            return self?.cell ?? UITableViewCell()
        }
        
        return instance
    }()
    
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
                        return OptionRowModel(platform.name ?? "", platform.id!)
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
        
        builder += imageFormItem
        builder += SectionHeaderViewFormItem()
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
            let name = nameFormItem.value
            guard
                let platformId = platformPickerFormItem.selected?.identifier,
                let imageData = cell?.cover.image?.jpegData(compressionQuality: 0.0)
            else { return}
            
            let model = GameEditModel(
                id: gameId,
                name: name,
                cover: imageData,
                platformId: platformId)
            
            viewModel?.save(data: model)
            
            break
        case .invalid:
            break
        }
    }
}

extension EditGameViewController: SelectImageDelegate {
    func didTapSelect() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePickerController.delegate = self
            imagePickerController.sourceType = .savedPhotosAlbum
            imagePickerController.allowsEditing = false

            present(imagePickerController, animated: true, completion: nil)
        }
    }
}

extension EditGameViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)

        if let chosenImage = info[.originalImage] as? UIImage{
            cell?.cover.image = chosenImage
        }
    }
}
