#include "mslib.h"


/* program */ 

double limit,num,counter;

int prime(int n) {
  int i; int result,isPrime;
 
if (n < 0) {
result = prime(-n);}  
else  {
if (n < 2) {
result = 0;}  
else  {
if (n == 2) {
result = 1;}  
else  {
if (n % 2 == 0) {
result = 0;}  
else {
i = 3; 
isPrime = 1; 
while (isPrime && (i < n / 2)) {
isPrime = n % i != 0; 
i = i + 2;} ;
 
result = isPrime;} } } }  ;

  return result;
}


void message() {
  const char* message="Hello world!\n"; 
  writeString(message);
}


int main() {	

  writeString("\nSTART\n"); 
  writeString("Insert a number:"); 
limit = readNumber(); 
counter = 0; 
num = 2; 
while (num <= limit) {
if (prime(num)) {
counter = counter + 1; 
  writeString("Prime is "); 
  writeNumber(num); 
  writeString("\n");}  ;
 
num = num + 1;} ;
 
  writeString("\n"); 
  writeString("Prime Counter:"); 
  writeNumber(counter); 
  message();
} 
/*correct!*/
