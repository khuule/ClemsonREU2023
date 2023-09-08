load("functions.sage")
import ast;
import string;

#Level to check up to
NN=10;
#M' value to check up to
MMM=50;
MM=50;


#5-d Array containing all roots in the format [N-1][M-1][eps(f)][ith newform][jth root]
ZZs = load_roots_GP_after_rot(NN,NN,MM);

#Check every N in range
for N in range (1,NN+1):
    #Check every M up to MM
    for M in range(0, MMM+1):
        #First, check different weights
        for Mp in range (M+1,len(ZZs[N-1])):
            #Check each sign for k
            for s in range(0, 2):
                #If same weight, we only need to check the sign once
                if (M==Mp and s == 0):
                    continue;
                for x in range(0, len(ZZs[N-1][M][s])):
                    #print("M:", M, "Nf:", x);
                    #Check each sign for k'
                    for sp in range (0,2):
                        #If same weight, we only need to check the sign once
                        if (M==Mp and ( s==1 and sp == 1)):
                            continue;
                        for y in range(0, len(ZZs[N-1][Mp][sp])):
                            stieltjes = True;
                            #Merge arrays, ordered by angle
                            z = mergeArrays(ZZs[N-1][M][s][x], ZZs[N-1][Mp][sp][y], M+1, Mp+1);
                            for l in range(0, len(z)-1):
                                #Stieltjes in general
                                if (z[l]==z[l+1] and z[l]==M+1):
                                    stieltjes = False;
                                #Strong Stieltjes same sign (includes interlacing same sign)
                                if (s==sp and (z[0]==M or z[len(z)-1]==M)):
                                    stieltjes = False;
                                #Strong Stieltjes diff sign, different weight
                                elif (s==1 and sp==0 and (z[0]==M or z[len(z)-1]==M)):
                                    stieltjes = False;
                            if (stieltjes == False):
                                print("N:", N, "m:",M+1,"m':", Mp+1, "FALSE");
                            #print(M+1,Mp+1,stieltjes)
            #Then, check same weight, different signs
            for x in range(0, len(ZZs[N-1][M][0])):
                for y in range(0, len(ZZs[N-1][M][1])):
                    stieltjes = True;
                    #Check first interlacing property
                    for l in range(0, M):
                        if (ZZs[N-1][M][1][y][l]<ZZs[N-1][M][0][x][l]):
                            stieltjes = False;
                            print("samesign", "N:", N, "m:", M+1, "x:", x, "y:", y, "l:", l);
                    #Check second interlacing property
                    for l in range(0, M):
                        if (ZZs[N-1][M][0][x][l+1]<ZZs[N-1][M][1][y][l]):
                            stieltjes = False;
                    #Output if false
                    #if (stieltjes == False):
