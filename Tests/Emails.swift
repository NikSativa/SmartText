import Foundation

enum Emails {
    static let validEmails: [String] = [
        "j@b.com",
        "email@example.com",
        "firstname.lastname@example.com",
        "1tom1@blabla.com",
        "email@subdomain.example.com",
        "firstname+lastname@example.com",
        "tomCat@blabla1.com",
        "1234567890@example.com",
        "email@example-one.com",
        "_______@example.com",
        "email@example.co.jp",
        "firstname-lastname@example.com",
        "mel@samel.rocks",
        "dont_buy@adainthatendsin.io",
        "email@example.biz",
        "email@example.name",
        "pata@pata.tv",
        "email@example.museum",
        "tomCat@1blabla.com"
    ]

    static let invalidEmails: [String] = [
        "plainaddress",
        "#@%^%#$@#$@#.com",
        "@example.com",
        "Joe Smith <email@example.com>",
        "email.example.com",
        "email@example@example.com",
        ".email@example.com",
        "email.@example.com",
        "email..email@example.com",
        "あいうえお@example.com",
        "email@example.com (Joe Smith)",
        "email@example",
        "email@-example.com",
        "email@111.222.333.44444",
        "Abc.b...123@example.com",
        "email@example..com",
        "email@example-.com",
        "email@.com",
        "email.@.",
        "email.@",
        "email@",
        "tomCat@@1blabla.com",
        "!tomCat@@1blabla.com",
        "+tomCat@@1blabla.com",
        "t!+omCat@@1blabla.com"
    ]
}
