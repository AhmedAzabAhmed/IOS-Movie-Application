//
//  Reviews.swift
//  MovieApp
//
//  Created by azab on 3/11/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation

class Reviews {
    var content : String?
    var author : String?
    
    init(author : String?, content : String?) {
        self.author = author
        self.content = content
    }
}
