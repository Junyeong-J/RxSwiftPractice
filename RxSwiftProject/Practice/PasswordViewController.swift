//
//  PasswordViewController.swift
//  RxSwiftProject
//
//  Created by 전준영 on 8/1/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PasswordViewController: UIViewController {
    
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let descriptionLabel = UILabel()
    let basicColor = Observable.just(UIColor.red)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
        bind()
    }
    
    func bind() {
        
        //8자리 이상일때
        let validation = passwordTextField
            .rx
            .text
            .orEmpty
            .map { $0.count >= 8 }
        
        //조건에따라 변함
        validation.bind(with: self) { owner, value in
            owner.nextButton.backgroundColor = value ? UIColor.black : UIColor.gray
            owner.descriptionLabel.isHidden = value
            owner.nextButton.isEnabled = value
        }
        .disposed(by: disposeBag)
        
        //버튼 터치후 다음 화면 이동
        nextButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(UITextFieldAndUIButtonViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    func configureLayout() {
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
        view.addSubview(descriptionLabel)
        
        descriptionLabel.text = "8자 이상 입력해주세요"
        
        basicColor
            .bind(to: descriptionLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField).inset(3)
            make.top.equalTo(passwordTextField.snp.bottom).offset(3)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
}
