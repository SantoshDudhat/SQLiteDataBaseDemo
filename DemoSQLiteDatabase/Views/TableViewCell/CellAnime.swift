//
//  CellAnime.swift
//  DemoSQLiteDatabase
//
//  Created by DREAMWORLD on 23/11/24.
//

import UIKit

class CellAnime: UITableViewCell {

    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgVw.layer.cornerRadius = imgVw.frame.height / 2
    }
}
