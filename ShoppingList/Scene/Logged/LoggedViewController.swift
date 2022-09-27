//
//  LoggedViewController.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 26/09/22.
//

import UIKit
import Firebase

protocol LoggedViewControllerProtocol: AnyObject {
    func displaySomething(viewModel: Logged.Something.ViewModel)
}

final class LoggedViewController: UIViewController {

    private lazy var collection: UICollectionView = {
        let screeWidth: CGFloat = UIScreen.main.bounds.width / 2 - 15

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screeWidth, height: 1.5 * screeWidth)
        let colletion = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletion.backgroundColor = .backgroundColor
        colletion.translatesAutoresizingMaskIntoConstraints = false

        return colletion
    }()

    private let interactor: LoggedInteractorProtocol
    private lazy var dataSource = LoggedCollectionViewDataSource(collectionView: collection, delegate: self)

    init(interactor: LoggedInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        dataSource.setup()
    }

    private func doSomething() {
        let request = Logged.Something.Request()
        interactor.doSomething(request: request)
    }

    @objc private func tappedSettings() {
        let alert = UIAlertController(title: "Configurações",
                                      message: "Escolha uma opção",
                                      preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Sign Out", style: .default) { [weak self] _ in
            guard let self else { return }
            do {
                try Auth.auth().signOut()
                let viewController = HomeFactory.make()
                self.navigationController?.viewControllers = [viewController]

            } catch {
                print("Error Quit - \(error.localizedDescription)")
            }
        }
        let actionClearAll = UIAlertAction(title: "Limpar Tudo", style: .default)
        let cancelButton = UIAlertAction(title: "Cancelar", style: .destructive)

        alert.addAction(action)
        alert.addAction(actionClearAll)
        alert.addAction(cancelButton)

        present(alert, animated: true)
    }

    @objc private func tappedAdd() {
        let viewController = LoginFactory.make()
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        present(viewController, animated: true)
    }
}

extension LoggedViewController: LoggedViewControllerProtocol {
    func displaySomething(viewModel: Logged.Something.ViewModel) {
    }
}

extension LoggedViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(collection)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setUpAdditionalConfiguration() {
        view.backgroundColor = .backgroundColor
        navigationController?.navigationBar.tintColor = .title
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(tappedSettings))

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(tappedAdd))
        self.title = "Shopping List"
    }
}

extension LoggedViewController: LoggedCollectionViewDataSourceProtocol {

}
