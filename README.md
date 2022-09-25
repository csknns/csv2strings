![master workflow](https://github.com/csknns/csv2strings/actions/workflows/swift.yml/badge.svg
)
# csv2strings

A simple command line utility & library to parse & convert an Apple's strings file to and from a csv file, with first column the translation key and second column the translation value.

# Usage

## Convert from strings to csv
Simply download the package and run:

```swift run csv2strings Localizable.strings```

It will create an `Localizable.csv` with 3 columns:
`key, translation, comments`

## Convert from csv to strings
```swift run csv2strings Localizable.csv```

The CSV file must have 3 columns(`key, translation, comments`)

## Parsing a .strings file
```
import libcsv2strings

let contents: StringsFile = StringsFileParser(stringsFilePath: "path/to/Localizable.strings")?.parse()
```

Parsing the file to a StringsFile model

```
/// Top level model of a Apple's strings file
public struct StringsFile {
    let entries: [Translation]

    /// Model of a strings file translation item
    public struct Translation {
        let translationKey: String
        let translation: String
        let comment: String?
    }
}
```


## Author

Christos Koninis, christos.koninis@gmail.com
