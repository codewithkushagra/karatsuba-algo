import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
void main() {
  runApp(MaterialApp(
    home: home(),
  ));
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController controller1=TextEditingController();
  TextEditingController controller2=TextEditingController();
  String s1="",s2="",s='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MULTIPLICATOR"),
        centerTitle: true,
      ),
      body: Container(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              TextField(
                controller: controller1,
                decoration: InputDecoration(hintText: "enter num",labelText: "number 1"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: controller2,
              decoration: InputDecoration(hintText: "enter num",labelText: "number 2"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ),
            ElevatedButton(onPressed: (){
             s1=controller1.text.toString();
             s2=controller2.text.toString();
             print(s1);
             print(s2);
             s=multiply(s1, s2);
             print("de");
            }, child: Text("Calculate")),
            Text("$s",style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}

int max(int a,int b){
  return ((a) > (b) ? (a) : (b));
}
String add(String lhs, String rhs) {
  print("entered a");
  int length = max(lhs.length, rhs.length);
  int carry = 0;
  int sum_col;  // sum of two digits in the same column
  String result='',du;

  // pad the shorter String with zeros
  while (lhs.length < length)
    lhs='0'+lhs;

  while (rhs.length < length)
    rhs='0'+rhs;

  // build result String from right to left
  for (int i = length-1; i >= 0; i--) {
    sum_col = (int.parse(lhs[i])) + (int.parse(rhs[i])) + carry;
    carry = (sum_col/10) as int;
    du=(sum_col%10).toString();
    result=du+result;
    //result.insert(0,(sum_col % 10).toString());
  }

  if (carry==1) {
    du = carry.toString();
    result = du + result;
    // result.insert(0,to_String(carry));
  }

  result=int.parse(result).toString();
  print("entered exit a");
  return result;
  // remove leading zeros
  //return result.erase(0, min(result.find_first_not_of('0'), result.length-1));
}

String subtract(String lhs, String rhs) {
  print("entered s");
  int length = max(lhs.length, rhs.length);
  int diff;
  String result='';

  while (lhs.length < length)
    lhs='0'+lhs;

  while (rhs.length < length)
    rhs='0'+rhs;

  for (int i = length-1; i >= 0; i--) {
    diff = (int.parse(lhs[i])) - (int.parse(rhs[i]));
    if (diff >= 0)
      result=diff.toString()+result;
      //result.insert(0, to_String(diff));
    else {

      // borrow from the previous column
      int j = i - 1;
      while (j >= 0) {
        lhs=lhs.substring(0,j-1)+(((int.parse(lhs[i])) - 1) % 10).toString();
        if(j!=lhs.length-1)
          lhs+=lhs.substring(j+1);
       // lhs[j] = (((lhs.codeUnitAt(j)) - 1) % 10).toString() ;
        if (lhs[j] != '9')
          break;
        else
          j--;
      }
      result=(diff+10).toString()+result;
     // result.insert(0, to_String(diff+10));
    }

  }
  result=int.parse(result).toString();
  print("entered exit s");
  return result;
 // return result.erase(0, min(result.find_first_not_of('0'), result.length-1));
}

String multiply(String lhs, String rhs) {
  print("entered");
  int length1 = max(lhs.length, rhs.length);
  while (lhs.length < length1)
    lhs='0'+lhs;
  print(lhs.length);
  while (rhs.length < length1)
    rhs='0'+rhs;

  if (length1 == 1){
    int u=int.parse(lhs[0])*int.parse(lhs[0]);
    return u.toString();
  }
  String lhs0 = lhs.substring(0,length1/2 as int);
  String lhs1 = lhs.substring(length1/2 as int,(length1-length1/2) as int );
  String rhs0 = rhs.substring(0,length1/2 as int);
  String rhs1 = rhs.substring(length1/2 as int,(length1-length1/2) as int);
  print("entered2");
  String p0 = multiply(lhs0,rhs0);
  String p1 = multiply(lhs1,rhs1);
  String p2 = multiply(add(lhs0,lhs1),add(rhs0,rhs1));
  String p3 = subtract(p2,add(p0,p1));
  print("entered3");
  for (int i = 0; i < 2*(length1-length1/2); i++)
    p0=p0+'0';
  for (int i = 0; i < length1-length1/2; i++)
    p3+="0";
  print("entered4");
  String result = add(add(p0,p1),p3);
  result=int.parse(result).toString();
  print(result);
  return result;
  //return result.erase(0, min(result.find_first_not_of('0'), result.length-1));
}