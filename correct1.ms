// File: ex1.ms

function add(n1: number,n2: number): boolean {
var sum: number;
sum= n1 + n2;
return sum;
}

function minus(n1: number,n2: number): boolean {
var m: number;
m= n1 - n2;
return m;
}

function wadd(n1: number,n2: number): boolean {
var sum,i: number;
i=0;
while(i<n2){
sum= sum + n1 + n2;
i=i+1;
}

return sum;
}

function fminus(n1: number,n2: number): boolean {
var m,i: number;
for(i=0;i<n2;i=i+1){
if (i==10)
	continue;
m= i;
}

return m;
}

function empty(): boolean {
writeString("Empty Function");

}

function empty2(): number {
writeString("Empty Function");
return ;
}

function special2(k: number) : number { return 100; }

function special(x[]: number) : [] number { x[0] = 2 * x[4]; return x;}
function special3(x[]: number) : number {var i: boolean;
var z: number;
 for(i=0;i<10;i=i+1){
z=z+ x[i];}return z;}

function start(): void {
var a=5,b=10,sum,min,wsum,fm,sp,new: number;
var fsp[]:number;
var s[10]:number;
var i: boolean;

for(i=0;i<10;i=i+1){
s[i]= i;
}
writeString("\nSTART\n");
writeString("Add Table:");
new=special3(s[]);
writeNumber(new);


writeString("\nNumber a:");
writeNumber(a);
writeString("\nNumber b:");
writeNumber(b);
writeString("\nF1:Empty\nMessage:");
empty();
writeString("\nF2:Add\nMessage:");
sum=add(a,b);
writeNumber(sum);
writeString("\nF3:Minus\nMessage:");
min=minus(a,b);
writeNumber(min);
writeString("\nF4:WAdd\nMessage:");
wsum=wadd(a,b);
writeNumber(wsum);
writeString("\nF5:FMin\nMessage:");
fm=fminus(a,b);
writeNumber(fm);
writeString("\nF6:Constant\nMessage:");
sp=special2(10);
writeNumber(sp);
writeString("\nF7:FSp\nMessage:");
fsp=special(s[]);
writeNumber(fsp[0]);
writeString("\nEnd ex1");
}
