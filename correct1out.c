#include "mslib.h"


/* program */ 

int add(double n1 , double n2) {
  double sum; 
sum = n1 + n2;
  return sum;
}


int minus(double n1 , double n2) {
  double m; 
m = n1 - n2;
  return m;
}

int wadd(double n1 , double n2) {
  double sum,i; 
i = 0; 
while (i < n2) {
sum = sum + n1 + n2; 
i = i + 1;}
  return sum;
}

int fminus(double n1 , double n2) {
  double m,i; 
for(
i = 0;i < n2;
i = i + 1)
  {
if (i == 10) {
  continue;}  
m = i;}
  return m;
}

void empty() {
  
  writeString("Empty Function");
}

void empty2() {
  
  writeString("Empty Function");
}

double special2(double k) {
  
  return 100;
}

double* special(double * x) {
  
x[0] = 2 * x[4];
  return x;
}

double special3(double * x) {
  int i; double z;
 
for(
i = 0;i < 10;
i = i + 1)
  {
z = z + x[i];}
  return z;
}


int main() {	
double a=5,b=10,sum,min,wsum,fm,sp,new; double * fsp;
 double s[10];
 int i;
 
for(
i = 0;i < 10;
i = i + 1)
  {
s[i] = i;} 
  writeString("\nSTART\n"); 
  writeString("Add Table:"); 
new = special3(s); 
  writeNumber(new); 
  writeString("\nNumber a:"); 
  writeNumber(a); 
  writeString("\nNumber b:"); 
  writeNumber(b); 
  writeString("\nF1:Empty\nMessage:"); 
  empty(); 
  writeString("\nF2:Add\nMessage:"); 
sum = add(a,b); 
  writeNumber(sum); 
  writeString("\nF3:Minus\nMessage:"); 
min = minus(a,b); 
  writeNumber(min); 
  writeString("\nF4:WAdd\nMessage:"); 
wsum = wadd(a,b); 
  writeNumber(wsum); 
  writeString("\nF5:FMin\nMessage:"); 
fm = fminus(a,b); 
  writeNumber(fm); 
  writeString("\nF6:Constant\nMessage:"); 
sp = special2(10); 
  writeNumber(sp); 
  writeString("\nF7:FSp\nMessage:"); 
fsp = special(s); 
  writeNumber(fsp[0]); 
  writeString("\nEnd ex1");
} 
/*correct!*/
