//
//  CentralController.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/07.
//

import UIKit
import CoreBluetooth
import CoreData

class CentralController:UIViewController{
    
    //MARK: - Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let lon:String
    let lat:String
    let contractView = ContractView()
    let nowDate = Date()
    var stringDate:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return dateFormatter.string(from: nowDate)
    }
    
    //MARK: - Bluetooth Properties
    
    private var centralManager = CBCentralManager()
    private var pendingPeripheral : CBPeripheral?
    private var peripheralManager = CBPeripheralManager()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "계 약 서"
    
        contractView.contractTextView.attributedText = contractView.contractTextView.writeContractword(nowDate)
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(boxTapped(_:)))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(boxTapped(_:)))
        
        contractView.agreeButtonView.button1.addGestureRecognizer(gesture1)
        contractView.agreeButtonView.button2.addGestureRecognizer(gesture2)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "전달하기", style: .plain, target: self, action: #selector(addTapped))
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        contractView.agreeButtonView.layoutIfNeeded()
        print("itss\(contractView.agreeButtonView.bounds.size.height)")
        
    }
    
    override func loadView() {
        view = contractView
    }
    
    init(lon:String, lat:String){
        self.lat = lat
        self.lon = lon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func boxTapped(_ sender:UITapGestureRecognizer){
        
        switch sender.view?.tag{
        case 1:
            if contractView.agreeButtonView.button2.image.isHidden == true, contractView.agreeButtonView.button1.image.isHidden == true {
                contractView.agreeButtonView.button1.image.isHidden.toggle()
            }
            else if contractView.agreeButtonView.button2.image.isHidden == false, contractView.agreeButtonView.button1.image.isHidden == true{
                contractView.agreeButtonView.button1.image.isHidden = false
                contractView.agreeButtonView.button2.image.isHidden = true
            }else{
                break
            }
        case 2:
            if contractView.agreeButtonView.button2.image.isHidden == true, contractView.agreeButtonView.button1.image.isHidden == true {
                contractView.agreeButtonView.button2.image.isHidden.toggle()
            }
            else if contractView.agreeButtonView.button2.image.isHidden == false, contractView.agreeButtonView.button1.image.isHidden == true{
                break
            }else{
                contractView.agreeButtonView.button1.image.isHidden = true
                contractView.agreeButtonView.button2.image.isHidden = false
            }
        default:
            break
        }
    }
    
    @objc func addTapped(){
        if !contractView.agreeButtonView.button1.image.isHidden, let safePeripheral = pendingPeripheral {
            safePeripheral.delegate = self
            centralManager.connect(safePeripheral)
            centralManager.stopScan()
        }else if !contractView.agreeButtonView.button2.image.isHidden, let safePeripheral = pendingPeripheral{
            alarmPopup("동의하지 않으셨습니다.", "계약서 동의란에 체크를 해주세요.")
        }else if pendingPeripheral == nil{
            alarmPopup("상대방이 연결되지 않았습니다","블루투스 연결을 위해, 상대방과 가까운 곳으로 이동해주세요.")
        }
    }
    
    func alarmPopup(_ value:String, _ value2:String){
        let alert = UIAlertController(title: value, message: value2, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(success)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveAgreement(){
        do{
            try context.save()
        }catch{
            print("DEBUG:error saving context")
        }
    }
    
    func decodeString(_ value:String)->Entitiy{
        let array = value.components(separatedBy: "|")
        let toSaveData = Entitiy(context: self.context)
        toSaveData.peripheralName = pendingPeripheral?.name
        toSaveData.lat = array[0]
        toSaveData.lon = array[1]
        toSaveData.stringDate = stringDate
        return toSaveData
    }
}



//MARK: - Bluetooth Central

extension CentralController:CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            central.scanForPeripherals(withServices: [TransferService.serviceUUID])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        guard RSSI.intValue >= -50 else {return}
        pendingPeripheral = peripheral
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([TransferService.serviceUUID])
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {return}
        for service in services{
            pendingPeripheral?.discoverCharacteristics([TransferService.rxCharacterUUID], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard let charac = service.characteristics else {return}
        for characteristic in charac where characteristic.uuid == TransferService.rxCharacterUUID{
            pendingPeripheral?.readValue(for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let value = characteristic.value else {return}
        let str = String(decoding: value, as: UTF8.self)
        let toShowData = decodeString(str)
        saveAgreement()
        let nextController = RecordViewController(entitiy: toShowData)
        navigationController?.pushViewController(nextController, animated: true)
    }
}

extension CentralController:CBPeripheralDelegate{
    
}

//MARK: - Bluetooth Peripheral

extension CentralController:CBPeripheralManagerDelegate{
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        if peripheral.state == .poweredOn{
            
            let advertisementData = String(format: "%@|%@", lat, lon).data(using: .utf8)
            
            let service = CBMutableService(type: TransferService.serviceUUID, primary: true)
            let rx = CBMutableCharacteristic(type: TransferService.rxCharacterUUID, properties: .read, value: advertisementData, permissions: .readable)
            service.characteristics = [rx]
            
            peripheralManager.add(service)
            
            peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey:[TransferService.serviceUUID]])
        }
    }
}
