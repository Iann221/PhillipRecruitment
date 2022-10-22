//
//  ChooseViewController.swift
//  PhillipsRecruitment
//
//  Created by Vincentius Ian Widi Nugroho on 21/10/22.
//

import UIKit
import SnapKit

var toolBar = UIToolbar()
var picker  = UIPickerView()

class ChooseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // untuk menentukan jarak button dari kiri layar
    var buttonLeftOffset: Double = 30
    var leftConstraint: Constraint? = nil
    var timer = Timer()
    var stocks = ["MNCN","GIAA","CAKK","ICBP","BTEK"]
    var chosenStocks = ""
    var stockFilter: [String] = []

    private lazy var chosenLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.textColor = .black
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var addButton: UIButton = {
       let view = UIButton()
        view.setTitle("Add Stock +", for: .normal)
        view.setTitleColor(.systemOrange, for: .normal)
        view.backgroundColor = .black
        view.layer.borderColor = UIColor.systemOrange.cgColor
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.addTarget(self, action: #selector(addStock), for: .touchUpInside)
        return view
    }()
    
    private lazy var applyButton: UIButton = {
        let view = UIButton()
        view.setTitle("Apply", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(apply), for: .touchUpInside)
        return view
    }()
    
    @objc func addStock(){
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
//        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        stockFilter.append(chosenStocks)
        chosenLabel.text = stockFilter.joined(separator: ", ")
        buttonLeftOffset = chosenLabel.intrinsicContentSize.width + 50
        updateConstraint()
    }
    
    @objc func apply(){
        TradeCollection.shared.filterParam = stockFilter
        stockFilter = []
        buttonLeftOffset = 30
        self.dismiss(animated: true)
    }
    
    func updateConstraint(){
        leftConstraint?.update(offset: buttonLeftOffset)
    }
    
    func configureUI(){
        
        view.addSubview(chosenLabel)
        chosenLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            leftConstraint = make.left.equalToSuperview().offset(buttonLeftOffset).constraint
            make.width.equalTo(120)
        }
        
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(50)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        stocks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stocks[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenStocks = stocks[row]
    }

}
