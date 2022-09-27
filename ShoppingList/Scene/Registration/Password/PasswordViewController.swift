//
//  PasswordViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//
//
//  CEPViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol PasswordViewControllerProtocol: AnyObject {
    func displayRegisterUser(viewModel: Password.FinishRegister.ViewModel)
}

final class PasswordViewController: UIViewController {
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
        label.text = "Senha de Acesso"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)

        return label
    }()

    private lazy var passwordTextfield: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
                                            placeholder: "Sua senha",
                                            label: "Cria sua senha de acesso",
                                            incorrectLabel: "Pelo menos 8 caracteres",
                                            type: .password))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let interactor: PasswordInteractorProtocol
    private let stage: StageRegister = .sixthStage

    init(interactor: PasswordInteractorProtocol) {
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
        passwordTextfield.delegate = self
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
        let request = Password.FinishRegister.Request(password: passwordTextfield.textTextField)
        interactor.registerUser(request: request)
    }
}

extension PasswordViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(continueButton)
        view.addSubview(stageLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(passwordTextfield)
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

            passwordTextfield.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            passwordTextfield.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            passwordTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setUpAdditionalConfiguration() {
        view.backgroundColor = .backgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension PasswordViewController: CustomTextfieldProtocol {
    func regexOK() {
        continueButton.isEnabled = true
        continueButton.backgroundColor = .buttonColor
    }

    func regexError() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = .lightGray
    }
}

extension PasswordViewController: PasswordViewControllerProtocol {
    func displayRegisterUser(viewModel: Password.FinishRegister.ViewModel) {
        switch viewModel {
        case .sucess:
            let alert = UIAlertController(title: "Cadastro",
                                          message: "Seu cadastro foi concluido com sucesso! 😊",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                self.dismiss(animated: true)
            }
            alert.addAction(okAction)
            present(alert, animated: true)

        case .failure(error: let error):
            let alert = UIAlertController(title: "Erro",
                                          message: error,
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                self.dismiss(animated: true)
            }
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
}
