import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;


class ScreenLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Statelogin();
  }
}
class Statelogin extends State<ScreenLogin> {

  var url = Uri.https('www.googleapis.com', '/books/v1/volumes');
  Future<void> requestApi() async {
    var reponse = await http.get('www.googleapis.com/books/v1/volumes');
    // check xem no da request dc chua
    if(reponse.statusCode == 200) {
      // var jsonReponse = convert.jsonDecode(reponse.body);
      // var itemCount = jsonReponse['totalItems'];
      print('Number of books about http:}.');
      return convert.json.decode(reponse.body);

    } else {
      print('Request failed with status: ${reponse.statusCode}.');
    }
  }

 // String _conectionStadtus = 'uknow';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitiresuld;
  @override
  void initState() {
    initConnectivity();
    _connectivitiresuld = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }
  @override
  void dispose() {
    _connectivitiresuld.cancel();
    super.dispose();
  }
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);

    }
    return _updateConnectionStatus(result);
    // Platform messages may fail, so we use a try/catch PlatformException.
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() {
          return Container(
            color: Colors.yellow,
          );
        });
        break;
      default:
        setState(() {
          return Text('dhghdgd');
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 27, 37, 1),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              margin: EdgeInsets.only(top: 95, bottom: 15),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset('assets/group.png'),
              )
            ),
            Container(
              height: 35,
              child: Image.asset('assets/nameapp.png'),
            ),
            Container(
              //color: Colors.yellow,
              height: 200,
              width: 330,
              margin: EdgeInsets.only(top: 70, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Input Your TikTok Username',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(177, 178, 181, 1),
                        fontStyle: FontStyle.normal

                      ),
                    ),
                  ),
                  Container(
                    height: 58,
                    margin: EdgeInsets.only(top: 20, bottom: 34),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: TextField(
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '     Username',
                      ),
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.emailAddress,
                    ),


                  ),
                  Container(
                    height: 58,
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(75, 79, 103, 1),

                    ),
                    child: TextButton(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          showAlearDiolog2(context);
                        });
                      },
                    ),
                  )
                ],
              ),

            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 50,
              width: 200,
              color: Colors.yellow,
              child: ElevatedButton(
                onPressed: requestApi,
                child: Text('Button'),
              ),
            )
          ],
        ),
      ),
    );
  }

  showAlearDiolog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Image.asset('assets/icons-250.png'),
                  ),
                  Container(
                    child: Text(
                      'Error',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          content: Text(
            'The username is incorrect.'
                'Please confirm your username  again.',
            style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(80, 81, 86, 1)
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                child: Text(
                    'Ok',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // Container(
            //   child: Text('OKOK'),
            // ),
            // Container(
            //   child: Text('OKOK'),
            // )
          ],
        );
      }
    );
  }
  showAlearDiolog2(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Image.asset('assets/group72.png'),
                    ),
                    Container(
                      child: Text(
                        'No Internet',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            content: Text(
              'Please try again!',
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(80, 81, 86, 1)
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        }
    );
  }
}