import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_sample/model/person.dart';
import 'package:flutter_hive_sample/profile_change_page_smaple.dart';
import 'package:hive/hive.dart';

class ProfilePageSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilePageSampleState();
}

class ProfilePageSampleState extends State<ProfilePageSample> {
  Person person;

  @override
  void initState() {
    super.initState();
    _getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィールページ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('名前：${person.name}', style: TextStyle(fontSize: 24),),
            Text('年齢：${person.age}', style: TextStyle(fontSize: 24),),
            ElevatedButton(
                onPressed: () async {
                  // プロフィール変更ページへ遷移して、戻ってくるのを待つ
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return ProfileChangePageSample();
                  }));

                  // 戻ってきたら、改めてboxからプロフィール情報を取得する
                  _getProfileInfo();
                },
                child: Text('変更する'),
            ),
          ],
        )
      ),
    );
  }

  void _getProfileInfo() {
    // boxをオープンする
    final box = Hive.box('settingBox');

    // boxからPerson型の情報を取得する
    person = box.get('person');

    // 取得できなかったらnullが返るので、インスタンス生成して格納する
    if (person == null) {
      person = Person('名無しさん', 20);
    }

    setState(() {});
  }

}