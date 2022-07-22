import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for json

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController sepalLengthController = TextEditingController();
  TextEditingController sepalWidthController = TextEditingController();
  TextEditingController petalLengthController = TextEditingController();
  TextEditingController petalWidthController = TextEditingController();

  late String sepalLength;
  late String sepalWidth;
  late String petalLength;
  late String petalWidth;
  String result = "all";

  late String imageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Iris 품종 예측'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: sepalLengthController,
                      decoration: const InputDecoration(
                          labelText: 'Sepal Length의 크기를 입력하세요'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: sepalWidthController,
                      decoration: const InputDecoration(
                          labelText: 'Sepal Width의 크기를 입력하세요'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: petalLengthController,
                      decoration: const InputDecoration(
                          labelText: 'Petal Length의 크기를 입력하세요'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: petalWidthController,
                      decoration: const InputDecoration(
                          labelText: 'Petal Width의 크기를 입력하세요'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sepalLength = sepalLengthController.text.toString();
                      sepalWidth = sepalWidthController.text.toString();
                      petalLength = petalLengthController.text.toString();
                      petalWidth = petalWidthController.text.toString();
                      getJSONData();
                    },
                    child: const Text('입력'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/$result.jpg'),
                      radius: 100.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getJSONData() async {
    var url = Uri.parse(
        'http://localhost:5000/iris?sepalLength=$sepalLength&sepalWidth=$sepalWidth&petalLength=$petalLength&petalWidth=$petalWidth');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];
      // print(result);
    });
    _showDialog(context, result);
  }
// }

  void _showDialog(BuildContext context, String result) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("품종 예측 결과"),
            content: Text("입력하신 품종은 $result 입니다."),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  // // 화면 정리
                  // sepalLengthController.text = "";
                  // sepalWidthController.text = "";
                  // petalLengthController.text = "";
                  // petalWidthController.text = "";
                  setState(() {
                    imageName = result;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
} // -----
