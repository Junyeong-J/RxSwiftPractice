//
//  UISwitchViewController.swift
//  RxSwiftProject
//
//  Created by 전준영 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class UISwitchViewController: UIViewController {
    
    let simpleSwitch = UISwitch()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(simpleSwitch)
        view.backgroundColor = .white
        simpleSwitch.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setSwitch() {
        Observable.of(false)
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
}
