//
//  PhoneViewController.swift
//  RxSwiftProject
//
//  Created by 전준영 on 8/3/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let phoneNumber = BehaviorSubject(value: "010")
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let descriptionLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureLayout()
        bind()
    }
    
    func bind() {
        phoneNumber
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        phoneTextField.rx.text.orEmpty
            .map { $0.filter { char in
                    guard Int(String(char)) != nil || String(char) == "" else { return false }
                    return true
                }
            }
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        let validation = phoneTextField
            .rx
            .text
            .orEmpty
            .map { $0.count >= 10 }
        
        validation
            .bind(with: self) { owner, value in
                owner.nextButton.backgroundColor = value ? UIColor.black : UIColor.gray
                owner.descriptionLabel.text = value ? "" : "10자 이상 입력해주세요"
                owner.nextButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(PasswordViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(nextButton)
        
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(phoneTextField)
            make.top.equalTo(phoneTextField.snp.bottom).offset(2)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
}
