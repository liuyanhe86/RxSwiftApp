//
//  ViewController.swift
//  RxSwiftApp
//
//  Created by 柳沿河 on 2024/5/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    let disposeBag : DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let showTableButton : UIButton = {
            let btn = UIButton(type: .custom)
            btn.setTitle("show TableView", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.layer.borderColor = UIColor.black.cgColor
            btn.layer.borderWidth = 1
            btn.rx.tap.subscribe{ _ in
                self.navigationController?.pushViewController(MyTableViewController(), animated: true)
            }.disposed(by: disposeBag)
            return btn
        }()
        self.view.addSubview(showTableButton)
        showTableButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }


}

