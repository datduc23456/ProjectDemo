//
//  MIDatePicker.swift
//  Agenda medica
//
//  Created by Mario on 15/06/16.
//  Copyright © 2016 Mario. All rights reserved.
//

import UIKit

enum DatePickerType {
    case year
    case month
    case week(year: Int, month: Int)
    
    var values: [Int] {
        switch self {
        case .year:
            return (2010...Int(CommonUtil.getYearFromDate(Date().toString()))!).map { Int($0) }
        case .month:
            return (1...12).map { Int($0) }
        case .week(let year, let month):
            let dateComponents = DateComponents(year: year, month: month)
            let calendar = Calendar.current
            let date = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .weekdayOrdinal, in: .month, for: date)!
            return range.map { Int($0) }
        }
    }
}

protocol MIDatePickerDelegate: AnyObject {
    func miDatePicker(amDatePicker: MIDatePicker, didSelect value: Int, forType: DatePickerType)
    func miDatePicker(amDatePicker: MIDatePicker, didSelect date: NSDate)
    func miDatePickerDidCancelSelection(amDatePicker: MIDatePicker)
    
}

// MARK: - Config
@objc public class MIDatePickerConfig : NSObject {
    
    var contentHeight: CGFloat = 160
    var bouncingOffset: CGFloat = 20
    
    @objc var startDate: NSDate?
    @objc var minDate: NSDate?
    @objc var maxDate: NSDate?
    
    var confirmButtonTitle = "Choose"
    var cancelButtonTitle = "Cancel"
    
    var headerHeight: CGFloat = 50
    
    var animationDuration: TimeInterval = 0.3
    var datePickerType: DatePickerType = .year
    var contentBackgroundColor: UIColor = UIColor.init(hex: "#232228")
    var headerBackgroundColor: UIColor = UIColor.init(hex: "#232228")
    @objc var confirmButtonColor: UIColor = UIColor.blue
    @objc var cancelButtonColor: UIColor = UIColor.black
    
    var overlayBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.6)
}

public class MIDatePicker: UIView {
    
    
    @objc var config = MIDatePickerConfig()
    
    weak var delegate: MIDatePickerDelegate?
    
    // MARK: - IBOutlets

    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    var selectedValue: Int?
    var bottomConstraint: NSLayoutConstraint!
    var overlayButton: UIButton!
    
    // MARK: - Init
    @objc static func getFromNib() -> MIDatePicker {
        return UINib.init(nibName: String(describing: self), bundle: nil).instantiate(withOwner: self, options: nil).last as! MIDatePicker
    }
    
    @IBAction func confirmButtonDidTapped(_ sender: Any) {
        dismiss()
        @OptionalUnwrap(defaultValue: .year, config.datePickerType) var type
        @OptionalUnwrap(defaultValue: 0, self.selectedValue) var value
        self.delegate?.miDatePicker(amDatePicker: self, didSelect: value, forType: type)
    }

    @IBAction func cancelButtonDidTapped(_ sender: AnyObject) {
        dismiss()
        delegate?.miDatePickerDidCancelSelection(amDatePicker: self)
    }
    
    // MARK: - Private
    private func setup(parentVC: UIViewController) {
        
        // Loading configuration
    
//        datePicker.datePickerMode = config.datePickerMode
        
//        if let startDate = config.startDate {
//            datePicker.date = startDate as Date
//        }
//
//        if let minDate = config.minDate {
//            datePicker.minimumDate = minDate as Date
//        }
//
//        if let maxDate = config.maxDate {
//            datePicker.maximumDate = maxDate as Date
//        }
        
        datePicker.dataSource = self
        datePicker.delegate = self
        datePicker.reloadAllComponents()
        headerViewHeightConstraint.constant = config.headerHeight
        
        confirmButton.setTitle(config.confirmButtonTitle, for: .normal)
        cancelButton.setTitle(config.cancelButtonTitle, for: .normal)
        
        confirmButton.setTitleColor(config.confirmButtonColor, for: .normal)
        cancelButton.setTitleColor(config.cancelButtonColor, for: .normal)
        
        headerView.backgroundColor = config.headerBackgroundColor
        backgroundView.backgroundColor = config.contentBackgroundColor

//        datePicker.backgroundColor = UIColor.white
        
        // Overlay view constraints setup
        
        overlayButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlayButton.backgroundColor = config.overlayBackgroundColor
        overlayButton.alpha = 0
        
        overlayButton.addTarget(self, action: #selector(cancelButtonDidTapped(_:)), for: .touchUpInside)
        
        confirmButton.addTarget(self, action: #selector(confirmButtonDidTapped(_:)), for: .touchUpInside)
        
        if !overlayButton.isDescendant(of: parentVC.view) { parentVC.view.addSubview(overlayButton) }
        
        overlayButton.translatesAutoresizingMaskIntoConstraints = false
        
        parentVC.view.addConstraints([
            NSLayoutConstraint(item: overlayButton, attribute: .bottom, relatedBy: .equal, toItem: parentVC.view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .top, relatedBy: .equal, toItem: parentVC.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .leading, relatedBy: .equal, toItem: parentVC.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overlayButton, attribute: .trailing, relatedBy: .equal, toItem: parentVC.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]
        )
        
        // Setup picker constraints
        
        frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: config.contentHeight + config.headerHeight)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentVC.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        if !isDescendant(of: parentVC.view) { parentVC.view.addSubview(self) }
        
        parentVC.view.addConstraints([
            bottomConstraint,
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: parentVC.view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: parentVC.view, attribute: .trailing, multiplier: 1, constant: 0)
            ]
        )
        addConstraint(
            NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: frame.height)
        )
        
        move(goUp: false)
        
    }
    private func move(goUp: Bool) {
        bottomConstraint.constant = goUp ? config.bouncingOffset : config.contentHeight + config.headerHeight
    }
    
    // MARK: - Public
    @objc func show(inVC parentVC: UIViewController, completion: (() -> ())? = nil) {
        
        parentVC.view.endEditing(true)
        
        setup(parentVC: parentVC)
        move(goUp: true)
        
        UIView.animate(
            withDuration: config.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
                
                parentVC.view.layoutIfNeeded()
                self.overlayButton.alpha = 1
                
            }, completion: { (finished) in
                completion?()
            }
        )
        
    }
    func dismiss(completion: (() -> ())? = nil) {
        
        move(goUp: false)
        
        UIView.animate(
            withDuration: config.animationDuration, animations: {
                
                self.layoutIfNeeded()
                self.overlayButton.alpha = 0
                
            }, completion: { (finished) in
                completion?()
                self.removeFromSuperview()
                self.overlayButton.removeFromSuperview()
            }
        )
        
    }
    
}

extension MIDatePicker: UIPickerViewDataSource {
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        @OptionalUnwrap(defaultValue: [], config.datePickerType.values) var rows
        return rows.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        @OptionalUnwrap(defaultValue: .year, config.datePickerType) var type
        @OptionalUnwrap(defaultValue: 0, type.values[safe: row]) var value
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        return NSMutableAttributedString(string: "\(value)", attributes: attributes as [NSAttributedString.Key : Any])
    }
}

extension MIDatePicker: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        @OptionalUnwrap(defaultValue: .year, config.datePickerType) var type
        @OptionalUnwrap(defaultValue: 0, type.values[safe: row]) var value
        self.selectedValue = value
    }
}
