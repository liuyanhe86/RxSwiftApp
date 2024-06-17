//
//  MyViewModel.swift
//  RxSwiftApp
//
//  Created by 柳沿河 on 2024/5/26.
//

import RxSwift
import RxCocoa

class MyViewModel: NSObject {
    var tableTitle: BehaviorRelay<String>
    var items: BehaviorRelay<[MyModel]>
    let addItem = PublishRelay<Void>()
    let removeItem = PublishRelay<IndexPath>()
    let increaseValue = PublishRelay<MyModel>()
    let selectItem = PublishRelay<MyModel>()
    let disposeBag = DisposeBag()
    
    init(numOfItems: Int) {
        tableTitle = BehaviorRelay(value: "Table Header")
        items = BehaviorRelay(value: [])
        var currentItems = items.value
        for i in 0...numOfItems {
            currentItems.append(MyModel(name: BehaviorRelay(value: numOfItems - i), value: BehaviorRelay(value: 0)))
        }
        items.accept(currentItems)
        
        super.init()
        
        addItem.subscribe(onNext: { _ in
            var currentItems = self.items.value
            let lastItem = currentItems.first?.name.value
            currentItems.insert((MyModel(name: BehaviorRelay(value: (lastItem ?? -1) + 1), value: BehaviorRelay(value: 0))), at: 0)
            self.items.accept(currentItems)
        }).disposed(by: disposeBag)
        
        increaseValue.subscribe(onNext: { item in
            let value = item.value.value
            item.value.accept(value + 1)
        }).disposed(by: disposeBag)
        
        selectItem.subscribe(onNext: { item in
            self.tableTitle.accept("Select Item: #\(item.name.value)")
        }).disposed(by: disposeBag)
        
        removeItem.subscribe(onNext: {indexPath in
            var currentItems = self.items.value
            currentItems.remove(at: indexPath.row)
            self.items.accept(currentItems)
        }).disposed(by: disposeBag)
    }
    
}
