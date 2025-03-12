/**
 * phone_app_flutter
 * FileName : PhoneAppVo
 * Class: PhoneAppVo.
 * Created by 202-12.
 * Created On 2025-03-12.
 * Description: 필드 및 생성자, json 통신을 위한 작업
 */

class PhoneAppVo {
  // 필드

  int id;
  String name;
  String phoneNumber;
  String email;
  String nickname;
  String memo;

  // 잠시 추가
  String title;
  bool completed;

  // 생성자
  PhoneAppVo({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.nickname,
    required this.memo,

    //  잠시 추가
    required this.completed,
    required this.title,
  });

  // fromJson 메서드는 JSON 데이터를 PhoneAppVo 객체로 변환하는 팩토리 메서드
  factory PhoneAppVo.fromJson(Map<String, dynamic> apiData) {
    return PhoneAppVo(
      id: apiData['id'],
      name: apiData['name'],
      phoneNumber: apiData['phoneNumber'],
      email: apiData['email'],
      nickname: apiData['nickname'],
      memo: apiData['memo'],

      //  잠시 추가
      title: apiData['title'],
      completed: apiData['completed'],
    );
  }

  // toJson 메서드는 PhoneAppVo 객체를 JSON 형식의 맵으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'nickname': nickname,
      'memo': memo,

      //  잠시 추가
      'title': title, 'completed': completed,
    };
  }
}
