//
//  TradeCollection.swift
//  PhillipsRecruitment
//
//  Created by Vincentius Ian Widi Nugroho on 21/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class TradeCollection {
    var trades = BehaviorSubject(value: [Trade]())
    var filteredTrades = BehaviorSubject(value: [Trade]())
    var filterParam: [String] = []
    static let shared = TradeCollection()
    private var bag = DisposeBag()
    
    func filter(){
        trades.subscribe(onNext: { [self] event in
            if(filterParam.count == 0){
                filteredTrades.on(.next(event))
            } else {
                var filtered: [Trade] = []
                for i in filterParam{
                    filtered.append(contentsOf: event.filter {
                        $0.stock == i
                    })
                }
                filtered = filtered.sorted(by: { $0.time.compare($1.time) == .orderedDescending })
                filteredTrades.on(.next(filtered))
            }
        }).disposed(by: bag)
    }
    
}
