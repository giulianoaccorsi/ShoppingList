//
//  LoginViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func displayHome(viewModel: Login.Firebase.ViewModel)
}

final class LoginViewController: UIViewController {
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Fazer Login", for: .normal)
        button.tintColor = .white
        button.isEnabled = false
        button.addTarget(self, action: #selector(tappedContinue), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray

        return button
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .title
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Acesse sua conta"

        return label
    }()

    private lazy var emailTextfield: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
            placeholder: "Digite seu email",
            label: "E-mail",
            incorrectLabel: "E-mail inválido",
            type: .email))
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var passwordTextfield: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
            placeholder: "Digite sua senha",
            label: "Senha",
            incorrectLabel: "Senha precisa possuir no mínimo 8 digítos",
            type: .password))
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private let interactor: LoginInteractorProtocol

    init(interactor: LoginInteractorProtocol) {
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
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc private func tappedContinue() {
        let request = Login.Firebase.Request(
            email: emailTextfield.textTextField,
            password: passwordTextfield.textTextField
        )
        interactor.login(request: request)
    }
}

extension LoginViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(continueButton)
        view.addSubview(welcomeLabel)
        view.addSubview(emailTextfield)
        view.addSubview(passwordTextfield)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            continueButton.heightAnchor.constraint(equalToConstant: 48),

            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),

            emailTextfield.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            emailTextfield.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            emailTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextfield.heightAnchor.constraint(equalToConstant: 40),

            passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 40),
            passwordTextfield.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            passwordTextfield.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setUpAdditionalConfiguration() {
        view.backgroundColor = .backgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension LoginViewController: CustomTextfieldProtocol {
    func regexOK() {
        if !emailTextfield.textTextField.isEmpty && !passwordTextfield.textTextField.isEmpty {
            continueButton.isEnabled = true
            continueButton.backgroundColor = .buttonColor
        }
    }

    func regexError() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = .lightGray
    }
}
extension LoginViewController: LoginViewControllerProtocol {
    func displayHome(viewModel: Login.Firebase.ViewModel) {
        switch viewModel {
        case .success:
            let viewController = LoggedFactory.make()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:
                                                                            UIColor.title ?? UIColor()]
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        case .failure(error: let errorString):
            let alert = UIAlertController(title: "Erro :(",
                                          message: errorString,
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in}
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
