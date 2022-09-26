//
//  FifthViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit
import Lottie

protocol AddressViewControllerProtocol: AnyObject {
    func displayAddress(viewModel: Address.GetAddress.ViewModel)
    func displayNextStage(viewModel: Address.NextStage.ViewModel)
    func showLoading()
    func hideLoading()
    func onError(message: String)
}

final class AddressViewController: UIViewController {
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Continuar", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tappedContinue), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .buttonColor

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
        label.text = "Insira seu endereço"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)

        return label
    }()

    private lazy var stateTextField: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
            placeholder: "São Paulo",
            label: "Estado",
            incorrectLabel: "",
            type: .other))
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var ufTextField: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
            placeholder: "SP",
            label: "UF",
            incorrectLabel: "",
            type: .other))
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var streetViewController: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
            placeholder: "Rua Bela Cintra",
            label: "Endereço",
            incorrectLabel: "",
            type: .other))
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var districtTextField: CustomTextfield = {
        let textField = CustomTextfield(status: TextFieldCompletion(
            placeholder: "Consolação",
            label: "Bairro",
            incorrectLabel: "",
            type: .other))
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stateTextField,
                                                   ufTextField,
                                                   streetViewController,
                                                   districtTextField])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()

    private let loadingView: LoadingView = {
        let image = LoadingView()
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private let stage: StageRegister = .fivethStage
    private let interactor: AddressInteractor

    init(interactor: AddressInteractor) {
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
        interactor.loadCep(request: Address.GetAddress.Request())
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
        let cep = Cep(logradouro: streetViewController.textTextField,
                      bairro: districtTextField.textTextField,
                      localidade: stateTextField.textTextField,
                      uf: ufTextField.textTextField)
        let request = Address.NextStage.Request(cep: cep)
        interactor.nextStage(request: request)
    }
}

extension AddressViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(continueButton)
        view.addSubview(stageLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(loadingView)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            stageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),

            welcomeLabel.leadingAnchor.constraint(equalTo: stageLabel.leadingAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: stageLabel.bottomAnchor, constant: 4),

            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.heightAnchor.constraint(equalToConstant: 250),

            continueButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            continueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            continueButton.heightAnchor.constraint(equalToConstant: 40),

            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }

    func setUpAdditionalConfiguration() {
        view.backgroundColor = .backgroundColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension AddressViewController: CustomTextfieldProtocol {
    func regexOK() {
        continueButton.isEnabled = true
        continueButton.backgroundColor = .buttonColor
    }

    func regexError() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = .lightGray
    }
}

extension AddressViewController: AddressViewControllerProtocol {
    func displayAddress(viewModel: Address.GetAddress.ViewModel) {
        DispatchQueue.main.async {
            let cep = viewModel.address.cepModel
            self.stateTextField.textTextField = cep.localidade
            self.ufTextField.textTextField = cep.uf
            self.streetViewController.textTextField = cep.logradouro
            self.districtTextField.textTextField = cep.bairro
        }
    }

    func showLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
            self.loadingView.load()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.loadingView.stop()
        }
    }

    func onError(message: String) {

    }

    func displayNextStage(viewModel: Address.NextStage.ViewModel) {
        let viewController = PasswordFactory.make(addressModel: viewModel.address)
        navigationController?.pushViewController(viewController, animated: true)

    }
}
