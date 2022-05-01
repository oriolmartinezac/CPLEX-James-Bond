// PLEASE ONLY CHANGE THIS FILE WHERE INDICATED.

// Length of codes.
int m = ...;

// Number of codes.
int n = ...;

// Codes.
// Input should satisfy the following precondition:
// the 0-th code is n zeroes: 000..000
int S[0..n-1][0..m-1] = ...;

// Range of code indices, including code 000...000.
range N0 = 0..n-1;

// Range of code indices, excluding code 000...000.
range N1 = 1..n-1;

//New range of code indices
range N2 = 1..n-2;

range N = 0..n-1;
range M = 0..m-1;

//Matrix with the # differences between codes (FLIP)
int F[N, N0];

// DECISION VARIABLES
dvar boolean x[N0][N0]; //variable with the code j in i position
dvar boolean y[N0][N0]; // variable with 

execute {
  	for (var i=0;i<n;i++)
		for (var j=0; j<m;j++)
  			for (var k=0; k<n; k++)
  				if (i != k)
  					if (S[i][j] != S[k][j])
  						F[i][k] += 1;
}

// find the sequence that minimizes the differences between contiguous codes and that minimizes overall flips
minimize sum(i, j in N0) y[i][j] * F[i][j]; // Minimize the number of flips (minimize the number of differences between code i and code i+1 which is choosen from S)

subject to {
   	forall (i in N0) x[i][i] == 0;
  			
	forall(i in N0) //CHECK if the start it's 0 or 1
		sum (j in N0) x[i][j] == 1; //Unique codes for each position (i)

	forall (j in N0) //CHECK if the start it's 0 or 1
		sum (i in N0) x[i][j] == 1; // NO ES NECESARIA SI TENEMOS EN CUENTA QUE LA PRIMERA Y LA ULTIMA SON 0  
		  
	forall (i in N1, j in N1)
	  	forall(k in N2) x[k][i] + x[k+1][j] - y[i][j] <= 1; 
	
	x[0][0] == 1;
	
	/*
    forall (i, j in N : j != 1) 
    	y[i][j] + x[i][j] <= y[j][i] + (n - 1) * (1 - x[i][j]);
	*/
	
	forall(index in N0){
	  y[0][index] == x[1][index]; // CHECKING FIRST ROW == 0
	  y[index][0] == x[n-1][index]; // CHECKING LAST ROW == 0
 	}
 		  
}

//print result
execute POSTPROCESS {
  for (var i in N0)
        for (var j in N0)
            if (x[i][j] != 0) write(i, " -> ", j, "\n");
}