//
//  BookSingleViewController.swift
//  BooksList
//
//  Created by NB MacBook on 9/12/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import UIKit
import Kingfisher

class BookSingleViewController: UIViewController {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var data: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBookData()
    }
    
    func setupBookData() {
        bookImage.kf.setImage(with: URL(string: data?.image ?? ""))
        bookTitle.text = data?.title
        authorLabel.text = data?.author
        publisherLabel.text = data?.publisher
        descriptionText.attributedText = markChars()
        descriptionText.textAlignment = .center
    }
    
    func markChars() -> NSMutableAttributedString {
        let wordsArray: [String] = self.data?.description.components(separatedBy: " ") ?? []
        var attributedStringArray: [NSMutableAttributedString] = []
        for word in wordsArray {
            attributedStringArray.append(NSMutableAttributedString(string: word, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.darkGray]))
            let attribute = NSMutableAttributedString(string: word)
            if let index = word.range(of: "a")?.upperBound, let itemIndex = wordsArray.firstIndex(where: {$0 == word}) {
                let suffix = word.suffix(from: index)
                let prefix = word.prefix(upTo: index)
                let suffixRange = (word as NSString).range(of: String(suffix))
                let prefixRange = (word as NSString).range(of: String(prefix))
                attribute.setAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.green], range: suffixRange)
                attribute.setAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.darkGray], range: prefixRange)
                attributedStringArray[itemIndex] = attribute
            }
        }
        return markMostOccurredChar(attributedStringArray.joined(with: " "))
    }
    
    func markMostOccurredChar(_ attrString: NSMutableAttributedString) -> NSMutableAttributedString {
        var counters = [Character: Int]()

        for c in attrString.string {
            if c != " " {
                counters[c] = (counters[c] ?? 0) + 1
            }
        }

        let maxElement = counters.reduce(counters.first!) { $1.1 > $0.1 ? $1 : $0 }
        do {
            let regex = try NSRegularExpression(pattern: String(maxElement.0), options: .caseInsensitive)

            for match in regex.matches(in: attrString.string, options: .withTransparentBounds, range: NSRange(location: 0, length: attrString.string.utf16.count)) as [NSTextCheckingResult] {
                attrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: match.range)
            }
            return attrString
        } catch {
            NSLog("Error creating regular expresion for most occured character")
            return attrString
        }
    }
    
    @IBAction func buyButtonAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "buyBookViewController") as! BuyBookViewController
        vc.data = self.data?.links
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
