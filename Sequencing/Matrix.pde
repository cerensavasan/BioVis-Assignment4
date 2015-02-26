//takes in Exon a, Exon b

Table compTable = new Table();
Table filledTable = new Table();

void initializeTable(){
  Exon exon1 = s_Exon.get(0);
  Exon exon2 = g_Exon.get(0);

  //println("\nFirst exon to be compared is: ");
 // printExon(exon1);
  //println("\nSecond exon to be compared is: ");
 // printExon(exon2);

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
  
  String test1 = exonToString(exon1);
  String test2 = exonToString(exon2);
  
  
  //penalties
  int gap = 0;
  int match = 1;
  int substitution = -1;

  String sequenceA =  test1;
  String sequenceB = test2;

  
  int[][] opt = new int[sequenceA.length() + 1][sequenceB.length() + 1];

  // First of all, compute insertions and deletions at 1st row/column
  for (int i = 1; i <= sequenceA.length(); i++)
    opt[i][0] = opt[i - 1][0] + gap;
  for (int j = 1; j <= sequenceB.length(); j++)
    opt[0][j] = opt[0][j - 1] + gap;

  for (int i = 1; i <= sequenceA.length(); i++) {
    for (int j = 1; j <= sequenceB.length(); j++) {
        int scoreDiag = opt[i - 1][j - 1] +
                (sequenceA.charAt(i-1) == sequenceB.charAt(j-1) ?
                    match : // same symbol
                    substitution); // different symbol
        int scoreLeft = opt[i][j - 1] + gap; // insertion
        int scoreUp = opt[i - 1][j] + gap; // deletion
        // we take the minimum
        opt[i][j] = min(scoreDiag, scoreLeft, scoreUp);
    }
  }
  println("Finalizing print statement");
  for (int i = 0; i <= sequenceA.length(); i++) {
    for (int j = 0; j <= sequenceB.length(); j++){
        filledTable.setInt(i,j, opt[i][j]);
        print(opt[i][j] + "\t");
    }
    println("");
  } 
  println("Getting out of matrix fill function");  
  saveTable(filledTable, "filledChart.csv");
}
  
  
  /*
  for(int i = 2; i <= exon1.lengthOf+1; i++){
      filledTable.setString(i,2, str(parseInt(filledTable.getString(i-1, 0)) + gap));
  }
  for(int j = 2; j <= exon2.lengthOf+1; j++){
    filledTable.setString(2,j, str(parseInt(filledTable.getString(0, j-1)) + gap));     
  }
  
  int addTo = 0;
  
  for(int i = 2; i <= exon1.lengthOf; i++){
    for (int j = 2; j <= exon2.lengthOf; j++){
      
        if(exon1.singles.get(i-2) == exon2.singles.get(j-2)){
          addTo = match;
        }
        else{
          addTo = mismatch;
        }
        
        int diagonal = parseInt(filledTable.getString(i-1, j-1)) + addTo;
        int top = parseInt(filledTable.getString(i, j-1)) + gap; // insertion
        int left = parseInt(filledTable.getString(i-1, j)) + gap; // deletion
        
        int newMax = max(diagonal, left, top);
        
        println("Diagonal is: " + diagonal);
        println("Top is: " + top);
        println("Left is: " + left);
        println("New max is: " + newMax);
        
        // we take the minimum
        filledTable.setString(i,j, str(newMax));
    }
  }

  saveTable(filledTable, "filledChart.csv");
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


String exonToString(Exon e){
  String toReturn = "";
  for(int i = 0; i < e.lengthOf; i++){
    toReturn = toReturn + e.singles.get(i);
  }
  println("Exon is now string: " + toReturn);
  return toReturn;
}
