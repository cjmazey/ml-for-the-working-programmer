#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>

/*
 * fun increase (k, n) =
 *    if (k + 1) * (k + 1) > n
 *       then k
 *    else k + 1
 */
void
increase (mpz_t k, const mpz_t n)
{
  mpz_t u;

  mpz_init_set (u, k);
  mpz_add_ui (u, u, 1);
  mpz_mul (u, u, u);
  if (mpz_cmp (u, n) <= 0)
    {
      mpz_add_ui (k, k, 1);
    }
  mpz_clear (u);
}

/*
 * fun introot n =
 * if n = 0
 *    then 0
 * else increase (2 * introot (n div 4), n)
 */
void
introot (mpz_t r, const mpz_t n)
{
  unsigned long int i = 0;
  unsigned long int size = mpz_sizeinbase (n, 4);
  mpz_t *stack = malloc (size * sizeof (mpz_t));

  mpz_set (r, n);
  for (i = 1; i <= size; i++)
    {
      mpz_init_set (*(stack + size - i), r);
      mpz_fdiv_q_ui (r, r, 4);
    }
  for (i = 0; i < size; i++)
    {
      mpz_mul_ui (r, r, 2);
      increase (r, *(stack + i));
      mpz_clear (*(stack + i));
    }
  free (stack);
}

int
main (void)
{
  mpz_t n, r;

  mpz_inits (n, r, NULL);
  while (gmp_scanf ("%Zd", n) > 0)
    {
      introot (r, n);
      gmp_printf ("%Zd : %Zd\n", n, r);
      fflush (stdout);
    }
  mpz_clears (n, r, NULL);

  return 0;
}
