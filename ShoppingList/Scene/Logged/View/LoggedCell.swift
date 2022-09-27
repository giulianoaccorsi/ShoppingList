//
//  LoggedCell.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 27/09/22.
//

import UIKit

class LoggedCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "banana")
        return image
    }()

    let nameLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.text = "Banana"
        title.textColor = .text
        return title
    }()

    let quantityLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.text = "99"
        title.textColor = .title
        return title
    }()

    let descriptionLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.text = "R$ 1.75 p/ unidade"
        title.font = UIFont.preferredFont(forTextStyle: .footnote)
        title.textColor = .lightGray
        return title
    }()

    let priceLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.text = "R$ 8.75"
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 20)
        title.textColor = .title
        return title
    }()

    private lazy var stackViewNames: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, quantityLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewNames, descriptionLabel, priceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    private let viewRounded: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .border
        view.clipsToBounds = true

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUpView()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
    }
}

extension LoggedCell: ViewConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(viewRounded)
        viewRounded.addSubview(imageView)
        viewRounded.addSubview(stackViewNames)
        viewRounded.addSubview(descriptionLabel)
        viewRounded.addSubview(priceLabel)
    }

    func setUpConstraints() {
        let height = contentView.frame.height
        let resistencePriorityHigher = UILayoutPriority(rawValue: 751)

        quantityLabel.setContentCompressionResistancePriority(resistencePriorityHigher, for: .horizontal)

        NSLayoutConstraint.activate([
            viewRounded.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewRounded.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewRounded.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            viewRounded.topAnchor.constraint(equalTo: contentView.topAnchor),

            imageView.topAnchor.constraint(equalTo: viewRounded.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: viewRounded.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: viewRounded.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: height/2),

            stackViewNames.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            stackViewNames.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 4),
            stackViewNames.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -4),

            descriptionLabel.leadingAnchor.constraint(equalTo: stackViewNames.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: viewRounded.trailingAnchor, constant: -4),
            descriptionLabel.topAnchor.constraint(equalTo: stackViewNames.bottomAnchor, constant: 4),

            priceLabel.leadingAnchor.constraint(equalTo: viewRounded.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: viewRounded.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)

        ])
    }

    func setUpAdditionalConfiguration() {
    }
}
