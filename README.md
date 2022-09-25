![master workflow](https://github.com/csknns/csv2strings/actions/workflows/swift.yml/badge.svg
)
# csv2strings

A simple command line utility to convert an Apple's strings file to and from a csv file, with first column the translation key and second column the translation value.

# Usage

## Convert from strings to csv
Simply download the package and run:

```swift run csv2strings Localizable.strings```

It will create an `Localizable.strings.csv` with 3 columns:
`key, translation, comments`

## Convert from csv to strings
```swift run csv2strings Localizable.csv```

The CSV file must have 3 columns(`key, translation, comments`)

## Author

Christos Koninis, christos.koninis@gmail.com
