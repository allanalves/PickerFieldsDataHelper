//
//  ViewController.swift
//  PickerDataHelper
//
//  Created by Allan Alves on 28/10/16.
//  Copyright © 2016 Allan Alves. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, PickerFieldsDataHelperDelegate {
    
    @IBOutlet weak var accountTypeTextField: UITextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var profileVisibilityTextField: UITextField!

    let pickerFieldsDataHelper = PickerFieldsDataHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerFieldsDataHelper.delegate = self
        
        pickerFieldsDataHelper.doneButtonTitle = "Choose"
        pickerFieldsDataHelper.defaultFirstItemTitle = "Select an option"
        pickerFieldsDataHelper.needsConfirmationButton = false
        
        pickerFieldsDataHelper.useDefaultFirstItem = true
        pickerFieldsDataHelper.initWithDefaultFirstItemSelected = false
        
        pickerFieldsDataHelper.initWithTodayDate = true
        
        //Options Type
        pickerFieldsDataHelper.addDataHelpers([accountTypeTextField, profileVisibilityTextField], isDateType: false)
        
        //Date Type
        pickerFieldsDataHelper.addDataHelper(birthDateTextField, isDateType: true)
        
        //Add Data
        loadAccountTypeOptions()
        loadProfileVisibilityOptions()
    }
    
    func loadAccountTypeOptions() {
        pickerFieldsDataHelper.addTitleAndObjectInDataHelper(accountTypeTextField, title: "Normal User", object: 0)
        pickerFieldsDataHelper.addTitleAndObjectInDataHelper(accountTypeTextField, title: "Admin", object: 1)
    }
    
    func loadProfileVisibilityOptions() {
        pickerFieldsDataHelper.addTitleAndObjectInDataHelper(profileVisibilityTextField, title: "Private", object: "PRI")
        pickerFieldsDataHelper.addTitleAndObjectInDataHelper(profileVisibilityTextField, title: "Public", object: "PUB")
    }
    
    func pickerFieldsDataHelper(dataHelper: PickerDataHelper, didSelectObject selectedObject: AnyObject?, withTitle title: String?) {
        if let title = title, let object = selectedObject {
            print("Selected '\(title)' with object: \(object)")
        }
    }
    
    //MARK: - Actions -
    
    @IBAction func done(sender: AnyObject) {
        //Account Type
        guard let accountTypeObject = pickerFieldsDataHelper.selectedObjectForTextField(accountTypeTextField) else {
            print("No account type selected.")
            return
        }
        guard let accountTypeTitle = accountTypeTextField.text else {
            print("Empty account type text field.")
            return
        }
        print("Account Type Selected: \(accountTypeTitle) (\(accountTypeObject))")
        
        //Profile Visibility
        guard let profileVisibilityObject = pickerFieldsDataHelper.selectedObjectForTextField(profileVisibilityTextField) else {
            print("No profile visibility option selected.")
            return
        }
        guard let profileVisibilityTitle = profileVisibilityTextField.text else {
            print("Empty profile visibility text field.")
            return
        }
        print("Account Type Selected: \(profileVisibilityTitle) (\(profileVisibilityObject))")
    }
    
    @IBAction func clearAllFields(sender: AnyObject) {
        pickerFieldsDataHelper.clearAllFields()
    }

}

