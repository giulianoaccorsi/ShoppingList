//
//  CEPViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol CEPViewControllerProtocol: AnyObject {
    func displayNextStage(viewModel: CEP.NextSage.ViewModel)
}

final class CEPViewController: UIViewController {
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
        label.text = "Qual é o seu CEP?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)

        return label
    }()

    private lazy var cepTextfield: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
                                            placeholder: "00000-000",
                                            label: "CEP",
                                            incorrectLabel: "Precisamos de um CEP válido",
                                            type: .cep))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let interactor: CEPInteractorProtocol
    private let stage: StageRegister = .fourthStage

    init(interactor: CEPInteractorProtocol) {
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
        cepTextfield.delegate = self
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
        let cep = cepTextfield.textTextField
        let request = CEP.NextSage.Request(cep: cep)
        interactor.getCEP(request: request)
    }
}

extension CEPViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(continueButton)
        view.addSubview(stageLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(cepTextfield)
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

            cepTextfield.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            cepTextfield.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            cepTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cepTextfield.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setUpAdditionalConfiguration() {
        view.backgroundColor = .backgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension CEPViewController: CustomTextfieldProtocol {
    func regexOK() {
        continueButton.isEnabled = true
        continueButton.backgroundColor = .buttonColor
    }

    func regexError() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = .lightGray
    }
}

extension CEPViewController: CEPViewControllerProtocol {
    func displayNextStage(viewModel: CEP.NextSage.ViewModel) {
        let viewController = AddressFactory.make(cepModel: viewModel.cepModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
