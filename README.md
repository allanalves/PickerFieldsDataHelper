# PickerFieldsDataHelper

Swift (3) Protocol to create Picker Views and Date Pickers to work with Text Fields' outlets, providing selectable options to fulfill them.

![storyboard](https://github.com/allanalves/PickerFieldsDataHelper/blob/master/Images/normal-picker.png?raw=true)
![storyboard](https://github.com/allanalves/PickerFieldsDataHelper/blob/master/Images/date-picker.png?raw=true)

## Usage

Just add the file 'PickerFieldsDataHelper.swift' to your project.

### Delegation

```swift

class ViewController: UITableViewController, PickerFieldsDataHelperDelegate {

    let pickerFieldsDataHelper = PickerFieldsDataHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerFieldsDataHelper.delegate = self
    }

}

```

### Initializing

```swift

		//... (viewDidLoad method)

        //Setting up simple pickers with options for each text field
        pickerFieldsDataHelper.addDataHelpers([accountTypeTextField, profileVisibilityTextField], isDateType: false)
        
        //Setting up date Type field
        pickerFieldsDataHelper.addDataHelper(birthDateTextField, isDateType: true)

```

### Adding Data

You can add objects with representing titles to each field at any moment. Picker data are refreshed automatically.

```swift

    func loadAccountTypeOptions() {
        pickerFieldsDataHelper.addTitleAndObjectInDataHelper(accountTypeTextField, title: "Normal User", object: 0)
        pickerFieldsDataHelper.addTitleAndObjectInDataHelper(accountTypeTextField, title: "Admin", object: 1)
    }
    
    func loadProfileVisibilityOptions() {
        pickerFieldsDataHelper.addTitleAndObjectInDataHelper(profileVisibilityTextField, title: "Private", object: "PRI")

        //Add an option to be default - starts with the option selected.
        pickerFieldsDataHelper.addTitleAndObjectInDataHelper(profileVisibilityTextField, title: "Public", object: "PUB", isDefault: true)
    }

```

### Getting Data

Use 'selectedObjectForTextField' method to get the current object for the selected option.

It can be nil if there is an non-value option selected like "Select an option".

```swift

    if let object = pickerFieldsDataHelper.selectedObjectForTextField(accountTypeTextField) {
    	//Use object
	} else {
		//No valid option selected
	}

```

### Customization

#### Select Confirmation Button

```swift
        pickerFieldsDataHelper.doneButtonTitle = "Choose"
        pickerFieldsDataHelper.needsConfirmationButton = false //Selects without tapping the button
```

#### Non-value Default Option

```swift
        pickerFieldsDataHelper.useDefaultFirstItem = true
        pickerFieldsDataHelper.defaultFirstItemTitle = "Select an option"
        pickerFieldsDataHelper.initWithDefaultFirstItemSelected = false //Start fields with "Select an option" text
```

#### Date Type: Start with today's date

```swift
		pickerFieldsDataHelper.initWithTodayDate = true
```

### Clearing Fields

When calling 'clearAllFields()', all fields turn to default state. 

```swift
        
    @IBAction func clearAllFields(sender: AnyObject) {
        pickerFieldsDataHelper.clearAllFields()
    }

```

### Optional Methods

#### Get title and object when selecting an item.

```swift
        
    func pickerFieldsDataHelper(dataHelper: PickerDataHelper, didSelectObject selectedObject: AnyObject?, withTitle title: String?) {
        //Use 'title' or 'selectedObject'.
    }


[![CI Status](http://img.shields.io/travis/Allan Alves/PickerFieldsDataHelper.svg?style=flat)](https://travis-ci.org/Allan Alves/PickerFieldsDataHelper)
[![Version](https://img.shields.io/cocoapods/v/PickerFieldsDataHelper.svg?style=flat)](http://cocoapods.org/pods/PickerFieldsDataHelper)
[![License](https://img.shields.io/cocoapods/l/PickerFieldsDataHelper.svg?style=flat)](http://cocoapods.org/pods/PickerFieldsDataHelper)
[![Platform](https://img.shields.io/cocoapods/p/PickerFieldsDataHelper.svg?style=flat)](http://cocoapods.org/pods/PickerFieldsDataHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PickerFieldsDataHelper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PickerFieldsDataHelper"
```

## Author

Allan Alves, allanalves90@gmail.com

## License

PickerFieldsDataHelper is available under the MIT license. See the LICENSE file for more info.
