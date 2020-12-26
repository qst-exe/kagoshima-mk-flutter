import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    final _title = args['title'] as String;
    final _questionId = args['questionId'] as String;

    final _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(Constants.questionCollection)
              .doc(_questionId)
              .collection(Constants.choiceCollection)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              );
            }

            if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
              return const Center(
                child: Text('現在選択肢はありません'),
              );
            }

            final _choiceList = snapshot.data.docs.map((doc) {
              final data = doc.data();
              data['choiceId'] = doc.id;
              return data;
            }).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          '【質問】$_title',
                          style: const TextStyle(fontSize: 18),
                        )),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final _choice = _choiceList[index];
                        final choiceId = _choice['choiceId'] as String;
                        final votes = _choice['votes'] as int;

                        return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38)),
                                child: InkWell(
                                  onTap: () {
                                    final _updateData = {'votes': votes + 1};
                                    FirebaseFirestore.instance
                                        .collection('questions')
                                        .doc(_questionId)
                                        .collection('choices')
                                        .doc(choiceId)
                                        .update(_updateData);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: _screenWidth - 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _choice['title'] as String,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            _choice['votes'].toString(),
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )));
                      },
                      itemCount: _choiceList.length,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
