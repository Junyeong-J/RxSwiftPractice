//
//  ViewController.swift
//  RxSwiftProject
//
//  Created by 전준영 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let itemsA = [3.3, 2.5, 6.2, 4.5, 3.7, 2.8]
        let itemsB = [2.3, 4.4, 6.1]
        
        //just
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just completed")
            } onDisposed: {
                print("just disposed")
            }
            .disposed(by: disposeBag)
        
        //of
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of completed")
            } onDisposed: {
                print("of disposed")
            }
            .disposed(by: disposeBag)

        //from
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from completed")
            } onDisposed: {
                print("from disposed")
            }
            .disposed(by: disposeBag)
        
        //take
        Observable.repeatElement("Ethan")
            .take(5)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat completed")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)
        
    }


}

