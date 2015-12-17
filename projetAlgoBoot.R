
#N vecteur des tailles
#Y_M vecteur des moyennes
#S_2v vecteur des variances
#X vecteur dont la premi?re colonne poss?de gb "1" le reste par produit de kronecker
#I matrice identit? d'ordre gb



Sa<-function (N,Y_M,S_2v,g,b){
  gb<-g*b
  #S_2v
  #construction matrice diagonale S
  S_diag<-diag(gb)
  #S_diag
  #A<-t(Y_M)/S_2v
  A<-S_2v/N
  #A
  diag(S_diag)<-A
  #S_diag
  I<-diag(gb)
  #I
  
  #construction matrice S^(-1) et S^(-1/2)
  S_inv<-solve(S_diag)
  #S_inv
  S_puissance<-(S_diag)^(-1/2)
  #S_puissance
  #remplacer les inf par 0 dans la matrice S_puissance
  S_diag_puissance<-replace((S_puissance),is.infinite(S_puissance),0)
  #S_diag_puissance
  
  #Construction matrice X
  Indgb<-cbind(rep(1,g*b)) # vecteur colonne d'ordre 
  #Indgb
  Indg<-cbind(rep(1,g))
  #Indg
  Ib<-diag(b)
  #Ib
  Kr<-kronecker(Indg,Ib)
  #Kr
  X<-cbindX(Indgb,Kr)
  #X
  
  s_A_tild<-t(Y_M)%*%S_diag_puissance%*%(I-S_diag_puissance%*%X%*%(ginv(t(X)%*%S_inv%*%X))%*%t(X)%*%S_diag_puissance)%*%S_diag_puissance%*%Y_M
  s_A_tild
}
######################################################"
#Algorithm1

algorithm1<-function(N,Y_M,S_2v,g,b,m)
{
#########ENTREE##########
#N<-scan()#demande ? l'utilisateur d'entr?e le vecteur des tailles des echantillons
#Y_M<-scan() # vecteur des moyennes ? entrer
#S_2v<-scan()
sa<-Sa(N,Y_M,S_2v,g,b) #Calcul de Sa
Q<-cbind(rep(1,m)) # Construction de Q
for(k in 1:m){ #~~~~~~~~~
  for(i in 1:gb){###########
    Y_MB[i]<-rnorm(1,0,S_2v[i]/N[i]) #Y_Bij ~ norm(0,S_ij/Nij)
    chi<-rchisq(1,N[i]-1)
    S_MB[i]<-S_2v[i]*chi/(N[i]-1) # S_Bij ~chiDeux
  }################
  
Sab<-Sa(N,Y_M,S_MB,g,b) #Calcul S_AB

if (Sab>sa){Q[k]<-1} else {Q[k]<-0 }
} #~~~~~~~~~~~~~~~~
pvalue<-sum(Q)/m
return(pvalue)
}

g<-3
b<-2
gb<-g*b

N<-cbind(20  , 18   ,30 ,  24 ,  25  , 23)
#N
Y_M<-rbind(7.5,8.3,12.4,5.9,6.4,5.7)
#Y_M
S_2v<-cbind(1.01,1.25,1.15,1.09,1.10,0.99)
#S_2v
m<-1000
Pv<-cbind(rep(1,m))
for (j in 1:10){
Pv[j]<-algorithm1(N,Y_M,S_2v,g,b,m)
}
mean(Pv)
algorithm1(N,Y_M,S_2v,g,b,m)
#algorithm1(N,Y_M,S_2v,g,b,m)

####
#t(rbind(rep(1,gb)))





