//takes in Exon a, Exon b

Table compTable = new Table();
Table filledTable = new Table();

void initializeTable(){
  Exon exon1 = s_Exon.get(0);
  Exon exon2 = g_Exon.get(0);

  println("\nFirst exon to be compared is: ");
  printExon(exon1);
  println("\nSecond exon to be compared is: ");
  printExon(exon2);

  compTable.addColumn("Empty");
  compTable.addColumn("Empty");
  TableRow newRow0 = compTable.addRow();
  newRow0.setString(0, "Empty");
  newRow0.setString(1, "0");
  
  for(int i = 0; i < exon1.lengthOf ; i++){ 

    String addingChar = exon1.singles.get(i);
    compTable.addColumn(addingChar);;    newRow0.setString(i, "0");
  }
  
  for(int i = 1; i < exon2.lengthOf; i++){
 
     String addingChar = exon2.singles.get(i);   
     TableRow newRow = compTable.addRow();
     newRow.setString(0, addingChar);   
     newRow.setString(1, "0");
  }
  
  saveTable(compTable, "compChart.csv");
}


void matrixFill(){
  filledTable = loadTable("compChart.csv");
  Exon exon1 = s_Exon.get(0);
  Exon exon2 = g_Exon.get(0);
  int toAdd;
  
  //penalties
  int gap = 0;
  int match = 1;
  int mismatch = 0;
  
  for(int i = 2; i < exon1.lengthOf; i++){
      filledTable.setString(i,0, str(parseInt(filledTable.getString(i-1, 0)) + gap));
  }
  for(int j = 2; j < exon2.lengthOf; j++){
    filledTable.setString(0,j, str(parseInt(filledTable.getString(0, j-1)) + gap));     
  }
        //println("Exon1 letter is: " + e1letter);
        //println("Exon2 letter is: " + e2letter);
        
        /*
        int diagonal = parseInt(filledTable.getString(i-1, j-1)) + compare(i,j);
        int top =  parseInt(filledTable.getString(i, j-1));
        int left = parseInt(filledTable.getString(i-1, j));      

        int newMax = max(diagonal, top, left); 
        println("Diagonal is: " + diagonal);
        println("Top is: " + top);
        println("Left is: " + diagonal);
        println("New max is: " + newMax);
       
        filledTable.setString(i , j, str(newMax));
      */
    
        
    saveTable(filledTable, "filledChart.csv");
}


int compare(int a, int b){
  Exon exon1 = s_Exon.get(0);
  Exon exon2 = g_Exon.get(0);
  if(exon1.singles.get(a-2) == exon2.singles.get(b-2)){
    println("Found equals, returning 1");
    return 1;
  }
  else{
    return 0;
  }
}

        /*
        int diagonal = M[i-1][j-1] + Match(i,j);
        int top = M[i][j-1];
        int left = M[i-1][j];
        M[i][j] = max(diag,left,top);
        if (M[i][j] == diag){D[i][j] = 1;}
        if (M[i][j] == left){D[i][j] = 2;}
        if (M[i][j] == top){D[i][j] = 3;}
        if (M[i][j] == 0){D[i][j] = 0;}
        */


