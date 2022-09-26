//
//  ViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit
import Lottie

protocol HomeViewControllerProtocol: AnyObject {
    func displayRegister(viewModel: HomeScenarios.Register.ViewModel)
    func displayLogin(viewModel: HomeScenarios.Login.ViewModel)
}

final class HomeViewController: UIViewController {
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Acessar Conta", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(tappedLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .buttonColor

        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Ainda não tem conta? Crie Agora!", for: .normal)
        button.tintColor = .buttonColor
        button.addTarget(self, action: #selector(tappedRegister), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let groceryImage: AnimationView = {
        let image = AnimationView(name: "lottie-food")
        image.loopMode = .loop
        image.play()
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "Shopping List"

        return label
    }()

    private let interactor: HomeInteractorProtocol

    init(interactor: HomeInteractorProtocol) {
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groceryImage.play()
    }

    @objc func tappedRegister() {
        let request = HomeScenarios.Register.Request()
        interactor.tappedRegister(request: request)
    }

    @objc func tappedLogin() {
        let request = HomeScenarios.Login.Request()
        interactor.tappedLogin(request: request)
    }

}

extension HomeViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        view.addSubview(groceryImage)
        view.addSubview(welcomeLabel)
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

            welcomeLabel.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -100),
            welcomeLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),

            groceryImage.bottomAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: 8),
            groceryImage.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            groceryImage.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor),
            groceryImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)

        ])
        let huggingPriorityLower = UILayoutPriority(rawValue: 251)
        welcomeLabel.setContentHuggingPriority(huggingPriorityLower, for: .vertical)
    }

    func setUpAdditionalConfiguration() {
        view.backgroundColor = .backgroundColor
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func displayLogin(viewModel: HomeScenarios.Login.ViewModel) {
        let viewController = LoginFactory.make()
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        present(viewController, animated: true)
    }

    func displayRegister(viewModel: HomeScenarios.Register.ViewModel) {
        let viewController = RegisterFactory.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .title
        navigationController.modalTransitionStyle = .coverVertical
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}
