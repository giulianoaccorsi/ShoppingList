//
//  CPFViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol CPFViewControllerProtocol: AnyObject {
    func tappedButton(viewModel: CPF.NextStage.ViewModel)
}
final class CPFViewController: UIViewController {

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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Dados Pessoais"

        return label
    }()

    private lazy var cpfTextField: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
                                            placeholder: "000.000.000-00",
                                            label: "Qual é seu CPF?",
                                            incorrectLabel: "CPF Inválido",
                                            type: .cpf))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var dateTextField: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
                                            placeholder: "DD/MM/AAAA",
                                            label: "E a sua data de nascimento",
                                            incorrectLabel: "Aqui precisamos de uma data válida",
                                            type: .date))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let stage: StageRegister = .secondStage
    private let interactor: CPFInteractorProtocol

    init(interactor: CPFInteractorProtocol) {
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
        cpfTextField.delegate = self
        dateTextField.delegate = self
        stageLabel.text = stage.description.label
        stageLabel.attributedText = NSMutableAttributedString(fullString: stageLabel.text ?? "",
                                                              fullStringColor: UIColor.label,
                                                              subString: stage.description.textWithColor,
                                                              subStringColor: .title ?? UIColor())
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc private func tappedContinue() {
        let request = CPF.NextStage.Request(userInformation:
                                                (cpf: cpfTextField.textTextField,
                                                 date: dateTextField.textTextField))
        interactor.getInformation(request: request)
    }
}

extension CPFViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(continueButton)
        view.addSubview(stageLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(cpfTextField)
        view.addSubview(dateTextField)
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

            cpfTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            cpfTextField.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            cpfTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cpfTextField.heightAnchor.constraint(equalToConstant: 40),

            dateTextField.topAnchor.constraint(equalTo: cpfTextField.bottomAnchor, constant: 40),
            dateTextField.leadingAnchor.constraint(equalTo: cpfTextField.leadingAnchor),
            dateTextField.trailingAnchor.constraint(equalTo: cpfTextField.trailingAnchor),
            dateTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setUpAdditionalConfiguration() {
        view.backgroundColor = .backgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension CPFViewController: CustomTextfieldProtocol {
    func regexOK() {
        if !cpfTextField.textTextField.isEmpty && !dateTextField.textTextField.isEmpty {
            continueButton.isEnabled = true
            continueButton.backgroundColor = .buttonColor
        }
    }

    func regexError() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = .lightGray
    }
}
extension CPFViewController: CPFViewControllerProtocol {
    func tappedButton(viewModel: CPF.NextStage.ViewModel) {
        let viewController = CellphoneFactory.make(cpfModel: viewModel.cpfModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
