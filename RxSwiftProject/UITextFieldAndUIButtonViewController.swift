//
//  UITextFieldAndUIButtonViewController.swift
//  RxSwiftProject
//
//  Created by 전준영 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class UITextFieldAndUIButtonViewController: UIViewController {
    
    let signName = UITextField()
    let signEmail = UITextField()
    let simpleLabel = UILabel()
    let signButton = UIButton()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(signName)
        view.addSubview(signEmail)
        view.addSubview(simpleLabel)
        view.addSubview(signButton)
        signName.backgroundColor = .red
        signEmail.backgroundColor = .green
        signButton.backgroundColor = .yellow
        
        signName.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(44)
        }
        
        signEmail.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(signName.snp.bottom).offset(10)
            make.height.equalTo(44)
        }
        
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(signEmail.snp.bottom).inset(10)
            make.centerX.equalTo(signEmail)
        }
        
        signButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        
        setSign()
    }
    
    func setSign() {
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { value1, value2 in
            return "name은 \(value1)이고, 이메일은 \(value2)입니다"
        }
        .bind(to: simpleLabel.rx.text)
        .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .subscribe { _ in
                self.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "확인", message: "성공", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


