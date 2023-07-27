###############################################################
# To find O(2^-m * N^-0.5) 

# |S1|+|S2|+|S3| <= 16/5 *2^-m *(exp(4pi*N^-0.5) -1)
#   + 17/4/ (m-1)! * (2pi*N^-0.5)^(m-1)
#   + (m+1)/2/m! * (2pi*N^-0.5)^(m-1) * (zeta(1.5)zeta(2.5)/zeta(5))^2
###############################################################
R = RealField(80); R
pi = numerical_approx(pi, digits=30);
z3h = zeta(1.5);

NN = 1;
MM = 38;

bigo = 1;
mNs = [];
for N in range(NN, NN+1) :
    sN = sqrt(N*1.0);
    pisN = pi/sN;
    lm = ceil(2*pisN);
    for m in range(MM,MM+1) : 
        t = 16/5*2^(-m) *(exp(4*pisN) - 1);
        t = t + 17/4/factorial(m-1) *(2*pi/sN)^(m-1);
        t = t + (m+1)/2/factorial(m) *(2*pi/sN)^(m-1) * z3h^2;
        t = t * (2^m) * sN;
        t = t *exp(2*pisN)*pi/2/(m-2*pisN);
        if t>bigo :
#             print("New bigo:", N,m,t)
             bigo = t;
             mNs.append([m, N])
        print(N,m, t);
