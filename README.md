# 사랑계약서 (앱스토어 리젝티드)

# Guideline 1.1.6 - Safety - Objectionable Content 위반



## 프로젝트 설명

1. 프로젝트로서 기존 앱스토어에 없던 것을 만들고 싶었음.
2. 사회적 과도기(?)에서 소비자들에게 필요한 것이 무엇일까 생각함.
3. 해외엔 이러한 앱이 존재. 언젠간 생길 것 이라고 생각했음.

## 프로젝트 진행

1. 사랑계약서의 법적자료 채택 가능성을 확인. (법적 참고자료로 사용가능)
2. 양성간의 어느 한쪽에 치우치지 않게, 인터넷에 작성된 계약서를 작성.

## 프로젝트 기술구현

1. 암호화 -> 앱 사용의 순서를 디자인. 불의의 상황 및 사생활 보호를 대비해, 암호화가 필요하다고 생각.
2. 암호는 userdefault를 통해 간단한 암호로 구성예정 -> 키체인으로 앱 업데이트 예정이었음.
3. 계약의 해당 위치 (좌표) , 시간 및 사용자 간단정보(기기이름)을 데이터화하여 맞교환.
4. 데이터 교환은 블루투스로 진행(사용자 to 사용자의 데이터 교환이 사생활을 최대한 보장한다고 생각)
5. 교환한 데이터는 NSCoreData로 핸드폰에 저장하고, 이 데이터를 확인할 수 있음.

## 프로젝트 사진

