//
//  RecordViewController.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/26.
//

import UIKit
import CoreData

class RecordViewController:UIViewController{

    //MARK: - Properties
    let tableView = UITableView()
    var array:[Entitiy]?
    var entitiy:Entitiy?
    let header = RecordHeader()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start()
        
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "thecell")
        tableView.tableHeaderView = header
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        header.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = "기 록"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(addTapped))
        
    }
    
    //MARK: - Actions
    
    func start(){
        if entitiy != nil{
            return
        } else {
            loadData()
        }
    }
    
    func loadData(){
        let request:NSFetchRequest<Entitiy> = Entitiy.fetchRequest()
        do{
            array = try context.fetch(request)
        }catch{
            print("DEBUG:error in fetching data")
        }
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    init(entitiy:Entitiy){
        self.entitiy = entitiy
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addTapped(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

//MARK: - UitableViewDataSource

extension RecordViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thecell", for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        
        if let entitiy = entitiy{
            cell.label1.text = entitiy.stringDate
            cell.label2.text = entitiy.peripheralName
            cell.label3.text = entitiy.lat
            cell.label4.text = entitiy.lon
            return cell
        }
        cell.label1.text = array![indexPath.row].stringDate
        cell.label2.text = array![indexPath.row].peripheralName
        cell.label3.text = array![indexPath.row].lat
        cell.label4.text = array![indexPath.row].lon
        return cell
    }
    
    
}

//MARK: - UiTableViewDelegate

extension RecordViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
