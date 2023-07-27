set_verbose(-2)
gp.default("realprecision",20)
from sage.modular.dirichlet import DirichletCharacter
from sage.modular.dims import dimension_new_cusp_forms
H = DirichletGroup(1, base_ring=CyclotomicField(1))
chi = DirichletCharacter(H, H._module([]))
pi = numerical_approx(pi, digits=30);

MM=37;

min = pi;
min_distance = [];
for M in range(1,MM+1):
    var('z');
    N = Newforms(chi, 2*M+2, names="a");
    dim = dimension_new_cusp_forms(Gamma0(1), 2*M+2)

    #If there is no new form for this weight, we skip
    if(dim<1):
        continue;
    f = N[0];

    #Iterating over every cusp form
    for j in range(0, dim):
        print(j);
        tp = 2*pi*i;
        #L is the L function associated with each new form
        L=f.lseries(j)

        #"r" is the period polynomial and is defined as in (1.4) from []
        r=0
        for n in range(0, 2*M+1):
            r=r+(tp*z)^(n)* L(2*M+1-n)/ gamma(n+1);
        r=-r*gamma(2*M+1) / (2*pi*i)^(2*M-1);
        #print(r);

        arr=r.roots(ring=CC)
        arr_arg = [];
        #print(arr);
        for x in arr:
            #rotate
            arr_arg.append(arg(x[0]*-i));
        #print(arr_arg);
        arr_upper = [];

        for x in arr_arg:
            if (x>=10^(-14) and x <= 3.14-10^(-14)):
                arr_upper.append(x);
        arr_upper.append(pi);
        arr_upper.append(0);
        arr_upper.sort();
        print(arr_upper);
        #print(arr_upper);

        #print (arr_upper);
        for k in range(0,len(arr_upper)-1):
            if ((arr_upper[k+1]-arr_upper[k])<min):
                min=arr_upper[k+1]-arr_upper[k];
                print(str(2*M+2) + ": "+ str(min));
