import 'package:flutter/material.dart';
import 'package:multiple/utility/multiple_numbers.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  TextEditingController firstNumber = TextEditingController();
  TextEditingController secondNumber = TextEditingController();
  int result = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: firstNumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Number',
              ),
              validator: (value){
                if(value!.isEmpty){
                  return '0';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: secondNumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Number',
              ),
              validator: (value){
                if(value!.isEmpty){
                  return '0';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Text(
                    "Result: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                ),
                Text(
                  "$result",
                  style: TextStyle(
                    fontSize: 20,
                    color: result==0?Colors.red:Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                        padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        int x=0;
                        int y=0;
                        if(firstNumber.text != '' && secondNumber.text != ''){
                          x = int.parse(firstNumber.text);
                          y = int.parse(secondNumber.text);
                        }
                        else{
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Invalid Input'),
                              content: const Text('Please enter both the values'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                        setState((){
                          result = Karatsuba.multiple(x, y);
                        });
                      },
                      child: const Text('Calculate'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                        padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState((){
                          firstNumber.text='';
                          secondNumber.text='';
                          result = 0;
                        });
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
