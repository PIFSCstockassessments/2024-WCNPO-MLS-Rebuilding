static long kseed;


void init_ranx(long iseed)
{
/* 
** Initialize Random Number Seed
** iseed must be less than 2^31 - 1 (2147483647)
*/  

	kseed = iseed;
}
double ranx()
{
/*
** Implementation of Linear Congruential Pseudorandom Generator
** based on Park & Miller (Comunications of the ACM Vol 31 Number 10 Oct. 1988)
** uses Shrage's Algorithm to avoid integer multiplication overflow in 32-bit word
** Same series as IMSL default method (Option 1)
**
** Return Uniform Random Number Between 0 & 1
*/

	const long a = 16807L;
	const long m = 2147483647L;
	const long q = 127773L;
	const long r = 2836L;
	long k, l, h, t;
	double x;


	k = kseed;

	h = k / q;

	l = k % q;


	t = a * l - r * h;

	if (t > 0)
		kseed = t;
	else
		kseed = m + t;



	x = (double) kseed / (double) m;

	return(x);

}
long get_seed_ranx()
{
/*
**  Returns Current value of Random Seed 
*/
	return(kseed);
}
