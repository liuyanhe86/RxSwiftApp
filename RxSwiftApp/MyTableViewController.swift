//
//  MyTableViewController.swift
//  RxSwiftApp
//
//  Created by 柳沿河 on 2024/5/26.
//

import UIKit
import RxSwift

class MyTableViewController: UIViewController, UITableViewDelegate {
    var tableView: UITableView!
    var tableHeader: UILabel!
    var addBtn: UIButton!
    var viewModel: MyViewModel!
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        let navBarHeight = navigationController?.navigationBar.frame.maxY ?? 0
        
        let customView = UIView()
        customView.backgroundColor = .blue
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(navBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        addBtn = UIButton(type: .custom)
        addBtn.setTitle("add Item", for: .normal)
        addBtn.setTitleColor(.black, for: .normal)
        addBtn.backgroundColor = .gray
        customView.addSubview(addBtn)
        
        tableView = UITableView()
        tableView.rowHeight = 50
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        tableHeader = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        tableHeader.textColor = .black
        tableHeader.textAlignment = .center
        tableView.tableHeaderView = tableHeader
        customView.addSubview(tableView)
        
        addBtn.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints{make in
            make.top.equalTo(addBtn.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func setupBindings() {
        viewModel = MyViewModel(numOfItems: 20)
        viewModel.tableTitle
            .bind(to: tableHeader.rx.text)
            .disposed(by: disposeBag)
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "MyCell")) { (index, item: MyModel, cell: MyTableViewCell) in
            cell.configure(at: index, with: item, viewModel: self.viewModel)
        }.disposed(by: disposeBag)
        
        addBtn.rx.tap
            .bind(to: viewModel.addItem)
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .bind(to: viewModel.removeItem)
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

}
