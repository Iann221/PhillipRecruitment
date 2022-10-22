//
//  MainViewController.swift
//  PhillipsRecruitment
//
//  Created by Vincentius Ian Widi Nugroho on 21/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UITableViewController {
    
    let cellId = "TradeCell"
    var originTrade: [Trade] = []
    var filteredTrade : [Trade] = [Trade]() {
        didSet {
            tableView.reloadData()
        }
    }
    var timer = Timer()
    private var bag = DisposeBag()
    var randomStocks = ["MNCN","GIAA","CAKK","ICBP","BTEK"]
    var randomPrice = [50, 191, 410, 8450, 99]
    var randomchg = [0.00,3.80,5.67,-3.67,-5.10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "RUNNING TRADE"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(choose))
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { [self] _ in
            let randSt = randomStocks.randomElement()
            let randInt = Int.random(in: 0..<5)
            originTrade.insert(Trade(stock: randSt!, price: randomPrice[randInt], chg: randomchg[randInt], vol: Int.random(in: 0..<1000), act: "BU", time: Date()), at: 0)
            TradeCollection.shared.trades.on(.next(originTrade))
        })
        TradeCollection.shared.filter()
        TradeCollection.shared.filteredTrades.subscribe(onNext: { [self] event in
            filteredTrade = event
        }).disposed(by: bag)
        tableView.register(TradeCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TradeCell
        let currentLastItem = filteredTrade[indexPath.row]
         cell.trade = currentLastItem
        return cell
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTrade.count
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    @objc func choose() {
        let avc = ChooseViewController()
        avc.modalPresentationStyle = .formSheet
        present(avc, animated: true, completion: nil)
    }
    

}
