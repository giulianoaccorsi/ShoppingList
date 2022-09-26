//
//  ViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit

protocol RegisterViewControllerProtocol: AnyObject {
    func tappedNextStage(viewModel: RegisterScenarios.NextStage.ViewModel)
    func tappedDismiss(viewModel: RegisterScenarios.Dismiss.ViewModel)
}

final class RegisterViewController: UIViewController {

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Continuar", for: .normal)
        button.tintColor = .white
        button.isEnabled = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(tappedNextStageButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray

        return button

    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Já tem conta? Acesse Agora!", for: .normal)
        button.tintColor = .buttonColor
        button.addTarget(self, action: #selector(tappedDismissButton), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false

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
        label.text = "Seja bem vindo(a)"

        return label
    }()

    private let emailTextfield: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
                                            placeholder: "Digite seu email",
                                            label: "Qual é o seu e-mail?",
                                            incorrectLabel: "Precisamos de um email válido",
                                            type: .email))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let interactor: RegisterInteractorProtocol
    private let stage: StageRegister = .firstStage
    init(interactor: RegisterInteractorProtocol) {
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
        stageLabel.text = stage.description.label
        stageLabel.attributedText = NSMutableAttributedString(fullString: stageLabel.text ?? "",
                                                              fullStringColor: UIColor.label,
                                                              subString: stage.description.textWithColor,
                                                              subStringColor: .title ?? UIColor())
    }

    @objc func tappedDismissButton() {
        let request = RegisterScenarios.Dismiss.Request()
        interactor.dissmiss(request: request)
    }

    @objc func tappedNextStageButton() {
        let request = RegisterScenarios.NextStage.Request(email: emailTextfield.textTextField)
        interactor.nextStage(request: request)
    }

}

extension RegisterViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        view.addSubview(stageLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(emailTextfield)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            signUpButton.heightAnchor.constraint(equalToConstant: 48),

            signInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -4),
            signInButton.leadingAnchor.constraint(equalTo: signUpButton.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 40),

            stageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),

            welcomeLabel.leadingAnchor.constraint(equalTo: stageLabel.leadingAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: stageLabel.bottomAnchor, constant: 4),

            emailTextfield.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            emailTextfield.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            emailTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextfield.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setUpAdditionalConfiguration() {
        view.backgroundColor = .backgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension RegisterViewController: RegisterViewControllerProtocol {
    func tappedNextStage(viewModel: RegisterScenarios.NextStage.ViewModel) {
        let viewController = CPFFactory.make(email: viewModel.email)
        navigationController?.pushViewController(viewController, animated: true)

    }

    func tappedDismiss(viewModel: RegisterScenarios.Dismiss.ViewModel) {
        self.dismiss(animated: true)
    }
}

extension RegisterViewController: CustomTextfieldProtocol {
    func regexOK() {
        signInButton.isEnabled = true
        signInButton.backgroundColor = .buttonColor
    }

    func regexError() {
        signInButton.isEnabled = false
        signInButton.backgroundColor = .lightGray
    }
}
