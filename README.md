# ClemsonREU2023
## "checking.sage"
Used to verify the finitely many cases left for $N=1$, Theorem 1.8. The code may be adapted to different levels $N$, but be wary that higher levels have lower precision.

## "zgap.sage"
Used to obtain a big-o constant for the case $k\geq 6$.

## "4bigO.sage"
Used to derive a big-O constant for the case $k=4$.

## "compute_roots/N'x'rfz.sage"
Computes all roots for a level $N=x$.

## "functions.sage"
Contains functions used in "checking.sage".

## "distance.sage"
Computes $D$ as in Section 8 of the paper.

## "roots"
This directory contains some roots computed up to level $N=10$. Each line of a "N__rfzs.txt" file contains an array in the following format:
$$[N, m, \varepsilon(f), z_1,z_2,...z_{2m+2}],$$
where $z_i$ is a root of $r_f(z)$
