import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? selectedImage; // Picture의 file name
  String result = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('얼굴 인식'),
      ),
      body: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedImage == null 
            ? const Text('이미지를 선택하세요') 
            : Image.file(selectedImage!),
            ElevatedButton(
              onPressed: () => onUploadImage(), 
              child: const Text('얼굴 인식')
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(
          Icons.add_a_photo
        ),
      ),
    );
  }

  // -------- Functions
  Future getImage() async{
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(image!.path);
    });
  }



  onUploadImage() async{
    var a = 1;
    var request = http.MultipartRequest(
      'POST', Uri.parse("http://localhost:5000/uploader"));
    // Multipart Request
    Map<String, String> headers = {"Content-type" : "multipart/form-data"};
    selectedImage != null
    ? 
    request.files.add(
      
      http.MultipartFile(
        'image',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split('/').last,
      )
    )
    : a = 2;

    request.headers.addAll(headers);
    var resp = await request.send();
    http.Response response = await http.Response.fromStream(resp);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];
    });

    _showDialog(context, result);


  }

  _showDialog(BuildContext context,String result){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Face Recognition'),
          content : Text('상기 얼굴의 이름은 $result 입니다.'),
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text('OK')
            )
          ],

        );
      } 
    );
  }



} // End