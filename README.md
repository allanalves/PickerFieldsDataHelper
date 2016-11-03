# PickerFieldsDataHelper
Swift Protocol to create Picker Views and Date Pickers to work with Text Fields' outlets, providing selectable options to fulfill them.

![storyboard](https://github.com/allanalves/PickerFieldsDataHelper/blob/master/Images/normal-picker.png?raw=true)
![storyboard](https://github.com/allanalves/PickerFieldsDataHelper/blob/master/Images/date-picker.png?raw=true)

## Usage

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

### Adding Data

```swift

		//... (viewDidLoad method)

        //Setting up simple pickers with options for each text field
        pickerFieldsDataHelper.addDataHelpers([accountTypeTextField, profileVisibilityTextField], isDateType: false)
        
        //Setting up date Type field
        pickerFieldsDataHelper.addDataHelper(birthDateTextField, isDateType: true)

```

### Customization

```swift
        
		//... (viewDidLoad method)

        //Done Button Title
        pickerFieldsDataHelper.doneButtonTitle = "Choose"

        //No-value Option and it's title
        pickerFieldsDataHelper.useDefaultFirstItem = true
        pickerFieldsDataHelper.defaultFirstItemTitle = "Select an option"
        pickerFieldsDataHelper.initWithDefaultFirstItemSelected = false

        //Show Text Fields' placeholder as Input View title
        pickerFieldsDataHelper.showPlaceholderAsTitle = true
        
        //Start with today's date, for date picker fields
        pickerFieldsDataHelper.initWithTodayDate = true

```





