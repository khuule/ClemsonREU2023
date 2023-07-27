load("functions.sage")
import ast;
import string;

#Level to check up to
NN=10;
#M' value to check up to
MM=93;
ZZs = [[[[] for i in range(2)]for j in range(MM+1)]for k in range(NN)]
print(ZZs);
for N in range(1,NN+1):
    print("N: ", N)
    file = open('roots/N'+str(N)+'rfzs.txt', 'r');
    lines = [line.rstrip() for line in file];
    for line in lines:
        #Convert to complex numbers
        R = [CC(i) for i in line.replace('\n','').split(',')]
        precise = true;
        #Remove level
        del R[0];
        #Obtain sign
        sign = int(real(R[1]));
        del R[1];
        #Obtain weight
        index = int(abs(R.pop(0)));
        print(index);
        #Check if the roots lie on the circle 1/sqrt(N)
        precise = True;
        for z in R:
            if (abs(abs(z)-1/sqrt(N*1.0))>10^(-8)):
                precise = False;
                print(index, "Not precise");
        if (precise == False):
            break;
        roots = upper_half(R);
        if (sign == 1):
            ZZs[N-1][index-1][0].append(roots);
        if (sign == -1):
            ZZs[N-1][index-1][1].append(roots);
print(ZZs);
#Check every N in range
for N in range (0,NN):
    #Check every M up to MM
    for M in range(0, MM):
        for Mp in range (M,len(ZZs)):
            #Check each sign for k
            for s in range(0, 1):
                #If same weight, we only need to check the sign once
                if (M==Mp and s == 0):
                    continue;
                for x in range(0, len(ZZs[N][M][s])):
                    #Check each sign for k'
                    for sp in range (0,1):
                        #If same weight, we only need to check the sign once
                        if (M==Mp and ( s==1 and sp == 1)):
                            continue;
                        for y in range(0, len(ZZs[N][Mp][sp])):
                            stieltjes = True;
                            z = mergeArrays(ZZs[N][M][s][x], ZZs[N][Mp][sp][y], M+1, Mp+1);
                            for l in range(0, len(z)-1):
                                #Stieltjes in general
                                if (z[l]==z[l+1] and z[l]==M+1):
                                    stieltjes = False;
                                #Strong Stieltjes same sign
                                if (s==sp and (z[0]==M or z[len(z)-1]==M)):
                                    stieltjes = False;
                                #Strong Stieltjes diff sign
                                elif (s==1 and sp==0 and (z[0]==M or z[len(z)-1]==M)):
                                    stieltjes = False;
                            if (stieltjes == False):
                                    print(N,M+1,Mp+1, len(z), "FALSE");
                            #print(M+1,Mp+1,stieltjes)
