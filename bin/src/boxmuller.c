/* Box Muller Adapted from GSL Libraries  - A.W. Seaver*/

/* GNU General Public License http://www.gnu.org/licenses/gpl.html 
 * randist/gauss.c
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2006, 2007 James Theiler, Brian Gough
 * Copyright (C) 2006 Charles Karney
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */


/* Box Muller Adapted from GSL Libraries  - A.W. Seaver*/


/* Polar (Box-Muller) method; See Knuth v2, 3rd ed, p122 */

#include <math.h>
#include "ranx.h"

double gsl_box_muller()
{
  double x, y, r2;

  do
    {
      /* choose x,y in uniform square (-1,-1) to (+1,+1) */
      x = -1.0 + 2.0 * ranx();
      y = -1.0 + 2.0 * ranx();

      /* see if it is in the unit circle */
      r2 = x * x + y * y;
    }
  while (r2 > 1.0 || r2 == 0);

  /* Box-Muller transform */
  return (y * sqrt (-2.0 * log (r2) / r2));
}
