import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pomodoro_app/timer_Screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController addTaskController = TextEditingController();
  List<String> taskName = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: taskName.isNotEmpty
          ? ListView.builder(
              itemCount: taskName.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          taskName[index],
                          style: const TextStyle(fontSize: 15),
                          maxLines: 1,
                        )),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TimerScreen(
                                        AppTitle: taskName[index].toString(),)));
                            });
                          },
                          child: const Text(
                            'Start',
                            style: TextStyle(fontFamily: 'Gilroy'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : const Center(
              child: Text(
              "Click + to add task",
              style: TextStyle(fontSize: 15, color: Colors.black),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
              elevation: 50,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
              backgroundColor: Colors.grey[100],
              context: context,
              builder: (builder) {
                return Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.3),
                              child: const Text(
                                "Add Task",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          onTap: () {},
                          onChanged: (e) {
                            setState(() {
                              if (addTaskController.text.length > 0) {
                                e = addTaskController.text.toString();
                              } else {
                                addTaskController.text.length == 0;
                              }
                            });
                          },
                          maxLines: 2,
                          controller: addTaskController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                            hintText: "Title of The Task",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                        ),
                        onPressed: () {
                          setState(() {
                            if (addTaskController.text.length == 0) {
                              addTaskController.clear();
                            } else {
                              taskName.add(addTaskController.text);
                              addTaskController.clear();
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontFamily: 'Gilroy'),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },

        // _incrementCounter,

        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
