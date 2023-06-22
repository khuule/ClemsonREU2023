###############################################################

# To find O(2^-m * N^-0.5) 

# |S1|+|S2|+|S3| <= 16/5 *2^-m *(exp(4pi*N^-0.5) -1)
#   + 33/4/ (m-1)! * (2pi*N^-0.5)^(m-1)


# Date : 6/14/2023

###############################################################

R = RealField(80); R
pi = numerical_approx(pi, digits=30);

NN = 50;
M = 50;

bigo = 1;
mNs = [];
for N in range(1, NN) :
    for m in range(1, M) : 
        sN = sqrt(N*1.0);
        t = 16/5*2^(-m) *(exp(4*pi/sN) - 1);
        t = t + 33/4/factorial(m-1) *(2*pi/sN)^(m-1);
        t = t* (2^m) * sN;
        if t>bigo :
#             print("New bigo:", N,m,t)
             bigo = t;
             mNs.append([m, N])
        print(N,m, t);

#print(mNs);


#####################################################
#---------The shift of zeros.  
ZZs = [];   #------------Zeros

md = 0;
mNls = [];
a=-2*pi;
b=2*pi; 

x=var('x')
for N in range(1, NN) :
#    continue;
    sN = sqrt(1.0*N);
    for m in range(1, M+1) : 
        Dq = 16/5*2^(-m) *(exp(4*pi/sN) - 1);
        Dq = Dq + 33/4/factorial(m-1) *(2*pi/sN)^(m-1);
#        print("N, m, shift of Q :", N, m, Dq);
        if (Dq>1): 
            print(N,m,Dq,">1");
            continue;

        for ell in range(0, m) :
            f = m*x -2*pi*sin(x)/sN -pi/2 -ell*pi;
            z = find_root(f, 0, pi);
            z1=0; z2=0;
            f1 = f*exp(2*pi*x/sN) + Dq;
            z1 = find_root(f1, a, b);
            f2 = f*exp(2*pi*x/sN) - Dq;
            z2 = find_root(f2, a, b);

            t = max(abs(z-z1), abs(z-z2)) *(2^m)/sN;
   #         print(N,m,ell,t,"O(2^m*sqrt(N))");
            if t > md : 
                md = t;
                print("new bound:", t);
                mNls.append([N,m,ell]);

print(mNls);  
