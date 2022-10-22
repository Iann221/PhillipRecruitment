//
//  TradeCell.swift
//  PhillipsRecruitment
//
//  Created by Vincentius Ian Widi Nugroho on 21/10/22.
//

import UIKit

class TradeCell: UITableViewCell {
    
    var trade : Trade? {
        didSet {
            stockLabel.text = trade?.stock
            priceLabel.text = "\(trade!.price)"
            chgLabel.text = "\(trade!.chg)%"
            volLabel.text = "\(trade!.vol)"
            actLabel.text = trade?.act
            timeLabel.text = dateFormatter.string(from: trade!.time)
            if (trade!.chg > 0){
                stockLabel.textColor = .systemGreen
                priceLabel.textColor = .systemGreen
                chgLabel.textColor = .systemGreen
            } else if (trade!.chg < 0) {
                stockLabel.textColor = .systemRed
                priceLabel.textColor = .systemRed
                chgLabel.textColor = .systemRed
            } else {
                stockLabel.textColor = .systemOrange
                priceLabel.textColor = .systemOrange
                chgLabel.textColor = .systemOrange
            }
        }
    }
    
    let dateFormatter = DateFormatter()
    
    lazy var tradeView: UIView = {
       let view = UIView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stockLabel: UILabel = {
       let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()
    
    lazy var priceLabel: UILabel = {
       let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()
    
    lazy var chgLabel: UILabel = {
       let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()
    
    lazy var volLabel: UILabel = {
       let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()

    lazy var actLabel: UILabel = {
       let view = UILabel()
        view.textColor = .green
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()
    
    lazy var timeLabel: UILabel = {
       let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
       let view = UIStackView(arrangedSubviews: [stockLabel,priceLabel,chgLabel,volLabel,actLabel,timeLabel])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 5
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "TradeCell")
        addSubview(tradeView)
        dateFormatter.dateFormat = "HH:mm:ss"
        setTradeViewLayout()
        tradeView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTradeViewLayout(){
        tradeView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        tradeView.centerXAnchor.constraint(equalTo: centerXAnchor,constant: 0).isActive = true
        tradeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tradeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tradeView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tradeView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
        
}

