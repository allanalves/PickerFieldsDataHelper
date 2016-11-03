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
        pickerFieldsDataHelper.addTitleAndObjectInDataHelper(profileVisibilityTextField, title: "Public", object: "PUB")
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

```swift
        
		//... (viewDidLoad method)

        //Done Button Title
        pickerFieldsDataHelper.doneButtonTitle = "Choose"

        //Non-value Option and it's title
        pickerFieldsDataHelper.useDefaultFirstItem = true
        pickerFieldsDataHelper.defaultFirstItemTitle = "Select an option"
        pickerFieldsDataHelper.initWithDefaultFirstItemSelected = false //Start fields with "Select an option" text

        //Show Text Fields' placeholder as Input View title
        pickerFieldsDataHelper.showPlaceholderAsTitle = true
        
        //Start with today's date, for date picker fields
        pickerFieldsDataHelper.initWithTodayDate = true

```

### Clearing Fields

When calling 'clearAllFields()', all fields turn to default state. 

```swift
        
    @IBAction func clearAllFields(sender: AnyObject) {
        pickerFieldsDataHelper.clearAllFields()
    }

```





