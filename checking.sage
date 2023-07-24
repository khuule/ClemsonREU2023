load("functions.sage")
import ast;
import string;

file1 = open('rfzs_new.txt', 'r');
Lines = file1.read().split('\n');
ZZs = [[0 for i in range(0)] for j in range(93)]
print(ZZs);
count = 0;
for line in Lines:
    count +=1;
    if (count >675):
        break;
    #Remove level
    line=line[2:];
    #Convert to complex numbers
    R = [CC(i) for i in line.replace('\n','').split(',')]
    #Remove sign
    del R[1];
    #Obtain weight
    index = int(abs(R.pop(0)));
    roots = upper_half(R);
    ZZs[index-1].append(roots);
    print(count, index);

#Check every 1<=M<=37
for M in range(0, 38):
    for Mp in range (M+1,len(ZZs)-1):
        for x in range(0, len(ZZs[M])):
            for y in range(0, len(ZZs[Mp])):
                stieltjes = True;
                z = mergeArrays(ZZs[M][x], ZZs[Mp][y], M+1, Mp+1);
                for l in range(0, len(z)-1):
                    if (z[l]==z[l+1] and z[l]==M+1):
                        stieltjes = False;
                        print(z);
                    if ((M % 2) == (Mp % 2) and (z[0]==M or z[len(z)-1]==M)):
                        stieltjes = False;
                        print(M+1,Mp+1, len(z));
                    elif ((M % 2==1) and (Mp % 2==0) and (z[0]==M or z[len(z)-1]==M)):
                        stieltjes = False;
                        print(M+1,Mp+1, len(z));
