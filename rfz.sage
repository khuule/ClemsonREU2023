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
# Date : 6/21/2023

###############################################################
import json;
from sage.misc.lazy_format import LazyFormat;
from sage.modular.dirichlet import DirichletCharacter;

R = RealField(50); R
pi = numerical_approx(pi, digits=30);
x = var('x');
M = 100;

rfzs = [];  # zeros of r_f(z) on the unit circle for level N=1

zd=[];

for k in IntegerRange(12, M, 2) :
#    if k!=12 : continue;
    ns = k % 12;
    if (ns == 2) : ns = 14;
    nk = Integer((k-ns)/12);
    print('weight k is', k, 'and the dimension is', nk);
    if nk < 1 : continue;

    #---------characteristic polynomial
    H = DirichletGroup(1, base_ring=CyclotomicField(1));
    chi = DirichletCharacter(H, H._module([]))
    Nf = Newforms(chi, k, names="a")
    lse = Nf[0].lseries();

    #------compute zeros of r_f(z)
    rf = 0;
    for n in range(0, k-1) :
        rf = rf + (2*pi*I*x)^n * lse(k-n-1) / factorial(n);
    rf = rf * (-1) * factorial(k-2) / (2*pi*I)^(k-1);
    rz = rf.roots(ring=CDF);
#    print("roots:", rz);
    zz = [k];
    zu = 0;
    zl = 0;
    for t in rz:
        if arg(t[0]) >=0 : zu = zu+1;
        else : zl = zl+1;
        zz.append(arg(t[0]));
    rfzs.append(zz);
    zd.append([k,zu,zl])
print(zd)




import csv
with open('rfzs.txt', 'w') as fd:
    c = csv.writer(fd)
    c.writerows(rfzs);

#with open('fan.txt', 'w') as fd:
#    c = csv.writer(fd)
#    c.writerows(ansk)
#

NN = 50;
M = 50;

bigo = 1;
mNs = [];
for m in range(1, M) : 
    continue;
    for N in range(1, NN) :
        sN = sqrt(N*1.0);
        t = 16/5*2^(-m) *(exp(4*pi/sN) - 1);
        t = t + 33/4/factorial(m-1) *(2*pi/sN)^(m-1);
        t = t* (2^m) * sN;
        if t>bigo :
             bigo = t;
             mNs.append([m, N])
        print(t, bigo);

print(mNs);

########################################################
#----------Zeros of r_f(z).


#####################################################
#---------The shift of zeros.  
ZZs = [];   #------------Zeros

md = 0;
mNls = [];
a=-2*pi;
b=2*pi; 
x = var('x');

for N in range(1, NN) :
    continue
    sN = sqrt(1.0*N);
    for m in range(1, M+1) : 
        Dq = 16/5*2^(-m) *(exp(4*pi/sN) - 1);
        Dq = Dq + 33/4/factorial(m-1) *(2*pi/sN)^(m-1);
#        print("N, m, shift of Q :", N, m, Dq);
        if (Dq>1): continue;
        for ell in range(0, m) :
            f = m*x -2*pi*sin(x)/sN -pi/2 -ell*pi;
            z = find_root(f, 0, pi);
            z1=0; z2=0;
            f1 = f*exp(2*pi*x/sN) + Dq;
            z1 = find_root(f1, a, b);
            f2 = f*exp(2*pi*x/sN) - Dq;
            z2 = find_root(f2, a, b);

            t = max(abs(z-z1), abs(z-z2)) *(2^m)/sN;
            if t > md : 
                md = t;
                print("new bound:", t);
                mNls.append([N,m,ell]);

print(mNls);  
