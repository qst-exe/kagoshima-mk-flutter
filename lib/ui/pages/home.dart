import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('鹿児島.mk 投票アプリ'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(Constants.questionCollection)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
              return const Center(
                child: Text('現在質問はありません'),
              );
            }

            final _questionList = snapshot.data.docs.map((doc) {
              final data = doc.data();
              data['questionId'] = doc.id;
              return data;
            }).toList();

            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final _question = _questionList[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38)),
                        child: InkWell(
                          onTap: () {
                            final _args = <String, String>{
                              'questionId': _question['questionId'] as String,
                              'title': _question['title'] as String
                            };
                            Navigator.of(context).pushNamed(
                                Constants.pageDetail,
                                arguments: _args);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: _screenWidth - 100,
                              child: Text(
                                _question['title'] as String,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        )),
                  );
                },
                itemCount: _questionList.length,
              ),
            );
          }),
    );
  }
}
