import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/**
 * phone_app_flutter
 * FileName : wirteForm
 * Class: wirteForm.
 * Created by 김승룡
 * Created On 2025-03-12.
 * Description: 전화번호부 추가
 */

class WriteForm extends StatelessWidget {
  const WriteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("전화번호 추가"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _WriteForm(),
    );
  }
}

class _WriteForm extends StatefulWidget {
  const _WriteForm({super.key});

  @override
  State<_WriteForm> createState() => _WriteFormState();
}

class _WriteFormState extends State<_WriteForm> {
  //  상수
  //  flutter는 lowCamelCase로 작성 해야함
  // static const String apiEndpoint = "";

  // TextEditingController를 사용하여 텍스트 필드의 입력 값을 관리
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Container는 Flutter에서 자식 위젯을 감싸고,
    // 다양한 속성을 통해 레이아웃과 외관을 조정할 수 있는 위젯
    // Form은 여러 폼 필드를 관리하는 데 사용 (TextFormField)
    // Column은 자식 위젯을 수직으로 나열하는 레이아웃 위젯(TextFormField과 ElevatedButton)

    return Container(
      child: Form(
        child: Column(
          children: <Widget>[
            //  margin 설정
            Container(
              margin: EdgeInsets.all(10),
              // TextFormField은 사용자가 텍스트를 입력할 수 있는 폼 필드
              child: TextFormField(
                controller: _textEditingController,
                // 속성을 통해 레이블과 힌트 텍스트를 설정
                decoration: InputDecoration(
                  labelText: "입력 하는 곳",
                  hintText: "입력하세요",
                ),
              ),
            ),
            // SizedBox는 자식 위젯의 크기를 강제로 설정하는 데 사용
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  createInfo();
                },
                child: Text('정보 추가'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  POST 요청을 통해 서버에 데이터를 전송하고,
  //  응답 상태 코드에 따라 성공 여부를 판단
  void createInfo() async {
    try {
      //  요청
      var dio = Dio();
      dio.options.headers['Content-Type'] = "application/json";
      //  POST 요청
      final response = await dio.post("");
      //  응답
      if (response.statusCode == 201) {
        //  CREATED
        //  context : 성공적으로 생성되면 현재 화면을 닫고 목록 페이지로 돌아감
        //  "/" : 필요에 따라서 목록 페이지로 이동
        Navigator.pushNamed(context, "/");
      } else {
        throw Exception("정보 추가 실패하였습니다.: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("정보를 추가하지 못했습니다.:$e");
    }
  }
}
