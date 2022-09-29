//
//  MainController.swift
//  AgreementForUs
//
//  Created by 황원상 on 2022/09/06.
//

import UIKit
import CoreLocation
import JGProgressHUD
import CoreData

class MainController:UIViewController{
    
    //MARK: - Properties
    
    let mainView = Main()
    let locationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    var lon:CLLocationDegrees?
    var lat:CLLocationDegrees?
    let hud = JGProgressHUD()
    
    var stringLon:String{
        guard let stringLon = lon else {return "error"}
        let a = String(stringLon)
        let b = Int(Double(a)!.rounded())
        return "\(b)"
    }
    
    var stringLat:String{
        guard let stringLat = lat else {return "error"}
        let a = String(stringLat)
        let b = Int(Double(a)!.rounded())
        return "\(b)"
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud.textLabel.text = "위치정보를 읽고있습니다."
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = false
        
        mainView.topButton.addTarget(self, action: #selector(topButtonTapped), for: .touchUpInside)
        mainView.downButton.addTarget(self, action: #selector(downButtonTapped), for: .touchUpInside)
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(isFirstTime), userInfo: nil, repeats: false)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView?.isHidden = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        hud.show(in: self.view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.titleView?.isHidden = false
    }
    
    //MARK: - Actions
    
    @objc func isFirstTime(){
        if let password = defaults.array(forKey: "UserPassword") as? [String] {
            let nextVC = PasswordController(firstVisit: false)
            nextVC.passwordArray = password
            navigationController?.pushViewController(nextVC, animated: true)
        }else{
            let nextVC = PasswordController(firstVisit: true)
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @objc func topButtonTapped(){
        guard let lon = lon, let lat = lat else {
            resetAlarmPopup("위치서비스 이용에 실패했습니다", "위치 서비스를 확인하고 다시 시도해주세요")
            return
        }
        let controller = CentralController(lon: stringLon, lat: stringLat)
        navigationController?.pushViewController(controller, animated: false)
    }
    
    @objc func downButtonTapped(){
        let nextVc = RecordViewController()
        navigationController?.pushViewController(nextVc, animated: true)
    }
    func resetAlarmPopup(_ value:String, _ value2:String){
        let alert = UIAlertController(title: value, message: value2, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(success)
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - CLLocationManagerDelegate

extension MainController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location  = locations.last else {return}
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        hud.dismiss(animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        func locationManager(_: CLLocationManager, didFailWithError error: Error) {
            let err = CLError.Code(rawValue: (error as NSError).code)!
            switch err {
            case .locationUnknown:
                hud.dismiss(animated: true)
                resetAlarmPopup("위치정보 오류", "위치 정보를 가지고 올 수 없습니다. 위치를 조금만 이동하고 다시 시도해주세요")
            default:
                resetAlarmPopup("위치정보 오류", "위치 정보를 가지고 올 수 없습니다. 핸드폰의 GPS 기능을 확인해주세요.")
            }
        }
        
    }
}

