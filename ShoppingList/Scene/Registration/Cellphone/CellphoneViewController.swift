//
//  CellphoneViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol CellphoneViewControllerProtocol: AnyObject {
    func displayNextStage(viewModel: Cellphone.NextStage.ViewModel)
}
final class CellphoneViewController: UIViewController {

    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Continuar", for: .normal)
        button.tintColor = .white
        button.isEnabled = false
        button.addTarget(self, action: #selector(tappedContinue), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray

        return button
    }()

    private let stageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)

        return label
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Qual é o seu celular?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)

        return label
    }()

    private lazy var cellphoneTextfield: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
                                            placeholder: "(XX) XXXX-XXXX",
                                            label: "Celular",
                                            incorrectLabel: "Precisamos de um celular válido",
                                            type: .numero))
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let stage: StageRegister = .thirdStage
    private let interactor: CellphoneInteractorProtocol

    init(interactor: CellphoneInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        cellphoneTextfield.delegate = self
        stageLabel.text = stage.description.label
        stageLabel.attributedText = NSMutableAttributedString(fullString: stageLabel.text ?? "",
                                                              fullStringColor: UIColor.label,
                                                              subString: stage.description.textWithColor,
                                                              subStringColor: .title ?? UIColor())
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc func tappedContinue() {
        let request = Cellphone.NextStage.Request(cellphoneNumber: cellphoneTextfield.textTextField)
        interactor.nextStage(request: request)
    }
}

extension CellphoneViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(continueButton)
        view.addSubview(stageLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(cellphoneTextfield)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            continueButton.heightAnchor.constraint(equalToConstant: 48),

            stageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),

            welcomeLabel.leadingAnchor.constraint(equalTo: stageLabel.leadingAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: stageLabel.bottomAnchor, constant: 4),

            cellphoneTextfield.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            cellphoneTextfield.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            cellphoneTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cellphoneTextfield.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setUpAdditionalConfiguration() {
        view.backgroundColor = .backgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension CellphoneViewController: CustomTextfieldProtocol {
    func regexOK() {
        continueButton.isEnabled = true
        continueButton.backgroundColor = .buttonColor
    }

    func regexError() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = .lightGray
    }
}

extension CellphoneViewController: CellphoneViewControllerProtocol {
    func displayNextStage(viewModel: Cellphone.NextStage.ViewModel) {
        let viewController = CEPFactory.make(cellphone: viewModel.cellphoneModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
