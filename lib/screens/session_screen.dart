import 'package:flutter/material.dart';
import 'package:globo_fitness/helpers/session.dart';
import 'package:globo_fitness/helpers/sp_helper.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();
  final SPHelper helper = SPHelper();

  @override
  void initState() {
    helper.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your training sessions'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            showSessionDialog(context);
          },
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Insert Training Session'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: txtDescription,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                TextField(
                  controller: txtDuration,
                  decoration: const InputDecoration(hintText: 'Duration'),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                txtDescription.text = '';
                txtDuration.text = '';
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: saveSession,
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';
    Session newSession = Session(
        1, today, txtDescription.text, int.tryParse(txtDuration.text) ?? 0);

    helper.writeSession(newSession);
    txtDescription.text = '';
    txtDuration.text = '';

    Navigator.pop(context);
  }
}
