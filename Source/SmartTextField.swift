#if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS) || os(visionOS)
import Foundation
import UIKit

public final class SmartTextField: UIView {
    public let real: UITextField = .init()
    public var eventier: SmartTextField.Eventier = .init()

    private var dateFormatter = Foundation.DateFormatter()
    private var textFormatter: TextFormatter = .identity
    private var textValidator: TextValidator = .identity

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }

    private func commonSetup() {
        real.delegate = self
        real.backgroundColor = .clear

        addSubview(real)
        real.translatesAutoresizingMaskIntoConstraints = false
        real.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        real.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        real.topAnchor.constraint(equalTo: topAnchor).isActive = true
        real.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    public var preferredHeight: CGFloat? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    public var validationState: [TextValidationResult] {
        return textValidator.validate(real.text ?? "")
    }

    #if os(iOS) || targetEnvironment(macCatalyst) || os(visionOS)
    public func configure(with viewState: DatePicker) {
        let datePicker: UIDatePicker
        if let oldDatePicker = real.inputView as? UIDatePicker {
            datePicker = oldDatePicker
        } else {
            datePicker = UIDatePicker()
            datePicker.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
            real.inputView = datePicker
        }

        datePicker.calendar = viewState.calendar
        datePicker.datePickerMode = viewState.mode
        datePicker.minimumDate = viewState.minDate
        datePicker.date = viewState.selecatedDate ?? Date()
        datePicker.maximumDate = viewState.maxDate
        dateFormatter = viewState.dateFormatter
    }
    #endif

    public func configure(with viewState: Configuration) {
        real.inputView = nil

        switch viewState.placeholder {
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

        real.textContentType = viewState.textContentType
        real.isSecureTextEntry = viewState.isSecureTextEntry
        real.keyboardType = viewState.keyboardType
        real.returnKeyType = viewState.returnKeyType
        real.autocapitalizationType = viewState.autocapitalizationType
        real.autocorrectionType = viewState.autocorrectionType
        real.clearButtonMode = viewState.clearButtonMode

        textFormatter = viewState.textFormatter
        textValidator = viewState.textValidator

        real.text = textFormatter.format(real.text ?? "")
    }

    public func setText(_ text: String?) {
        let oldText = real.text

        let newText = text.map(textFormatter.format) ?? ""
        real.text = newText

        if oldText != newText {
            textDidChanged()
        }
    }

    public func text(andCheckError check: Bool) -> String {
        if check {
            checkError()
        }

        return real.text ?? ""
    }

    public func clearText() {
        setText(nil)
    }

    public var textColor: UIColor {
        get {
            return real.textColor ?? .clear
        }
        set {
            real.textColor = newValue
        }
    }

    public var textFont: UIFont? {
        get {
            return real.font
        }
        set {
            real.font = newValue
        }
    }

    public var text: String? {
        get {
            return text(andCheckError: false)
        }
        set {
            setText(newValue)
        }
    }

    public var placeholder: String? {
        get {
            return real.placeholder
        }
        set {
            real.placeholder = newValue
        }
    }

    public var attributedPlaceholder: NSAttributedString? {
        get {
            return real.attributedPlaceholder
        }
        set {
            real.attributedPlaceholder = newValue
        }
    }

    #if os(iOS) || targetEnvironment(macCatalyst)
    @discardableResult
    public func setupToolbar(button: UIBarButtonItem.SystemItem, height: CGFloat = 44) -> UIToolbar {
        let doneButton = UIBarButtonItem(barButtonSystemItem: button, target: self, action: #selector(doneTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        real.inputAccessoryView = toolBar

        return toolBar
    }

    @objc
    private func doneTapped() {
        real.resignFirstResponder()
        eventier.didTapToolbarDoneButton()
    }
    #endif

    #if os(iOS) || targetEnvironment(macCatalyst) || os(visionOS)
    @objc
    private func dateChanged(sender: UIDatePicker) {
        real.text = dateFormatter.string(from: sender.date)
    }
    #endif

    override public var canBecomeFirstResponder: Bool {
        return real.canBecomeFirstResponder
    }

    override public var canResignFirstResponder: Bool {
        return real.canBecomeFirstResponder
    }

    @discardableResult
    override public func resignFirstResponder() -> Bool {
        return real.resignFirstResponder()
    }

    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        return real.becomeFirstResponder()
    }

    override public var isFirstResponder: Bool {
        return real.isFirstResponder
    }

    override public var intrinsicContentSize: CGSize {
        var calculated = super.intrinsicContentSize
        if let preferredHeight {
            calculated.height = max(calculated.height, preferredHeight)
        }
        return calculated
    }

    private func textDidChanged() {
        eventier.textDidChanged(real.text ?? "")
        checkError()
    }

    private func checkError() {
        if !isFirstResponder {
            let state = textValidator.validate(real.text ?? "")
            eventier.errorDidChanged(state)
        }
    }
}

// MARK: - UITextFieldDelegate

extension SmartTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_: UITextField) -> Bool {
        return eventier.shouldBeginEditing()
    }

    public func textFieldDidBeginEditing(_: UITextField) {
        eventier.didBeginEditing()
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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

    public func textFieldDidEndEditing(_ textField: UITextField) {
        #if os(iOS) || targetEnvironment(macCatalyst) || os(visionOS)
        if let datePicker = textField.inputView as? UIDatePicker {
            let date = datePicker.date
            eventier.dateDidChanged(date)
        }
        #endif

        eventier.didEndEditing()
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if eventier.didTapReturnButton() {
            textField.resignFirstResponder()
            return false
        }
        return true
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        textDidChanged()
        eventier.clearButton()
        return false
    }
}
#endif
