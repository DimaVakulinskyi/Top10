//
//  DetailsViewController.swift
//  Top10
//
//  Created by Dmytro Vakulinsky on 09.05.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var occurrenceLabel: UILabel!
    
    var titleLabelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = titleLabelText {
            let characterCounts = countCharacterOccurrences(title)
            displayCharacterCounts(characterCounts)
        }
    }
    
    func displayCharacterCounts(_ characterCounts: [Character: Int]) {
        var resultText = ""
        
        let sortedCharacterCounts = characterCounts.sorted { $0.key < $1.key }
        
        for (character, count) in sortedCharacterCounts {
            resultText += "\(character): \(count)\n"
        }
        
        occurrenceLabel.text = resultText
    }
    
    func countCharacterOccurrences(_ inputString: String) -> [Character: Int] {
        var counts = [Character: Int]()
        
        for char in inputString {
            if let existingCount = counts[char] {
                counts[char] = existingCount + 1
            } else {
                counts[char] = 1
            }
        }

        return counts
    }
}
