import 'dart:math';

class Karatsuba{
  static int multiple(int x,int y){
    if(x<10||y<10){
      return x*y;
    }
    int n = max("$x".length,"$y".length);
    int half = n~/2;
    int a = x~/(pow(10,half));
    int b = (x%(pow(10,half))).toInt();
    int c = y~/(pow(10,half));
    int d = (y%(pow(10,half))).toInt();
    int ac = multiple(a, c);
    int bd = multiple(b, d);
    int adPlusBc = multiple(a+b, c+d)-ac-bd;
    return (ac*(pow(10,(2*half)))+(adPlusBc*(pow(10, half)))+bd).toInt();
  }
}