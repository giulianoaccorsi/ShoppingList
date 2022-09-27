//
//  FloatingLabel.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit

enum TextFieldStatus {
    case isEditing
    case finishEditing
    case incorrectRegex
}

enum TextFieldType {
    case email
    case cpf
    case date
    case cep
    case numero
    case password
    case other
}

protocol CustomTextfieldProtocol: AnyObject {
    func regexOK()
    func regexError()
}

// swiftlint: disable all
class CustomTextfield: UIView {
    weak var delegate: CustomTextfieldProtocol?

    private let lineBorder: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.border?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4

        return view
    }()

    private let textField: UITextField = {
        let textfield = UITextField()
        textfield.clearButtonMode = .whileEditing
        textfield.autocapitalizationType = .none
        textfield.translatesAutoresizingMaskIntoConstraints = false

        return textfield
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = .backgroundColor
        label.textColor = UIColor.label

        return label
    }()

    private let incorrectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .wrong

        return label
    }()

    private var status: TextFieldCompletion

    var textTextField: String {
        get {
            return self.textField.text ?? ""
        }

        set {
            textField.text = newValue
        }
    }

    init(status: TextFieldCompletion) {
        self.status = status
        super.init(frame: .zero)
        setUpView()
        configureTextfields()
    }

    private func configureTextfields() {
        switch status.type {
        case .cpf:
            textField.keyboardType = .numberPad
        case .date:
            textField.keyboardType = .numberPad
        case .email:
            textField.keyboardType = .emailAddress
        case .cep:
            textField.keyboardType = .numberPad
        case .numero:
            textField.keyboardType = .numberPad
        case .other:
            textField.keyboardType = .default
        case .password:
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
        }
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func changedStatus(textfieldStatus: TextFieldStatus) {
        switch textfieldStatus {
        case .isEditing:
            lineBorder.layer.borderColor = UIColor.title?.cgColor
            incorrectLabel.isHidden = true
            label.textColor = .title
        case .finishEditing:
            lineBorder.layer.borderColor = UIColor.border?.cgColor
            incorrectLabel.isHidden = true
            label.textColor = UIColor.label
        case .incorrectRegex:
            incorrectLabel.isHidden = false
            lineBorder.layer.borderColor = UIColor.wrong.cgColor
            label.textColor = .wrong
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13, *), self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            lineBorder.layer.borderColor = UIColor.border?.cgColor
        }
    }
}

extension CustomTextfield: ViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(lineBorder)
        self.addSubview(label)
        self.addSubview(textField)
        self.addSubview(incorrectLabel)
    }

    func setUpConstraints() {
        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            lineBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineBorder.topAnchor.constraint(equalTo: self.topAnchor),
            lineBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            label.centerYAnchor.constraint(equalTo: lineBorder.topAnchor),
            label.leadingAnchor.constraint(equalTo: lineBorder.leadingAnchor, constant: 8),

            textField.leadingAnchor.constraint(equalTo: lineBorder.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: lineBorder.trailingAnchor, constant: -padding),
            textField.topAnchor.constraint(equalTo: lineBorder.topAnchor, constant: padding),
            textField.bottomAnchor.constraint(equalTo: lineBorder.bottomAnchor, constant: -padding),

            incorrectLabel.trailingAnchor.constraint(equalTo: lineBorder.trailingAnchor),
            incorrectLabel.topAnchor.constraint(equalTo: lineBorder.bottomAnchor, constant: 4)
        ])
    }

    func setUpAdditionalConfiguration() {
        textField.delegate = self
        incorrectLabel.isHidden = true

        textField.placeholder = status.placeholder
        label.text = "  \(status.label)  "
        incorrectLabel.text = status.incorrectLabel
    }
}

extension CustomTextfield: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changedStatus(textfieldStatus: .isEditing)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            switch status.type {
            case .email:
                if  text.isValidEmail() {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else if text.isEmpty {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else {
                    changedStatus(textfieldStatus: .incorrectRegex)
                    self.delegate?.regexError()

                }
            case .cpf:
                if text.isValidCPF() {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()

                } else if text.isEmpty {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else {
                    changedStatus(textfieldStatus: .incorrectRegex)
                    self.delegate?.regexError()
                }
            case .date:
                if text.isValidDate() {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else if text.isEmpty {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else {
                    changedStatus(textfieldStatus: .incorrectRegex)
                    self.delegate?.regexError()
                }
            case .cep:
                if text.isValidCEP() {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else if text.isEmpty {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else {
                    changedStatus(textfieldStatus: .incorrectRegex)
                    self.delegate?.regexError()
                }
            case .numero:
                if text.isValidNumber() {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else if text.isEmpty {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else {
                    changedStatus(textfieldStatus: .incorrectRegex)
                    self.delegate?.regexError()
                }
            case .other:
                changedStatus(textfieldStatus: .finishEditing)
            case .password:
                if text.isValidPassword() {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else if text.isEmpty {
                    changedStatus(textfieldStatus: .finishEditing)
                    self.delegate?.regexOK()
                } else {
                    changedStatus(textfieldStatus: .incorrectRegex)
                    self.delegate?.regexError()
                }
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // swiftlint: disable cyclomatic_complexity
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        var appendString = ""
        if status.type == .cpf {
            if range.length == 0 {
                switch range.location {
                case 3:
                    appendString = "."
                case 7:
                    appendString = "."
                case 11:
                    appendString = "-"
                default:
                    break
                }
            }

            textField.text?.append(appendString)

            if (textField.text?.count)! > 13 && range.length == 0 {
                return false
            }
        } else if status.type == .cep {
            if range.length == 0 {
                switch range.location {
                case 5:
                    appendString = "-"
                default:
                    break
                }
            }

            textField.text?.append(appendString)

            if (textField.text?.count)! > 8 && range.length == 0 {
                return false
            }
        } else if status.type == .date {
            if (textField.text?.count == 2) || (textField.text?.count == 5) {

                if !(string == "") {
                    textField.text = textField.text! + "/"

                }

            } else if (textField.text?.count == 10) {
                if !(string == "") {
                    textField.text = textField.text! + " "
                }
            }

            return !(textField.text!.count > 16 && (string.count) > range.length)
        } else if status.type == .numero {
            if range.length == 0 {
                switch range.location {
                case 0:
                    appendString = "("
                case 3:
                    appendString = ") "
                case 10:
                    appendString = "-"
                default:
                    break
                }
                textField.text?.append(appendString)

                if (textField.text?.count)! > 14 && range.length == 0 {
                    return false
                }
            }
        }
        return true
    }
}
