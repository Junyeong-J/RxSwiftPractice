//
//  SimpleValidationViewController.swift
//  RxSwiftProject
//
//  Created by 전준영 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController : UIViewController {

    let disposeBag = DisposeBag()
    
    let usernameLabel = UILabel()
    var usernameOutlet = UITextField()
    var usernameValidOutlet = UILabel()

    let passwordLabel = UILabel()
    var passwordOutlet = UITextField()
    var passwordValidOutlet = UILabel()

    var doSomethingOutlet = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureView()
        
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"

        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)

        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)

        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)

        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)

        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }

    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func configureView() {
        view.addSubview(usernameLabel)
        view.addSubview(usernameOutlet)
        view.addSubview(usernameValidOutlet)
        
        view.addSubview(passwordLabel)
        view.addSubview(passwordOutlet)
        view.addSubview(passwordValidOutlet)
        
        view.addSubview(doSomethingOutlet)
        
        usernameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        usernameOutlet.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.height.equalTo(44)
        }
        
        usernameValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(usernameOutlet.snp.bottom).offset(4)
            make.leading.equalTo(usernameOutlet)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(usernameValidOutlet.snp.bottom).offset(20)
        }
        
        passwordOutlet.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.height.equalTo(44)
        }
        
        passwordValidOutlet.snp.makeConstraints { make in
            make.top.equalTo(passwordOutlet.snp.bottom).offset(4)
            make.leading.equalTo(passwordOutlet)
        }
        
        doSomethingOutlet.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(passwordValidOutlet.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        usernameLabel.text = "Username"
        passwordLabel.text = "Password"
        usernameOutlet.backgroundColor = .gray
        passwordOutlet.backgroundColor = .gray
        doSomethingOutlet.backgroundColor = .green
    }
}
