# SmartText

Swift library that provides a set of useful text formatting and validation tools that can be useful in your project.
'SmartTextField' is wrapping UITextField to use that powerfull tools and make it easy to use.
It handles text formatting, validation, error messages and correct position of cursor when formatting text.
UITextField events can be handled by 'Smart' closures in 'SmartTextField.Eventier'.

```swift
let email = SmartTextField()
let emailConfig: SmartTextField.Configuration
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

let password = SmartTextField()
let passwordConfig: SmartTextField.Configuration
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
