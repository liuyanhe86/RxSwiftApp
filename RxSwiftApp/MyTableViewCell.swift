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

class MyTableViewCell: UITableViewCell {
    let nameLabel: UILabel = UILabel()
    let valueLabel: UILabel = UILabel()
    let increaseBtn: UIButton = UIButton(type: .custom)
    let selectBtn: UIButton = UIButton(type: .custom)
    
    var disposables: CompositeDisposable?
    var index: Int?
    
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
        
    func configure(at row: Int, with item: MyModel, viewModel: MyViewModel) {
        index = row
        disposables = CompositeDisposable()
        
        _ = disposables?.insert(
            item.name
            .map { "Item: \($0)" }
            .bind(to: nameLabel.rx.text)
        )
       
        _ = disposables?.insert(
            item.value
                .map { "Value: \($0)" }
                .bind(to: valueLabel.rx.text)
        )
        
        _ = disposables?.insert(
            increaseBtn.rx.tap
                .bind {
                    viewModel.increaseValue.accept(item)
                }
        )
        
        _ = disposables?.insert(
            selectBtn.rx.tap
                .bind {
                    viewModel.selectItem.accept(item)
                }
        )
    }
    
    override func prepareForReuse() {
        print("prepare to reuse: \(index ?? -1)")
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
