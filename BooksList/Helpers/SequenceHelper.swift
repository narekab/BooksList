//
//  SequenceHelper.swift
//  BooksList
//
//  Created by NB MacBook on 9/12/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element == NSMutableAttributedString {
    func joined(with separator: NSMutableAttributedString) -> NSMutableAttributedString {
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if r.length > 0 {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }

    func joined(with separator: String = "") -> NSMutableAttributedString {
        return self.joined(with: NSMutableAttributedString(string: separator))
    }
}
