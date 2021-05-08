import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import 'model/person.dart';

class ProfileChangePageSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileChangePageSampleState();
}

class ProfileChangePageSampleState extends State<ProfileChangePageSample> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  Person person;

  @override
  void initState() {
    super.initState();

    // boxをオープンする
    final box = Hive.box('settingBox');

    // boxからPerson型の情報を取得する
    person = box.get('person');

    // 取得できなかったらnullが返るので、インスタンス生成して格納する
    if (person == null) {
      person = Person('名無しさん', 20);
    }

    // TextFieldの初期文字が表示されるように設定する
    nameTextEditingController.text = person.name;
    ageTextEditingController.text = person.age.toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール変更ページ'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row( // 名前部分
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('名前：', style: TextStyle(fontSize: 24),),
                  Container(
                    width: 100,
                    child: TextField(
                      controller: nameTextEditingController,
                    ),
                  ),
                ],
              ),
              Row( // 年齢部分
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('年齢：', style: TextStyle(fontSize: 24),),
                  Container(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: ageTextEditingController,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // TextFieldの名前と年齢から、新たなPerson型を生成する
                  final updatedPerson = Person(
                    nameTextEditingController.text,
                    int.parse(ageTextEditingController.text),
                  );

                  // boxに保存する
                  final box = Hive.box('settingBox');
                  box.put('person', updatedPerson);
                },
                child: Text('確定'),
              ),
            ],
          )
      ),
    );
  }
}