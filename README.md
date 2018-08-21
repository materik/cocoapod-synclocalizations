# SyncLocalizations

* Gives warnings if you have missed to define a string in your strings files
* Gives warnings if you have duplicate keys in your strings file
* Looks inside a table and defaults to another if the key is not there
* Sorts your strings keys by name

## Install

```
pod 'SyncLocalizations', :git => 'https://github.com/materik/cocoapod-synclocazations'
```

## Usage

### Build Phase

Add the following `Run Script Phase` to your Build Phases:

```sh
"${PODS_ROOT}/SyncLocalizations/run"
```

Add the path to your Strings enum in the `Input Files` section, alternatively the script will look for `Strings.swift`.

### Strings enum

Your enum can be called whatever and includes cases for every localizable key in your project. The script picks up all the cases in the file so be careful to not include any other enums here. Conforming to the `Localizable` protocol will expose the `localized` method which will look for the strings keys in `table` or in `Default.strings`.

## Example

```swift
Strings.title.localize // "Hello"
Strings.description.localize // "How's it going?"
```

### Strings.swift

```swift
import SyncLocalizations

enum Strings: String, Localizable {

    case title
    case description
    
    var table: String {
        return "MyStrings"
    }

}
```

### MyStrings.strings

```swift
"title" = "Hello";
```

### Default.strings

```swift
"title" = "Howdy";
"description" = "How's it going?";
```
