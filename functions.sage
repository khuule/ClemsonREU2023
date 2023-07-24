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
        arr_arg.append(arg(x*-i));
    #print(arr_arg);
    arr_upper = [];

    for x in arr_arg:
        if (x>0):
            arr_upper.append(x);
    arr_upper.sort();
    return arr_upper;

#This function orders the roots of arr1 and arr2,
#then outputs an array that states which root came from which weight
def mergeArrays(arr1, arr2, m1, m2):
    arr3=[x for _, x in sorted(zip(arr1+arr2, [m1 for i in range(len(arr1))]+[m2 for j in range(len(arr2))]))]
    return arr3;
