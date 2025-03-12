import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/**
 * phone_app_flutter
 * FileName : editForm
 * Class: editForm.
 * Created by 김승룡
 * Created On 2025-03-12.
 * Description: 전화번호 수정 폼
 */

class EditForm extends StatelessWidget {
  const EditForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("정보 수정"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Placeholder(),
    );
  }
}

class _EditForm extends StatefulWidget {
  const _EditForm({super.key});

  @override
  State<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  //  상태
  late int _phoneAppId;
  bool _completed = false;

  //  상수
  static const String apiEndpoint = "";

  final TextEditingController _textEditingController = TextEditingController();

  // didChangeDependencies메서드 = 위젯의 의존성이 변경될 때마다 때 호출
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //  ModalRoute.of(context)는 현재 라우트에 대한 정보를 제공
    //  전 페이지로부터 전달해 준 id 매개변수 받아오기
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // 매개변수가 null이 아니고 id 키를 포함하는지 확인
    if (args != null && args.containsKey('id')) {
      // 전달받은 id 값을 할당
      _phoneAppId = args['id'];
      //  해당 함수를 통해 목록 불러오기
      getPhoneApp(_phoneAppId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: "정보",
                  hintText: "정보를 입력하세요.",
                ),
              ),
            ),
            Checkbox(
              value: _completed,
              onChanged: (value) {
                setState(() {
                  // value가 null이면 _completed에 false를 할당
                  // null이 아니면 value를 할당
                  _completed = value ?? false;
                });
              },
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  updatePhoneApp();
                },
                child: Text("수정"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  서버로부터 PhoneApp을 가져오는 통신 함수 (GET)
  getPhoneApp(int _phoneAppId) async {
    try {
      // Dio 인스턴스를 생성
      var dio = Dio();
      dio.options.headers['Content-Type'] = "application/json";

      //  PhoneApp 받아오기
      final response = await dio.get("");

      if (response.statusCode == 200) {
        //  수정 폼에 출력할 정보 설정
        _textEditingController.text = response.data["title"];
        // 응답 데이터에서 완료 상태를 추출하여
        // _completed 변수에 설정하고, UI를 갱신
        setState(() {
          _completed = response.data["completed"];
        });
      }
    } catch (e) {
      throw Exception("데이터를 불러오지 못했습니다.:$e");
    }
  }

  //  변경된 PhoneApp을 서버로 반영하는 통신 함수 (PUT)
  updatePhoneApp() async {
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = "application/json";
      //  서버로 변경된 정보를 전송 (PUT)
      final response = await dio.put("", data: {});

      if (response.statusCode == 200) {
        //  TODO : Check
        //  성공적으로 수정되면 목록 페이지로 이동
        Navigator.pushNamed(context, "/");
      } else {
        throw Exception("API 서버 오류 입니다.");
      }
    } catch (e) {
      throw Exception("정보를 수정하지 못했습니다.:$e");
    }
  }
}
