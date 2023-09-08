\\###############################################################
\\#-------------------------\r rfz.gp
\\ Let f=sum_{n=1}^\infty a_nq^n  be an eigen cusp form.
\\
\\ L(f,s) = prod_{p prime} 1 / ( 1 - a_p*p^(-s) + p^{k-1-2s} )
\\
\\ Compute the zeros of r_f(z) 
\\
\\  r_f(z) = -(k-2)! / (2pi i)^(k-1) *
\\
\\  sum_{n=0}^{k-2} (2pi iz)^n / n! * L(f,k-n-1) 
\\
\\
\\---------------------------------------------
\\ 
\\
\\ Date : 6/30/2023
\\
\\##############################################################

M = 106;
N = 2;

rfzs = List(); \\ zeros of r_f(z) on the unit circle for level N=1
\\ angle of zeros of r_f(z) on the unit circle for level N=1

{for (k = 3, M, k ++; 
    chi = Mod(1,N);
    nk = mfdim([N,k,chi],0);
    printf("level N is %d, weight k is %d, the dimension is %d\n", N, k, nk);

    if( nk > 0,
        \\---------L-functions of new forms
        mf = mfinit([N,k,chi],0);
        lf = mfeigenbasis(mf);
        nb = length(lf);
        for(fi = 1, nb,
            f = lf[fi];
            L = lfunmf(mf, f);
            nd = poldegree(f.mod);
            for(j = 1, nd, 
                \\------compute zeros of r_f(z)
                Lj = L[j];
                if(nd == 1, Lj = L);
                rz = List([N,k/2-1]);
                ef = lfun(Lj, 1) / lfun(Lj, k-1);
                if(ef > 0, listput(rz, 1), listput(rz, -1));
                print(rz);
                rf = 0;
                for (n = 0, k-1,
                    rf = rf + (2*Pi*I*x)^n * lfun(Lj, k-n-1) / factorial(n)
                );
                rf = rf * (-1) * factorial(k-2) / (2*Pi*I)^(k-1);
                pr = polroots(rf);
                for(nz = 1, length(pr),
                    print(abs(pr[nz]) - 1/sqrt(N))
                );
                write("N2rfz.txt", rz[1], ",", rz[2], ",", rz[3], ",", pr);
\\                listput(rz, polroots(rf));
\\                listput(rfzs, rz)
            )
        )
    )
)}
