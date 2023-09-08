# ClemsonREU2023
## "checking.sage"
Used to verify the finitely many cases left for $N=1$, Theorem 1.8. The code may be adapted to different levels $N$, but be wary that higher levels have lower precision.

## "checking_pari.sage"
Used to verify our results hold for $N=2,3,10$ for $m<m'\le 51$.

## "zgap.sage"
Used to obtain a big-O constant for the case $k\geq 6$.

## "4bigO.sage"
Used to derive a big-O constant for the case $k=4$.

## "compute_roots"
Contains code to compute roots of period polynomials for various levels of $N$.

## "functions.sage"
Contains functions used in "checking.sage".

## "distance.sage"
Computes $D$ as in Section 8 of the paper.

## "roots"
This directory contains some roots computed up to level $N=10$. Each line of a "N__rfzs.txt" file contains an array in the following format:
$$[N, m, \varepsilon(f), z_1,z_2,...z_{2m+2}],$$
where $z_i$ is a root of $r_f(z)$

## "Pari_GP"
This directory contains roots in the same format as above. However, they were computed using Pari/GP which has much higher precision for higher levesls $N$.
