//
//  NewRecordViewController.swift
//  PainJournal
//
//  Created by elina.zambere on 15/04/2021.
//

import UIKit
import CoreData

class NewRecordTableViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    var records: JournalMO!
    var coreData = CoreData()
    let formatter = DateFormatter()

    
    @IBOutlet weak var dateTextField: UITextField! {
        
        didSet {
            
            dateTextField.tag = 1
            dateTextField.becomeFirstResponder()
            dateTextField.delegate = self
            
        }
        
    }
    @IBOutlet weak var timeTextField: UITextField! {
        
        didSet {
            
            timeTextField.tag = 2
            timeTextField.becomeFirstResponder()
            timeTextField.delegate = self
            
        }
        
    }
    @IBOutlet weak var painTextField: UITextField! {
        
        didSet {
            
            painTextField.tag = 3
            painTextField.becomeFirstResponder()
            painTextField.delegate = self
            
        }
        
    }
    
    @IBOutlet weak var painScaleTextField: UITextField! {
        
        didSet {
            
            painScaleTextField.tag = 4
            painScaleTextField.becomeFirstResponder()
            painScaleTextField.delegate = self
            
        }
        
    }
    
    @IBOutlet weak var notesTextView: UITextView! {
        
        didSet {
            
            notesTextView.tag = 5
            notesTextView.becomeFirstResponder()
            notesTextView.delegate = self
            
        }
        
    }
    
    @IBOutlet var photoImageView: UIImageView!
    
    
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    
    let painVariant = ["Back-Pain", "Headache", "Neck Pain", "Muscle Pain", "Pelvic Pain", "Stomachache", "Chest Pain", "Hip-Pain", "Joint Pain", "Nerve Pain", "Sore throat", "Other"]
    
    //let sortedPainVariants = painVariant.sorted { $0.name< $1.name }
    
    
    let painScale = ["Pain Barable", "Moderate Pain", "Serve Pain", "Very Serve Pain", "Worst Pain Possible"]
    
    var painVariantPickerView = UIPickerView()
    var painScalePickerView = UIPickerView()
    
    @IBAction func saveButtonTapped(sender: AnyObject) {

        if dateTextField.text == "" || timeTextField.text == "" || painTextField.text == "" || painScaleTextField .text == "" || notesTextView.text == "" {
            let alertController = UIAlertController(title: "Error!", message: "New Pain Record cannot be saved. Please fill in all fields.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)

            present(alertController, animated: true, completion: nil)
            return
        }


            records = JournalMO(context: coreData.persistentContainer.viewContext)
            records.painDate = dateTextField.text
            records.painTime = timeTextField.text
            records.painType = painTextField.text
            records.painPower = painScaleTextField.text
            records.painNotes = notesTextView.text

            if let painImage = photoImageView.image {
                
                records.painImage = painImage.pngData()
                
            }

            print("Saving data to context")
            coreData.saveContext()
        
            dismiss(animated: true, completion: nil)
        

        
        }
        
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
                
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        notesTextView.text = "How are you feeling today?"
        notesTextView.textColor = UIColor.lightGray

        notesTextView.becomeFirstResponder()

        notesTextView.selectedTextRange = notesTextView.textRange(from: notesTextView.beginningOfDocument, to: notesTextView.beginningOfDocument)
        
        //photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        tableView.separatorStyle = .none
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        //Configure Navigation Bar Appereance
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Palatino", size: 22)!]
        
        //Date Picker Setup
        
        let date = Date()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: date)
        
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueChange(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        dateTextField.inputView = datePicker

        
        
        //Time Picker Setup
        
        let time = Date()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        timeTextField.text = formatter.string(from: time)
        timeTextField.textColor = .black
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChange(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        timeTextField.inputView = timePicker
        timePicker.preferredDatePickerStyle = .wheels
        
        painTextField.inputView = painVariantPickerView
        painScaleTextField.inputView = painScalePickerView
        
        
        painVariantPickerView.delegate = self
        painVariantPickerView.dataSource = self
        
        painScalePickerView.delegate = self
        painScalePickerView.dataSource = self
        
        painScalePickerView.tag = 2
        painVariantPickerView.tag = 1
        
        
    
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        
        
        let currentText:String = notesTextView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        

        if updatedText.isEmpty {

            notesTextView.text = "How are you feeling?"
            notesTextView.textColor = UIColor.lightGray

            notesTextView.selectedTextRange = notesTextView.textRange(from: notesTextView.beginningOfDocument, to: notesTextView.beginningOfDocument)
        }


         else if notesTextView.textColor == UIColor.lightGray && !text.isEmpty {
            notesTextView.textColor = UIColor.black
            notesTextView.text = text
        }
         
        else {
            return true
        }

        return false
    }
    
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if notesTextView.textColor == UIColor.lightGray {
                notesTextView.selectedTextRange = notesTextView.textRange(from: notesTextView.beginningOfDocument, to: notesTextView.beginningOfDocument)
            }
        }
    }
    
    @objc func timePickerValueChange (sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        timeTextField.text = formatter.string(from: sender.date)
        
    }
    
    @objc func datePickerValueChange (sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: sender.date)
        
    }
    

    //MARK: - Text field method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
            
        }
        
        return true 
    }
    

    
    
        @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
            dateTextField.resignFirstResponder()
            timeTextField.resignFirstResponder()
            painTextField.resignFirstResponder()
            painScaleTextField.resignFirstResponder()
            notesTextView.resignFirstResponder()
            
        }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return painVariant.count
        case 2:
            return painScale.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return painVariant[row]
        case 2:
            return painScale[row]
        default:
            return "Data not found."
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 1:
            painTextField.text = painVariant[row]
            photoImageView.image = UIImage(named: painVariant[row])
        case 2:
            painScaleTextField.text = painScale[row]
        default:
            return
        }
        
        
    }
    
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }

}
