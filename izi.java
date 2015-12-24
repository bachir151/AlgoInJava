package aleat.tpK;

//import aleat.tpD.MultiPlot;
import aleat.tpH.IdentityPointed;
import aleat.tpH.PlotableColored;
import aleat.tpH.PlotablePoint;
import aleat.tpH.Grillage;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Created by bachir on 15/12/15.
 */
public class Particule  {

   private ArrayList<Double> pi = new ArrayList<Double>();
   private int dim;
   public int [][] content ;
   private int beta=1;
   Random rand = new Random();

   public Particule(int dim ) {
      this.dim=dim;
      this.content= new int [dim][dim];
      for (int i = 0; i < dim; i++)
         for (int j = 0; j < dim; j++)
            this.content[i][j] = 2 * rand.nextInt(2) - 1;
   }
   public int Hamiltonien (int a ,int b){
      int Hamiltonien [] [] = new int [dim][dim];
      //int sum=0;
      for (int i = 0; i < dim; i++) {
         for (int j = 0; j < dim; j++) {
            int voisin1 = content[(i - 1+dim) % dim][j];
            int voisin2 = content[i][(j - 1+dim) % dim];
            int voisin3 = content[(i + 1+dim) % dim][j];
            int voisin4 = content[i][(j + 1+dim) % dim];
            Hamiltonien[i][j] = content[i][j] * (voisin1 + voisin2 + voisin3 + voisin4);
            //sum=sum+Hamiltonien[i][j];
         }
      }
     // System.out.println(sum);
     // return sum;
      return Hamiltonien[a][b];
   }
public void simulation (double beta){

   for (int i = 0; i <this.dim; i++) {
      for(int j=0;j<this.dim;j++) {
      int  ia=rand.nextInt(dim);
      int  ib=rand.nextInt(dim);
         double pi = (double) Math.exp(-beta * Hamiltonien(ia, ib));
         //if (i==1 && i==2){System.out.println(pi);}
         double choix = rand.nextDouble();
         if (choix < Math.min(pi,1)) {
            content[ia][ib] = -content[ia][ib];
         }

      }

   }
}


   public   ArrayList  afficheligne(int m [][] ,int l,int dim){
      ArrayList<Double> ligne  = new ArrayList<Double>();
         for (int j=0;j<dim;j++){
            ligne.add((double)m[l][j]);
         }
      return ligne ;
   }



   public static void main(String[] args) {
    int dim =4;
      Particule P =new Particule(dim);

     // Particule P =new Particule(dim);

     for (int i =0;i<dim;i++) {
        System.out.println(P.afficheligne(P.content, i, dim));
     }
      System.out.println("*********************");
      for (int k=0;k<1;k++){
         System.out.print((double)Math.exp(-0.05*P.Hamiltonien(2, 1)));
      //P.simulation(1.5);
      }
     /* for (int i =0;i<dim;i++) {
         System.out.println(P.afficheligne(P.content, i, dim));
      }*/


   }
}
