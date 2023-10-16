//
//  ViewController.swift
//  Counter
//
//  Created by Андрей Тапалов on 13.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterUILabel: UILabel!
    @IBOutlet weak var increaseCount: UIButton!
    @IBOutlet weak var reduceCountButton: UIButton!
    @IBOutlet weak var resetCounterButton: UIButton!
    @IBOutlet weak var textViewMessages: UITextView!
    
    var formattedCurrentDate: String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy, HH:mm:ss"
        return dateFormatter.string(from: currentDate)
    }
    
    var messages: [String] = [] {
        didSet {
            textViewMessages.text.append(messages.last ?? "")
        }
    }
    
    var countToChange = 1 //устанавливается значение на которое будет изменяться counter
    var counter = 0 {
        didSet {
            counterUILabel.text = String(counter)
            if counter > oldValue {
                messages.append("[\(formattedCurrentDate)]: значение изменено на +\(countToChange)\n")
            } else if oldValue > counter && reduceCountButton.isTouchInside{
                messages.append("[\(formattedCurrentDate)]: значение изменено на -\(countToChange)\n")
            }
            
        }
    }
    
    override func viewDidLoad() {
        textViewMessages.text = "История изменений:\n\n"
        textViewMessages.layer.borderWidth = 1
        textViewMessages.layer.cornerRadius = 10
        
        counterUILabel.text = String(counter)
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    @IBAction func increaseCount(_ sender: Any) {
        counter += countToChange
    }
    
    @IBAction func reduceCount(_ sender: Any) {
        if counter > 0 {
            counter -= countToChange
        } else {
            messages.append("[\(formattedCurrentDate)]: попытка уменьшить значение счётчика ниже 0\n")
        }
    }
    
    @IBAction func resetCounter(_ sender: Any) {
        counter = 0
        messages.append("[\(formattedCurrentDate)]: значение сброшено\n")
    }
    
}

