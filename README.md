# 사랑계약서 (앱스토어 리젝티드)

# Guideline 1.1.6 - Safety - Objectionable Content 위반



## 프로젝트 설명

1. 프로젝트로서 기존 앱스토어에 없던 것을 만들고 싶었음.
2. 사회적 과도기(?)에서 소비자들에게 필요한 것이 무엇일까 생각함.
3. 해외엔 이러한 앱이 존재. 언젠간 생길 것 이라고 생각했음.
4. 코시국 백신인증 절차에 대한 사생활 보호 논란을 겪으며, 개인 to 개인간의 동의가 이 앱에는 적절하닥 판단.

## 프로젝트 진행

1. 사랑계약서의 법적자료 채택 가능성을 확인. (법적 참고자료로 사용가능)
2. 양성간 어느 한쪽에 치우치지 않게, 인터넷에 작성된 계약서를 작성.

## 프로젝트 기술구현

1. 암호화. 불의의 상황 및 사생활 보호를 대비해, 암호화가 필요하다고 생각.
2. 암호는 userdefault를 통해 간단한 암호로 구성예정 -> 키체인으로 앱 업데이트 예정이었음.
3. 계약의 해당 위치 (CoreLocation) , 시간 및 사용자 간단정보(기기이름)을 데이터화하여 맞교환.
4. 데이터 교환은 CoreBluetooth로 진행(사용자 to 사용자의 데이터 교환이 사생활을 최대한 보장한다고 생각)
5. 교환한 데이터는 CoreData로 핸드폰에 저장하고, 이 데이터를 확인할 수 있음.

## 프로젝트 사진
![11](https://user-images.githubusercontent.com/92086662/201171185-e7ee3fde-5040-4b1a-bfac-0f7a79d8cd1e.gif)

앱이 시작되면 메인화면에서 현재의 위도오 경도를 저장하고 계약서 전송 컨트롤러로 데이터를 넘깁니다.
계약서 전송 컨트롤러에서는 CentralMnager와 Peripheral의 기능을 동시에 수행합니다.
계약 전송 View에 접근하면, 동일한 uuid를 지니고 가까이 있는 기기를 찾아서 자도 연결을하는 동시에(CentralManager) 
uuid와 현재 본인의 위도, 경도를 characteristic으로 promoting하는(Peripheral) 역할을 수행합니다.


<details>
<summary>코드보기</summary>

'''Swift
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
  
  '''
  

</details>



## 회고
1. 앱스토어에 없는덴 다 이유가 있다.
2. 가이드 라인을 읽어보는 계기가 되었다.
3. 오토레이 아웃을 확실하게 공부하는 계기가 되었다.

