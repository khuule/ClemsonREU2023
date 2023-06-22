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

