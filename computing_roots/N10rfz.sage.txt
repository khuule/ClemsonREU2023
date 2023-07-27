###############################################################
#-------------------------Load("rfz.sage")
# Let f=sum_{n=1}^\infty a_nq^n  be an eigen cusp form.
#
# L(f,s) = prod_{p prime} 1 / ( 1 - a_p*p^(-s) + p^{k-1-2s} )
#
# Compute the zeros of r_f(z) 

#  r_f(z) = -(k-2)! / (2pi i)^(k-1) *

#  sum_{n=0}^{k-2} (2pi iz)^n / n! * L(f,k-n-1) 

#
#---------------------------------------------
# 
#
# Date : 7/26/2023

###############################################################
import json;
import csv;
from sage.misc.lazy_format import LazyFormat;
from sage.modular.dirichlet import DirichletCharacter;

R = RealField(50); R
pi = numerical_approx(pi, digits=30);
x = var('x');
M = 30;
N = 10; 

rfzs = [];  # zeros of r_f(z) on the unit circle for level N=1
rfzas = [];  # angle of zeros of r_f(z) on the unit circle for level N=1

zd=[];
for k in IntegerRange(2, M, 2) :
    nk =  dimension_new_cusp_forms(Gamma0(N),k);
    print('level N is', N, 'weight k is', k, 'and the dimension is', nk);
    if nk < 1 : continue;

    #---------characteristic polynomial
    H = DirichletGroup(N, base_ring=CyclotomicField(2));
    chi = DirichletCharacter(H, H._module([0]))
    Nf = Newforms(chi, k, names="a")
    tNum = 0;
    LenNewforms = len(Nf);
    for j in range(0, LenNewforms) :
        nfj = Nf[j];
        numj = Nf[j][1].charpoly().degree(); 
        for s in range(0, numj) :
            tNum = tNum + 1;
            #continue;
            lse = nfj.lseries(s);
            #------compute epsilon_f
            ef = 1;
            if lse(k-1)/lse(1) < 0 : ef = -1;  
    
            #------compute zeros of r_f(z)
            rf = 0;
            for n in range(0, k-1) :
                rf = rf + (2*pi*I*x)^n * lse(k-n-1) / factorial(n);
            rf = rf * (-1) * factorial(k-2) / (2*pi*I)^(k-1);
            #print("period polynomial:", rf);
            rz = rf.roots(ring=CDF);
            zz = [N, k/2-1, ef];
            zza = [N, k/2-1, ef];
            zu = 0;
            zl = 0;
            for t in rz:
                print(abs(t[0]));
                theta = arg(I*t[0]);
                if theta >=0 : 
                    zu = zu+1;
                    zza.append(theta);
                else : 
                    zl = zl+1;
                    zza.append(2*pi+theta);
                zz.append(t[0]);
            rfzs.append(zz);
            rfzas.append(zza);
            if (zu != zl) : print("Not equally distributed!", k, zu, zl);
            zd.append([k,zu,zl])
            with open('N10rfzs.txt', 'a') as fd:
                c = csv.writer(fd)
                c.writerows([zz]);
            with open('N10rfzs_unit_circle.txt', 'a') as fd:
                c = csv.writer(fd)
                c.writerows([zza])
    if(nk == tNum) :
        print(nk, tNum)
    else :
        print(nk, tNum, "are not equal!")


