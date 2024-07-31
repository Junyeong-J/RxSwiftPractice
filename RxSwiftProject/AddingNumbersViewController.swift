//
//  AddingNumbersViewController.swift
//  RxSwiftProject
//
//  Created by 전준영 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AddingNumbersViewController: UIViewController {
    
    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    let plusLabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        return label
    }()
    let line = UIView()
    
    
    let result = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(line)
        view.addSubview(plusLabel)
        view.addSubview(result)
        
        number3.snp.makeConstraints { make in
            make.width.equalTo(97)
            make.height.equalTo(30)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        number2.snp.makeConstraints { make in
            make.width.equalTo(97)
            make.height.equalTo(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(number3.snp.top).offset(-8)
        }
        
        number1.snp.makeConstraints { make in
            make.width.equalTo(97)
            make.height.equalTo(30)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(number2.snp.top).offset(-8)
        }
        
        plusLabel.snp.makeConstraints { make in
            make.trailing.equalTo(number3.snp.leading).offset(-4)
            make.centerY.equalTo(number3)
        }
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(plusLabel)
            make.trailing.equalTo(number3)
            make.top.equalTo(number3.snp.bottom).offset(4)
        }
        
        result.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(4)
            make.trailing.equalTo(number3.snp.trailing)
        }
        
        number1.backgroundColor = .gray
        number2.backgroundColor = .gray
        number3.backgroundColor = .green
        
        line.backgroundColor = .black
        
        
    }
    
}
