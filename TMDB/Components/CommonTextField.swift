//
//  CommonTextField.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import UIKit

protocol CityTextFieldDelegate: AnyObject {
    func cityTextTapped()
}

class CommonTextField: UITextField {
    
    weak var cityTextDelegate: CityTextFieldDelegate?
    var textFieldDidEndEditing : ((_ textfield: UITextField, _ text : String) -> ())?
    var textFieldDidChange : ((_ text : String) -> ())?
    var textFieldDidBeginEditing : (()->())?
    var textFieldShouldReturn: ((_ textfield : UITextField) -> ())?
    var shouldChangeCharactersIn: ((_ text : String, _ newChar : String) -> ())?
    var textFieldShouldBeginEditing = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.delegate = self
        self.addTarget(self, action: #selector(textChanged(textField:)), for: .editingChanged)
    }
    
    @objc func textChanged(textField: UITextField){
        textFieldDidChange?(self.text!)
    }
}

extension CommonTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textFieldDidBeginEditing?()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textFieldDidEndEditing?(textField, textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldShouldReturn?(textField)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.textFieldShouldBeginEditing
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else { return false }
//        
//        let newString = (text as NSString).replacingCharacters(in: range, with: string)
//        
//        guard let format = format else { return true }
//        
//        textField.text = textField.format(with: format, phone: newString)
//        guard let text = textField.text else { return true }
//        
//        self.shouldChangeCharactersIn?(text, string)
//        self.textFieldDidChange?(text)
//        return false
//    }
}

extension CommonTextField {
    
    func addLeftPadding(_ leftPadding: CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(_ rightPadding: CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}
