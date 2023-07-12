R = RealField(80); R
pi = numerical_approx(pi, digits=30);
e=exp(1.0);
NN=ceil(196476^(4.602));

for N in range(NN, NN+1):
	sN=sqrt(1.0*N)

	t=4*log(4*e);
	t=t+36*(sN/pi)^(3/4)*gamma(0.75);
	t=t+56.0;
	t=t*2*(sN/(2*pi))^2;
	t = t / ( (sN/(2*pi))^3 * 2*(zeta(3.0))^2 / zeta(1.5)^2);
	t=t*(pi/2)*(N*1.0)^(1/8);
	print(t);
