set_verbose(-2)
gp.default("realprecision",20)
from sage.modular.dirichlet import DirichletCharacter
from sage.modular.dims import dimension_new_cusp_forms
H = DirichletGroup(2, base_ring=CyclotomicField(1))
chi = DirichletCharacter(H, H._module([]))
pi = numerical_approx(pi, digits=30);
tp = 2*pi*i;

def upper_half(arr):
    arr_arg = [];
    for x in arr:
        #rotate
        arr_arg.append(arg(x*-I));
    #print(arr_arg);
    arr_upper = [];

    for x in arr_arg:
        if (x>10^(-12) and x<pi-10^(-12)):
            arr_upper.append(x);
    arr_upper.sort();
    return arr_upper;

#This function orders the roots of arr1 and arr2,
#then outputs an array that states which root came from which weight
def mergeArrays(arr1, arr2, m1, m2):
    arr3=[x for _, x in sorted(zip(arr1+arr2, [m1 for i in range(len(arr1))]+[m2 for j in range(len(arr2))]))]
    return arr3;

def load_roots(N1,N2,MMM):
    ZZs = [[[[] for i in range(2)]for j in range(MM+1)]for k in range(N2)]
    for N in range(N1,N2+1):
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
            if (index>40):
                break;
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
    return ZZs;

def load_roots_GP(N1,N2,MMM):
    ZZs = [[[[] for i in range(2)]for j in range(MM+1)]for k in range(N2)]
    for N in range(N1,N2+1):
        print("N: ", N)
        file = open('Pari_GP/N'+str(N)+'rfzs.txt', 'r');
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
    return ZZs;

def load_roots_GP_after_rot(N1,N2,MMM):
    ZZs = [[[[] for i in range(2)]for j in range(MM+1)]for k in range(N2)]
    for N in range(N1,N2+1):
        print("N: ", N)
        file = open('Pari_GP/N'+str(N)+'rfzs.txt', 'r');
        lines = [line.rstrip() for line in file];
        for line in lines:
            #Convert to complex numbers
            R = [RR(i) for i in line.replace('\n','').split(',')]
            precise = true;
            #Remove level
            del R[0];
            #Obtain sign
            sign = int(real(R[1]));
            del R[1];
            #Obtain weight
            index = int(abs(R.pop(0)));
            roots=[];
            for x in R:
                #Remove 0 and pi
                if ((abs(x)>=10^(-8) and (abs(x-pi)>=10^(-8))) and (x<pi)):
                    roots.append(x);
            roots.sort();
            if (sign == 1):
                ZZs[N-1][index-1][0].append(roots);
            if (sign == -1):
                ZZs[N-1][index-1][1].append(roots);
    return ZZs;
