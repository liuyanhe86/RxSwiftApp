//
//  MyTableViewModel.swift
//  RxSwiftApp
//
//  Created by 柳沿河 on 2024/5/26.
//

import RxCocoa

struct MyModel {
    var name: BehaviorRelay<Int>
    var value: BehaviorRelay<Int>
    
    init(name: BehaviorRelay<Int>, value: BehaviorRelay<Int>) {
        self.name = name
        self.value = value
    }
}
