#if canImport(SwiftUI) && canImport(UIKit) && !os(watchOS)
import Foundation
import SwiftUI
import UIKit

public struct SmartTextField: View {
    @Binding private var text: String
    @Binding private var errors: [TextValidationResult]
    private let configuration: SmartTextField.Configuration
    private let eventier: SmartTextField.Eventier = .init()

    public init(text: Binding<String>,
                errors: Binding<[TextValidationResult]>,
                configuration: SmartTextField.Configuration = .init()) {
        self._text = text
        self._errors = errors
        self.configuration = configuration
    }

    public var body: some View {
        SmartTextField_UIViewRepresentable(text: $text,
                                           errors: $errors,
                                           configuration: configuration,
                                           eventier: eventier)
            .onAppear {
                if configuration.checkErrorOnAppear {
                    text = configuration.textFormatter.format(text)
                    errors = configuration.textValidator.validate(text)
                }
            }
    }
}

public extension SmartTextField {
    func shouldBeginEditing(_ action: @escaping () -> Bool) -> Self {
        eventier.shouldBeginEditing = action
        return self
    }

    func didBeginEditing(_ action: @escaping () -> Void) -> Self {
        eventier.didBeginEditing = action
        return self
    }

    func didEndEditing(_ action: @escaping () -> Void) -> Self {
        eventier.didEndEditing = action
        return self
    }

    func didTapReturnButton(_ action: @escaping () -> Bool) -> Self {
        eventier.didTapReturnButton = action
        return self
    }
}

/// additional wrapper to hide interface of coordinator
private struct SmartTextField_UIViewRepresentable: UIViewRepresentable {
    @Binding private(set) var text: String
    @Binding private(set) var errors: [TextValidationResult]
    private let configuration: SmartTextField.Configuration
    private let eventier: SmartTextField.Eventier

    init(text: Binding<String>,
         errors: Binding<[TextValidationResult]>,
         configuration: SmartTextField.Configuration,
         eventier: SmartTextField.Eventier) {
        self._text = text
        self._errors = errors
        self.configuration = configuration
        self.eventier = eventier
    }

    func makeUIView(context: Context) -> UITextField {
        let real = UITextField()
        real.inputView = nil

        #if !os(visionOS) && !os(tvOS)
        real.inputAccessoryView = configuration.toolbar?()
        #endif

        switch configuration.placeholder {
        case .text(let string):
            real.attributedPlaceholder = nil
            real.placeholder = string
        case .attributed(let string):
            real.placeholder = nil
            real.attributedPlaceholder = string
        case .none:
            real.placeholder = nil
            real.attributedPlaceholder = nil
        }

        real.textContentType = configuration.textContentType
        real.isSecureTextEntry = configuration.isSecureTextEntry
        real.keyboardType = configuration.keyboardType
        real.returnKeyType = configuration.returnKeyType
        real.autocapitalizationType = configuration.autocapitalizationType
        real.autocorrectionType = configuration.autocorrectionType
        real.clearsOnBeginEditing = configuration.clearsOnBeginEditing

        // SwiftUI never use this parameter
        real.clearButtonMode = .never

        real.delegate = context.coordinator
        context.coordinator.real = real

        real.text = configuration.textFormatter.format(text)

        return real
    }

    func makeCoordinator() -> SmartTextField_Coordinator {
        return .init(text: $text,
                     errors: $errors,
                     textFormatter: configuration.textFormatter,
                     textValidator: configuration.textValidator,
                     checkErrorOnEditing: configuration.checkErrorOnEditing,
                     eventier: eventier)
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != text {
            uiView.text = configuration.textFormatter.format(text)
            DispatchQueue.main.async {
                context.coordinator.checkError()
            }
        }
    }

    static func dismantleUIView(_ uiView: UITextField, coordinator: SmartTextField_Coordinator) {
        uiView.inputView = nil
        uiView.delegate = nil
        coordinator.real = nil

        #if !os(visionOS) && !os(tvOS)
        uiView.inputAccessoryView = nil
        #endif
    }
}

private final class SmartTextField_Coordinator: NSObject {
    @Binding private var text: String
    @Binding private var errors: [TextValidationResult]

    private let textFormatter: TextFormatter
    private let textValidator: TextValidator
    private let eventier: SmartTextField.Eventier
    private let checkErrorOnEditing: Bool
    var real: UITextField!

    init(text: Binding<String>,
         errors: Binding<[TextValidationResult]>,
         textFormatter: TextFormatter,
         textValidator: TextValidator,
         checkErrorOnEditing: Bool,
         eventier: SmartTextField.Eventier) {
        self._text = text
        self._errors = errors
        self.textFormatter = textFormatter
        self.textValidator = textValidator
        self.checkErrorOnEditing = checkErrorOnEditing
        self.eventier = eventier
    }

    fileprivate func textDidChanged() {
        text = real.text ?? ""
        checkError()
    }

    fileprivate func checkError() {
        if checkErrorOnEditing || !real.isFirstResponder {
            let state = textValidator.validate(real.text ?? "")
            errors = state
        }
    }
}

// MARK: - UITextFieldDelegate

extension SmartTextField_Coordinator: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_: UITextField) -> Bool {
        return eventier.shouldBeginEditing()
    }

    func textFieldDidBeginEditing(_: UITextField) {
        eventier.didBeginEditing()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        defer {
            textDidChanged()
        }

        let original = textField.text ?? ""
        let updated = (original as NSString).replacingCharacters(in: range, with: string) as String
        let formatted = textFormatter.format(updated)
        textField.text = formatted

        var offset = 0
        for ind in range.lowerBound..<(range.lowerBound + string.count) {
            if ind >= original.count {
                if ind < formatted.count {
                    offset += 1
                    continue
                }
                break
            }
            offset += 1

            let a = original[original.index(original.startIndex, offsetBy: ind)]
            let b = formatted[formatted.index(formatted.startIndex, offsetBy: ind)]
            if a != b {
                break
            }
        }

        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: range.lowerBound + offset) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }

        return false
    }

    func textFieldDidEndEditing(_: UITextField) {
        checkError()
        eventier.didEndEditing()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if eventier.didTapReturnButton() {
            textField.resignFirstResponder()
            return false
        }
        return true
    }

    /// SwiftUI never calls this method
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        textDidChanged()
        return false
    }
}

#endif
