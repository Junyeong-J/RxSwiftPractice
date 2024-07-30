//
//  TableViewController.swift
//  RxSwiftProject
//
//  Created by 전준영 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class TableViewController: UIViewController {
    
    let tableView = UITableView()
    let disposeBag = DisposeBag()
    let label = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(tableView)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        setTableView()
    }
    
    private func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "AAAAA",
            "BBBBB",
            "CCCCC",
            "DDDDD",
            "EEEEE"
        ])
        
        items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭하셨습니다"
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
    }
    
}
