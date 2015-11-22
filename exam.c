#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>



int * tri (int T,int taille){
  int T[taille],C[taille],R[taille];
  int i;
  int j;
  int compteur;
  int tmp;
  for (i=0;i<N;i++){
    tmp=T[i];
    for(j=0;j<N;j++){
      if T[i]<T[j]{
      compteur=compteur+1;
      }
    }
    C[i]=compteur;
  }
  int idr;
  for (i=0;i<N;i++){
    idr=C[i];
    R[i]=R[idr];
  }
  return R;
}

int main(int argc, char **argv)
{
  int taille=10000;
  int T[taille],C[taille],R[taille];
  int i;
  int j;
  int compteur;
  int tmp;
  MPI_Init(&argc,&argv);
  int nombre_aleatoire=0;
  int rank,nbproc ;
  MPI_Status s;
  MPI_Comm_rank(MPI_COMM_WORLD,&rank);
  MPI_Comm_size(MPI_COMM_WORLD,&size);
  if (rank==0){
    for (i =0;i<9999;i++){
      T[i]=rand()%9999;
    }
  }
  
  MPI_Scatter(&T,taille/nbproc,MPI_INT,&Recv,taille/nbproc,MPI_INT,0,MPI_COMM_WORLD);
 
 
  if (rank !=0){
    for (i=0;i<(taille/nbproc);i++){
      tmp=T[i];
      for(j=0;j<taille;j++){
	if T[i]<T[j]{
	    compteur=compteur+1;
	  }
      }
      C[i]=compteur;
    }
  }
  //.........

  MPI_Gather(

  MPI_Finalize();
  return(0);
}
