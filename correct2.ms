// File: useless.ms
// A piece of MiniScript code for demonstration purposes
const N = 100 : number;
var a, b, c: number;
function cube(i: number): number {
return i*i*i;
}
function add(n: number, k: number): number {
var j: number;
j = (N-n) + cube(k);
return j;
}
/* Here you can see some useless lines.
* Just for testing the multi-line comments ...
*/
function start(): void {
a = readNumber();
b = readNumber();
writeString("Number A:");
writeNumber(a);
writeString("\nNumber B:");
writeNumber(b);
c = add(a, b); // Here you can see some dummy comments!
writeString("\nTotal:");
writeNumber(c);
}
