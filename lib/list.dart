import 'package:flutter/material.dart';
import 'package:phone_app_flutter/phoneAppVo.dart';
import 'package:dio/dio.dart';

/**
 * phone_app_flutter
 * FileName : list
 * Class: list.
 * Created by 김승룡.
 * Created On 2025-03-12.
 * Description: 목록 조회
 */

// StatelessWidget 상태가 없는 위젯으로, 생성 후에는 상태를 변경불가
// 정적 UI요소 표시할 때 사용
class PhoneAppList extends StatelessWidget {
  const PhoneAppList({super.key});

  // Scaffold는 Flutter에서 기본적인 앱 레이아웃을 제공하는 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("전화번호부 리스트"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(color: Colors.blue[100], child: Placeholder()),
      // FloatingActionButton은 앱의 주요 액션을 수행할 수 있는 버튼
      floatingActionButton: FloatingActionButton(
        // 버튼이 눌렸을 때 실행할 함수를 설정
        onPressed: () {
          //  작성 폼(wirte) 으로 이동
          Navigator.pushNamed(context, "");
        },
        // 버튼에 표시할 아이콘을 설정
        child: Icon(Icons.add),
      ),
    );
  }
}

// _PhoneAppList는 StatefulWidget을 상속받은 클래스
// 상태가 있는 위젯으로, 생성 후에도 상태를 변경가능
// 동적 UI요소 표시하거나 사용자 입력 처리때 사용
class _PhoneAppList extends StatefulWidget {
  const _PhoneAppList({super.key});

  @override
  State<_PhoneAppList> createState() => _PhoneAppListState();
}

// _PhoneAppListState는 _PhoneAppList의 상태를 관리하는 클래스
class _PhoneAppListState extends State<_PhoneAppList> {
  //  상태를 정의
  //  late : 선언시 할당하지 않고, 나중에 할당되는 변수
  late Future<List<PhoneAppVo>> phoneAppListFuture;

  //  상태 초기화
  //  위젯이 처음 생성될 때 호출되는 메서드로, 초기 상태를 설정하는 데 사용
  //  위젯 생성된 후 단 한번만 호출

  @override
  void initState() {
    //  단 한번만 발생
    super.initState();
  }

  //  의존성이 변경될 때
  //  위젯의 의존성이 변경될 때 호출되는 메서드로,
  //  의존성에 따라 데이터를 갱신하거나 작업을 수행
  //  initState 이후에 호출되며, 의존성이 변경될 때마다 다시 호출
  //  주로 API 호출이나 데이터 갱신 작업에 사용

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phoneAppListFuture = getPhoneAppList(); //  서버로부터 데이터 수신
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: phoneAppListFuture, //  감시할 Future 객체
      //  Future의 상태에 따라 UI를 생성하는 콜백 함수
      builder: (context, snapshot) {
        print("snapshot: $snapshot");
        //  상태 정보 체크
        //  waiting = 데이터가 로딩 중
        //  hassError = 에러발생 여부
        //  haseData = 데이터 존재 여부
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Center함수는 Flutter에서 자식 위젯을 부모 위젯의 중앙에 위치시키는 역할
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("데이터 불러오기 실패!!!!!!!!!!: ${snapshot.error}"),
          );
        } else if (!snapshot.hasData) {
          return Center(child: Text("전화번호가 없습니다."));
        } else {
          return Center(child: Text("데이터 수신 성공!!!!!!!!!!!!!!"));
        }
      },
    );
  }

  // 서버로부터 PhoneAppItem 목록을 받아오는 통신 메서드
  // lutter에서 Dio 라이브러리를 사용하여 서버로부터
  // 전화번호 목록을 가져오는 비동기 통신 메서드
  // GET요청을 통해 서버에서 받아와 PhoneAppVo 객체로 변환하여 반환
  Future<List<PhoneAppVo>> getPhoneAppList() async {
    try {
      //  요청
      var dio = new Dio(); //  Dio 인스턴스
      //  헤더 설정 : 데이터를 json 형식으로 주고 받겠다는 약속
      dio.options.headers['Content-Type'] = "application/json";
      //  서버로 목록 요청
      final response = await dio.get("");
      //  응답
      if (response.statusCode == 200) {
        //  성공
        //  데이터를 확인
        print(response.data); //  json list
        print(response.data.length); //  json list 아이템 항목 수
        print(response.data[0]); //  list 중 첫 번째 아이템

        //  결과 변수
        List<PhoneAppVo> phoneAppList = [];

        for (int i = 0; i < response.data.length; i++) {
          //  개별 아이템 꺼내오기
          PhoneAppVo phoneAppVo = PhoneAppVo.fromJson(response.data[i]);
          //  목록에 추가
          phoneAppList.add(phoneAppVo);
        }

        return phoneAppList;
      } else {
        throw Exception("api 서버 오류");
      }
    } catch (e) {
      throw Exception("전화번호 목록을 불러오는데 실패했습니다. : $e");
    }
  }
}
