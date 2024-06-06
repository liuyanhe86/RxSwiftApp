//
//  MyTableViewCell.swift
//  RxSwiftApp
//
//  Created by 柳沿河 on 2024/5/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

extension Reactive where Base: MyTableViewCell {
    
    var increaseBtnTap: ControlEvent<IndexPath> {
        let source = base.increaseBtn.rx.tap
            .compactMap { [weak base] in
                base?.indexPath
            }
        return ControlEvent(events: source)
    }
    
    var selectBtnTap: ControlEvent<IndexPath> {
        let source = base.selectBtn.rx.tap
            .compactMap { [weak base] in
                base?.indexPath
            }
        return ControlEvent(events: source)
    }
}

class MyTableViewCell: UITableViewCell {
    let nameLabel: UILabel = UILabel()
    let valueLabel: UILabel = UILabel()
    let increaseBtn: UIButton = UIButton(type: .custom)
    let selectBtn: UIButton = UIButton(type: .custom)
    
    var disposables: CompositeDisposable?
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.textColor = UIColor.black
        valueLabel.textColor = UIColor.black
        
        increaseBtn.setTitle("increase", for: .normal)
        increaseBtn.setTitleColor(.black, for: .normal)
        increaseBtn.layer.borderColor = UIColor.black.cgColor
        increaseBtn.layer.borderWidth = CGFloat(1)
        
        selectBtn.setTitle("select", for: .normal)
        selectBtn.setTitleColor(.black, for: .normal)
        selectBtn.layer.borderColor = UIColor.black.cgColor
        selectBtn.layer.borderWidth = CGFloat(1)

        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(valueLabel)
        self.contentView.addSubview(increaseBtn)
        self.contentView.addSubview(selectBtn)
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        valueLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        increaseBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(200)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        selectBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(increaseBtn.snp.right).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    override func prepareForReuse() {
        print("prepare to reuse: \(indexPath?.row ?? -1)")
        disposables?.dispose()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit cell")
        disposables?.dispose()
    }

}
