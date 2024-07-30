//
//  PickerViewController.swift
//  RxSwiftProject
//
//  Created by 전준영 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PickerViewController: UIViewController {
    
    let simplePickerView = UIPickerView()
    let label = UILabel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(simplePickerView)
        view.addSubview(label)
        simplePickerView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        setPickerView()
    }
    
    private func setPickerView() {
        let items = Observable.just([
            "영화",
            "애니메이션",
            "드라마",
            "기타"
        ])
        
        items
            .bind(to: simplePickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        
        simplePickerView.rx.modelSelected(String.self)
            .map({ $0.description })
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
}
