#include <stdio.h>

int checknumber(int x, int y, int z, int a, int b)
{
	int c = 0;
	int d = 0;
	int e = 0;
	int f = 0;

	int f1 = 0;
	int f2 = 0;
	int f3 = 0;

	c = a + b;

	if (c < 1000 && c != 0)
	{
		d = c / 100;
		e = (c - (d * 100)) / 10;
		f = c - ((d * 100) + (e * 10));

		if (d == x)
		{
			f1 = 1;
			x = 10;
		}
		else if (d == y)
		{
			f1 = 2;
			y = 10;
		}
		else if (d == z)
		{
			f1 = 3;
			z = 10;
		}
		else
		{
			f1 = 0;
		}

		if (e == x && f1 != 1)
		{
			f2 = 1;
			x = 10;
		}
		else if (e == y && f1 != 2)
		{
			f2 = 2;
			y = 10;
		}
		else if (e == z && f1 != 3)
		{
			f2 = 3;
			z = 10;
		}
		else
		{
			f2 = 0;
		}

		if (f == x && f1 !=1 && f2 != 1)
		{
			f3 = 1;
		}
		else if (f == y && f1 != 2 && f2 != 2)
		{
			f3 = 2;
		}
		else if (f == z && f1 !=3 && f2 != 3)
		{
			f3 = 3;
		}

		if (f1 != 0 && f2 != 0 && f3 != 0)
		{
			printf("%03d %03d %03d\n", a, b, c);
		}

		return c;
	}
	else {
		return -1;
	}
}

int main()
{
	int x = 0;
	int y = 0;
	int z = 0;

	int a = 0;
	int b = 0;
	int c = 0;

	for (x = 0; x<10; x++)
	{
		for (y = 0; y<10; y++)
		{
			for (z = 0; z<10; z++)
			{
				a = (x * 100) + (y * 10) + z;

				b = (x * 100) + (y * 10) + z;
				c = checknumber(x, y, z, a, b);

				b = (x * 100) + (z * 10) + y;
				c = checknumber(x, y, z, a, b);

				b = (y * 100) + (x * 10) + z;
				c = checknumber(x, y, z, a, b);

				b = (y * 100) + (z * 10) + x;
				c = checknumber(x, y, z, a, b);

				b = (z * 100) + (x * 10) + y;
				c = checknumber(x, y, z, a, b);

				b = (z * 100) + (y * 10) + x;
				c = checknumber(x, y, z, a, b);
			}
		}
	}
	return(0);
}
