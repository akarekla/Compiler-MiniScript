#include "mslib.h"


/* program */ 

const double N=100; double a,b,c;


double cube(double i) {
  
  return i * i * i;
}


double add(double n , double k) {
  double j; 
j = (N - n) + cube(k);
  return j;
}


int main() {	

a = readNumber(); 
b = readNumber(); 
  writeString("Number A:"); 
  writeNumber(a); 
  writeString("\nNumber B:"); 
  writeNumber(b); 
c = add(a,b); 
  writeString("\nTotal:"); 
  writeNumber(c);
} 
/*correct!*/
