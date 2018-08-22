# PickerFields Data Helper

Swift (+3.0) Protocol to create Picker Views and Date Pickers to work with Text Fields' outlets, providing selectable options to fulfill them.


[![Version](https://img.shields.io/cocoapods/v/PickerFieldsDataHelper.svg?style=flat)](http://cocoapods.org/pods/PickerFieldsDataHelper)
[![License](https://img.shields.io/cocoapods/l/PickerFieldsDataHelper.svg?style=flat)](http://cocoapods.org/pods/PickerFieldsDataHelper)
[![Platform](https://img.shields.io/cocoapods/p/PickerFieldsDataHelper.svg?style=flat)](http://cocoapods.org/pods/PickerFieldsDataHelper)

![storyboard](https://github.com/allanalves/PickerFieldsDataHelper/blob/master/Images/normal-picker.png?raw=true)
![storyboard](https://github.com/allanalves/PickerFieldsDataHelper/blob/master/Images/date-picker.png?raw=true)

# Try it!
```ruby
pod try PickerFieldsDataHelper
```

## Usage

Just add the file 'PickerFieldsDataHelper.swift' to your project.

### Delegation

```swift

class ViewController: UITableViewController, PickerFieldsDataHelperDelegate {

    let pickerFields = PickerFieldsDataHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerFields.delegate = self
    }

}

```

### Initializing

```swift

		//... (viewDidLoad method)

        //Setting up simple pickers with options for each text field
        pickerFields.addDataHelpers([accountTypeTextField, profileVisibilityTextField])
        
        //Setting up date Type field
        pickerFields.addDataHelper(birthDateTextField, isDateType: true)

```

### Adding Data

You can add objects with representing titles to each field at any moment. Picker data are refreshed automatically.

```swift

    func loadAccountTypeOptions() {
        pickerFields.addTitleAndObjectInDataHelper(accountTypeTextField, title: "Normal User", object: 0)
        pickerFields.addTitleAndObjectInDataHelper(accountTypeTextField, title: "Admin", object: 1)
    }
    
    func loadProfileVisibilityOptions() {
        pickerFields.addTitleAndObjectInDataHelper(profileVisibilityTextField, title: "Private", object: "PRI")

        //Add an option to be default - starts with the option selected.
        pickerFields.addTitleAndObjectInDataHelper(profileVisibilityTextField, title: "Public", object: "PUB", isDefault: true)
    }

```

### Getting Data

Use 'selectedObjectForTextField' method to get the current object for the selected option.

It can be nil if there is an non-value option selected like "Select an option".

```swift

    if let object = pickerFields.selectedObjectForTextField(accountTypeTextField) {
    	//Use object
	} else {
		//No valid option selected
	}

```

### Customization

#### Select Confirmation Button

```swift
        pickerFields.doneButtonTitle = "Choose"
        pickerFields.needsConfirmationButton = false //Selects without tapping the button
```

#### Non-value Default Option

```swift
        pickerFields.useDefaultFirstItem = true
        pickerFields.defaultFirstItemTitle = "Select an option"
        pickerFields.initWithDefaultFirstItemSelected = false //Start fields with "Select an option" text
```

#### Date Type: Start with today's date

```swift
		pickerFields.initWithTodayDate = true
```

### Clearing Fields

When calling 'clearAllFields()', all fields turn to default state. 

```swift
        
    @IBAction func clearAllFields(sender: AnyObject) {
        pickerFields.clearAllFields()
    }

```

### Optional Methods

#### Get title and object when selecting an item.

```swift
        
    func pickerFieldsDataHelper(dataHelper: PickerDataHelper, didSelectObject selectedObject: AnyObject?, withTitle title: String?) {
        //Use 'title' or 'selectedObject'.
    }
```

## Cocoapods

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

PickerFieldsDataHelper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PickerFieldsDataHelper'
```

## Author

Allan Alves, allanalves90@gmail.com

## License

PickerFieldsDataHelper is available under the MIT license. See the LICENSE file for more info.
