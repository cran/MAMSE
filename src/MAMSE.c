
int ccomp(double *x, double *y, int *nx, int *ny, int *b)
{
/* 
  x and y must be sorted; 
  nx and ny are the length of the datasets (vectors) x and y)
  
  Output: b[i] = Fx(y[i]), the empirical CDF of X evaluated at y[i]
  
*/
  
  int i,j;
  
  i=0; j=0;
  
  while(j<ny[0]){
    while(x[i]<=y[j] && i<nx[0]-1){
      i=i+1;
    }
    b[j]=i;
    if (i==*nx-1 && x[i]<=y[j]) {b[j]=nx[0];}
    j=j+1;
  }

  return 0;
}


int cwcomp(double *x, double *y, double *w, int *nx, int *ny, double *b)
{
/* 
  x and y must be sorted; w refers to the weight for each x (same order) 
  and those weights are assumed to add to 1;
  nx and ny are the length of the datasets (vectors) x and y)
  
  Output: b[i] = Fw(y[i]), the weighted empirical CDF of X evaluated at y[i]
  
*/
  
  int i,j;
  double Fw;
  
  i=0; j=0; Fw=0.;
  
  while(j<ny[0]){
    while(x[i]<=y[j] && i<nx[0]-1){
      Fw=Fw+w[i];
      i=i+1;
    }
    b[j]=Fw;
    if (i==*nx-1 && x[i]<=y[j]) {b[j]=1.;}
    j=j+1;
  }

  return 0;
}
int ccompmulti(double *x, double *y, int *nx, int *ny, int *p, int *b)
{
/* 
  x and y are matrices (nx*p and ny*p resp.) with one data point per line.
  x and y need to have an extra value to avoid memory faults.
  
  Output: b[i] = Fx(y[i]), the empirical CDF of X evaluated at y[i]
  
*/
  
  int i,j,k;
  
  j=0;
  
  while(j<ny[0]){
    i=0;
    b[j]=0;
    while(i<nx[0]){ 
      k=0;
      while(k<p[0]){
        if(x[i+k*nx[0]]<=y[j+k*ny[0]]){
	  k++;
	} else {
	  k=p[0]+1;
	}
      }
      if(k==p[0]){b[j]=b[j]+1;}
      i++;
    }
    j++;
  }

  return 0;
}
