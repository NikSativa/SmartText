# SmartText
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FNikSativa%2FSmartText%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/NikSativa/SmartText)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FNikSativa%2FSmartText%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/NikSativa/SmartText)

Swift library that provides a set of useful text formatting and validation tools that can be useful in your project.

## SwiftUI
'SmartTextField' is wrapping UITextField to use that powerfull tools and make it easy to use with **SwiftUI**.
It handles text formatting, validation, error messages and correct position of cursor when formatting text.

```swift
#Preview("SmartTextField") {
    @State var text: String = ""
    @State var errors: [TextValidationResult] = []
    
    return VStack {
        Spacer()
        SmartTextField(text: $text,
                       errors: $errors,
                       configuration: .init(placeholder: "Email",
                                            textFormatter: .email,
                                            textValidator: .email()))
            .fixedSize(horizontal: false, vertical: true)
        Spacer()
    }
}
```

## UIKit
'UISmartTextField' is wrapping UITextField to use that powerfull tools and make it easy to use with **UIKit**.
It handles text formatting, validation, error messages and correct position of cursor when formatting text.
UITextField events can be handled by 'Smart' closures in 'UISmartTextField.Eventier'.

```swift
let email = UISmartTextField()
let emailConfig: UISmartTextField.Configuration
emailConfig = .init(placeholder: "Email",
                    textFormatter: [
                        .email,
                        .stripLeadingAndTrailingSpaces
                    ],
                    textValidator: [
                        .notEmpty(errorText: "Email is required"),
                        .email(errorText: "Invalid email format")
                    ],
                    textContentType: .emailAddress,
                    keyboardType: .emailAddress)
email.configure(with: emailConfig)

let password = UISmartTextField()
let passwordConfig: UISmartTextField.Configuration
passwordConfig = .init(placeholder: "Password",
                       textFormatter: .stripLeadingAndTrailingSpaces,
                       textValidator: [
                           .notEmpty(errorText: "Password is required"),
                           .includesLowerAndUppercase(errorText: "Password must contain lower and uppercase characters"),
                           .minLengthLimited(8, errorText: "Password must be at least 8 characters long")
                       ],
                       textContentType: .emailAddress,
                       keyboardType: .emailAddress)
password.configure(with: passwordConfig)
```

## Lifehacks with keyboard & toolbar
You can declare UIToolbar in the `SmartTextField.Configuration` to navigate between text fields in your form.

* `@FocusState` can be used to handle focus between fields. 
```swift
@FocusState var focus: AuthTextFieldForm?
```

* Declare `AuthTextFieldForm` enum to navigate between fields.
```swift
enum AuthTextFieldForm: Int, TextFieldsFormContract {
    case email
    case password
}
```

* `TextFieldsFormContract` is a protocol that declares the navigation between form fields.
```swift
protocol TextFieldsFormContract: RawRepresentable, Hashable, CaseIterable where RawValue == Int {
    func next() -> Self?
    func previous() -> Self?
}

extension TextFieldsFormContract where RawValue == Int {
    func next() -> Self? {
        return .init(rawValue: rawValue + 1)
    }

    func previous() -> Self? {
        return .init(rawValue: rawValue - 1)
    }
}
```

### How to make UIToolbar with `previous`, `next` and `done` buttons in Swift?
```swift
static func toolbar<FocusType: TextFieldsFormContract>(with type: FocusType, focus: FocusState<FocusType?>.Binding) -> UIToolbar {
    let doneButton = BlockBarButtonItem(barButtonSystemItem: .done, actionHandler: { focus.wrappedValue = nil })

    let prev = type.previous()
    let prevButton = BlockBarButtonItem(image: UIImage(systemName: "chevron.left")!, actionHandler: { focus.wrappedValue = prev })
    prevButton.isEnabled = prev != nil

    let next = type.next()
    let nextButton = BlockBarButtonItem(image: UIImage(systemName: "chevron.right")!, actionHandler: { focus.wrappedValue = next })
    nextButton.isEnabled = next != nil

    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
    toolBar.setItems([prevButton, nextButton, flexibleSpace, doneButton], animated: false)
    return toolBar
}
```

### How to make UIBarButtonItem with closure in Swift?
```swift
 final class BlockBarButtonItem: UIBarButtonItem {
    private var actionHandler: (() -> Void)?

    convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, actionHandler: (() -> Void)?) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: #selector(barButtonItemPressed))
        self.target = self
        self.actionHandler = actionHandler
    }

    convenience init(title: String, style: UIBarButtonItem.Style = .plain, actionHandler: (() -> Void)?) {
        self.init(title: title, style: style, target: nil, action: #selector(barButtonItemPressed))
        self.target = self
        self.actionHandler = actionHandler
    }

    convenience init(image: UIImage, style: UIBarButtonItem.Style = .plain, actionHandler: (() -> Void)?) {
        self.init(image: image, style: style, target: nil, action: #selector(barButtonItemPressed))
        self.target = self
        self.actionHandler = actionHandler
    }

    @objc
    private func barButtonItemPressed(sender: UIBarButtonItem) {
        actionHandler?()
    }
}
```
