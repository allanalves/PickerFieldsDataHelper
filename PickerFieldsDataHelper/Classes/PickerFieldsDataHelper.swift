//
//  PickerFieldsDataHelper.swift
//  PickerDataHelper
//
//  Created by Allan Alves on 28/10/16.
//  Copyright © 2016 Allan Alves. All rights reserved.
//

import UIKit

@objc public protocol PickerFieldsDataHelperDelegate: class {
    @objc optional func pickerFieldsDataHelper(_ dataHelper: PickerDataHelper, didSelectObject selectedObject: Any?, withTitle title: String?)
}

@objc public class PickerDataHelper: NSObject {
    var pickerView: UIPickerView?
    var datePicker: UIDatePicker?
    var textField: UITextField?
    var isDateType: Bool
    var titles = [String]()
    var objects = [Any]()
    var selectedObject: Any?
    var defaultOption: (String,Any)?

    init(textField: UITextField, isDateType: Bool) {
        let pickerView = UIPickerView()
        self.pickerView = pickerView
        self.textField = textField
        self.isDateType = isDateType
    }
}

public class PickerFieldsDataHelper: NSObject, PickerFieldsDataHelperDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    weak public var delegate: PickerFieldsDataHelperDelegate?
    var dataHelpers = [PickerDataHelper]()

    //Confirmaton button
    public var doneButtonTitle = "OK"
    public var needsConfirmationButton = true //Tap button to confirm

    //Show first item with nil object
    public var useDefaultFirstItem = true
    public var initWithDefaultFirstItemSelected = true //if useDefaultFirstItem is true
    public var defaultFirstItemTitle = "Select..." //Use if useDefaultFirstItem is true

    //Date Type
    public var dateFormat = "dd/MM/yyyy"
    public var initWithTodayDate = false

    // MARK: - Initialization -

    public func addDataHelpers(_ textFields: [UITextField], isDateType: Bool = false) {
        for textField in textFields {
            addDataHelper(textField, isDateType: isDateType)
        }
    }

    public func addDataHelper(_ textField: UITextField, isDateType: Bool = false) {
        let dataHelper = PickerDataHelper(textField: textField, isDateType: isDateType)
        dataHelper.isDateType = isDateType
        textField.delegate = self

        if isDateType {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            //Select date automatically if it doesn't need confirmation button
            if !needsConfirmationButton {
                datePicker.addTarget(self,
                                     action: #selector(self.didSelectDate(_:)),
                                     for: .valueChanged)
            }
            dataHelper.datePicker = datePicker

            textField.inputView = datePicker

            if initWithTodayDate {
                datePicker.date = Date()
                refreshDate(dataHelper)
            }
        } else {
            //Picker View
            let pickerView = UIPickerView()
            dataHelper.pickerView = pickerView

            //Set Delegate, DataSource & Correspondent TextFields
            pickerView.delegate = self
            pickerView.dataSource = self
            //TextField InputView
            textField.inputView = pickerView

            //Add first default item if needed
            if useDefaultFirstItem {
                dataHelper.titles.append(defaultFirstItemTitle)
                if initWithDefaultFirstItemSelected {
                    textField.text = defaultFirstItemTitle
                }
            }
        }
        //Input Accessory View
        addToolBarPickerViews(doneButtonTitle, textField: textField)

        dataHelpers.append(dataHelper)
        refreshAllPickers()
    }

    public func dataHelper(_ textField: UITextField) -> PickerDataHelper? {
        for item in dataHelpers {
            if textField == item.textField {
                return item
            }
        }
        return nil
    }

    // MARK: - Content -

    public func addTitleAndObjectInDataHelper(_ textField: UITextField, title: String, object: Any) {
        if let dataHelper = dataHelper(textField) {
            dataHelper.titles.append(title)
            dataHelper.objects.append(object)
            refreshAllPickers()
        }
    }

    public func addTitleAndObjectInDataHelper(_ textField: UITextField, title: String, object: Any, isDefault: Bool) {
        addTitleAndObjectInDataHelper(textField, title: title, object: object)
        if isDefault {
            if let dataHelper = dataHelper(textField) {
                dataHelper.defaultOption = (title,object)
                selectDefaultOption(dataHelper)
            }
        }
    }

    //Return selected object for given textfield
    public func selectedObjectForTextField(_ textField: UITextField) -> Any? {
        if let dataHelper = dataHelper(textField) {
            if let object = dataHelper.selectedObject {
                return object
            }
        }
        return nil
    }

    //Select option on textField and selectedObject property
    fileprivate func selectDefaultOption(_ dataHelper: PickerDataHelper) {
        if let defaultOption = dataHelper.defaultOption {
            if let textField = dataHelper.textField {
                textField.text = defaultOption.0
            }
            dataHelper.selectedObject = defaultOption.1
        }
    }

    // MARK: - Text Field -

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if !needsConfirmationButton {
            if let dataHelper = dataHelper(textField) { //Get DataHelper
                if !dataHelper.isDateType {
                    if let pickerView = dataHelper.pickerView { //Get PickerView
                        let row = pickerView.selectedRow(inComponent: 0)
                        selectObjectOfRow(row, dataHelper: dataHelper)
                        let title = dataHelper.titles[row]
                        textField.text = title
                    }
                }
            }
        }
    }

    // MARK: - Date Picker -

    @objc fileprivate func didSelectDate(_ datePicker: UIDatePicker) {
        for dataHelper in dataHelpers {
            if let dataHelperDatePicker = dataHelper.datePicker { //Find DH DatePicker
                if dataHelperDatePicker == datePicker {
                    if let textField = dataHelper.textField {
                        selectDate(dataHelperDatePicker.date, textField: textField)
                    }
                }
            }
        }
    }

    // MARK: - Picker Views -

    fileprivate func selectObjectOfRow(_ row: Int, dataHelper: PickerDataHelper) {
        if useDefaultFirstItem {
            dataHelper.selectedObject = nil
            //Use nil as default - if index given is not in objects/titles range
            if row > 0 && row < dataHelper.titles.count {
                dataHelper.selectedObject = dataHelper.objects[row-1]
            }
        } else {
            if row > -1 && row < dataHelper.titles.count {
                dataHelper.selectedObject = dataHelper.objects[row]
            }
        }
    }

    func refreshAllPickers() {
        for dataHelper in dataHelpers {
            if let pickerView = dataHelper.pickerView {
                pickerView.reloadAllComponents()
            }
        }
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        for dataHelper in dataHelpers {
            if dataHelper.pickerView == pickerView {
                return dataHelper.titles[row]
            }
        }
        return "❔"
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //If item is selected without tapping the confirmation button
        if !needsConfirmationButton {
            for dataHelper in dataHelpers {
                //Find Data Helper Picker View
                if let helperPickerView = dataHelper.pickerView {
                    if helperPickerView == pickerView {
                        //Get Text Field
                        if let textField = dataHelper.textField {
                            let title = dataHelper.titles[row]
                            selectObjectOfRow(row, dataHelper: dataHelper)
                            textField.text = title
                            //Call optional method
                            self.delegate?.pickerFieldsDataHelper?(dataHelper,
                                                                   didSelectObject: dataHelper.selectedObject,
                                                                   withTitle: title)
                        }
                    }
                }
            }
        }
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        for dataHelper in dataHelpers {
            if dataHelper.pickerView == pickerView {
                return dataHelper.titles.count
            }
        }
        return 0
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // MARK: - Other -

    func selectDate(_ date: Date, textField: UITextField) {
        if let dataHelper = dataHelper(textField) {
            if dataHelper.isDateType {
                if let datePicker = dataHelper.datePicker {
                    datePicker.date = date
                    refreshDate(dataHelper)
                }
            }
        }
    }

    public func clearAllFields() {
        for dataHelper in dataHelpers {
            if let textField = dataHelper.textField {
                if dataHelper.isDateType {
                    //Date Type
                    if initWithTodayDate { //Init With Today
                        if let datePicker = dataHelper.datePicker {
                            datePicker.date = Date()
                            refreshDate(dataHelper)
                        }
                    } else {
                        textField.text = ""
                    }
                    //Normal Type
                } else {
                    textField.text = ""
                    dataHelper.selectedObject = nil
                    //Select default option if it exists
                    if dataHelper.defaultOption != nil {
                        selectDefaultOption(dataHelper)
                    } else { //If there is no default option, set first if needed
                        if useDefaultFirstItem { //Init With First Default Title
                            if initWithDefaultFirstItemSelected {
                                textField.text = defaultFirstItemTitle
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Input Accessory View -

    //Add input accessory view with done button
    func addToolBarPickerViews(_ title : String, textField : UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()

        let closeButton = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(self.closePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, closeButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        textField.inputAccessoryView = toolBar
    }

    //Set selected date as selected object, and textfield title
    func refreshDate(_ dataHelper: PickerDataHelper) {
        if let datePicker = dataHelper.datePicker {
            dataHelper.selectedObject = datePicker.date as AnyObject?
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            if let textField = dataHelper.textField {
                textField.text = dateFormatter.string(from: datePicker.date)
            }
        }
    }

    // MARK: - Actions -

    //Hide keyboard, set selected object and set title of textfield
    @objc func closePicker() {
        //TDOO: Get selected picker item and set text of textfield
        for dataHelper in dataHelpers {
            if let textField = dataHelper.textField {
                if textField.isFirstResponder {
                    textField.superview?.endEditing(true) //Hide Keyboard
                    //Just close input view if confirmation button is not needed
                    if !needsConfirmationButton {
                        return
                    }
                    if dataHelper.isDateType {
                        refreshDate(dataHelper)
                    } else {
                        if let pickerView = dataHelper.pickerView {
                            let row = pickerView.selectedRow(inComponent: 0) //Get Index
                            if row < dataHelper.titles.count && row > -1 {
                                let title = dataHelper.titles[row] //Get Title
                                textField.text = title
                                selectObjectOfRow(row, dataHelper: dataHelper)
                                //When user taps the done button to select an option
                                self.delegate?.pickerFieldsDataHelper?(dataHelper,
                                                                       didSelectObject: dataHelper.selectedObject,
                                                                       withTitle: title)
                            }
                        }
                    }
                }
            }
        }
    }

}
