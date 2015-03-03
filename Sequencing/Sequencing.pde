//Assignment 4: Sequencing
//Ceren Savasan
//csavasan@wpi.edu

//-----------------------------EXON AND CELL CLASS DECLERATIONS AND FUNCTIONS-------------------------------//
//cell of a matrix
class Cell{
  int score;
  int row;
  int column;
  
  Cell pointsTo;
  
  Cell(int i, int j){
    pointsTo = null;
    score = 0;
    row = i;
    column = j;
  } 
  
  int get_row(){
    return row;
  }
  
  int get_column(){
    return column;
  }
  
  void setPointer(Cell newCell){
    pointsTo = newCell;
  }
  
  Cell getPointer(){
    return pointsTo;
  }
  
  void setScore(int s){
    score = s;
  }
  
  int getScore(){
    return score;
  }
}

class Exon{
  ArrayList<String> singles = new ArrayList<String>();
  int lengthOf;
  
  Exon(ArrayList<String> input){
    singles = input;
    lengthOf = singles.size();
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

void printExon(Exon thisE){
  for(int i = 0; i < thisE.lengthOf; i++){
    print(thisE.singles.get(i));
  }
}

//--------------------------------------TABLE PARSER-------------------------------------//
Table resultsTable = new Table();  //to save sequence.csv to
Table resultsTable2 = new Table(); //to save given.csv to

Table loader = new Table();  //to load sequence.fasta to
Table loader2 = new Table();  //to load given.fasta to

String test1;
String test2;
String stringRow;

//total list of exons, each exon a string on the list
ArrayList<String> sequence = new ArrayList<String>();
ArrayList<String> given = new ArrayList<String>();

void tableParser(){
  loader = loadTable("sequence.fasta", "csv");
  boolean firstRow = false;

  for(TableRow row : loader.rows()){
    if(firstRow == true){
      resultsTable.addRow(row); //strings and numerics get added as they are
      stringRow = row.getString(0);
      test1 = stringRow;
      test2 = stringRow;
      sequence.add(stringRow);
    }
    if(firstRow == false){
      firstRow = true;
    }
  }
  
  loader2 = loadTable("given.fasta", "csv");
  firstRow = false;
  
  for(TableRow row : loader2.rows()){
    if(firstRow == true){
      resultsTable2.addRow(row); //strings and numerics get added as they are
      stringRow = row.getString(0);
      test1 = stringRow;
      given.add(stringRow);
    }
    if(firstRow == false){
      firstRow = true;
    }
  }
  
saveTable(resultsTable, "sequenceGenTable.csv");
saveTable(resultsTable2, "givenGenTable.csv");
}

//---------------------------PARSE THE EXONS FROM TABLES---------------------------//
//Save each char to this list of strings
ArrayList<String> newStr = new ArrayList<String>();
ArrayList<String> newStr2 = new ArrayList<String>();

//Contains exons to be compared
ArrayList<Exon> s_Exon = new ArrayList<Exon>();
ArrayList<Exon> g_Exon = new ArrayList<Exon>();

ArrayList<Exon> exonParserSeq(){
  loader = loadTable("sequenceGenTable.csv", "csv");
  for(TableRow row : loader.rows()){
      stringRow = row.getString(0);
      String thisChar;
      for(int i = 0; i < stringRow.length(); i++){
        thisChar = String.valueOf(stringRow.charAt(i));     ///PROBLEM CHILD
        newStr.add(thisChar); 
      }
      s_Exon.add(new Exon(newStr));
  }
  return s_Exon;
}
  
ArrayList<Exon> exonParserGiv(){ 
  loader = loadTable("givenGenTable.csv", "csv");
  for(TableRow row : loader.rows()){
      stringRow = row.getString(0);
      String thisChar2;
      for(int i = 0; i < stringRow.length(); i++){
        thisChar2 = String.valueOf(stringRow.charAt(i));
        newStr2.add(thisChar2); 
      }
      g_Exon.add(new Exon(newStr2));
  }
  return g_Exon;
}  

//-----------------------------CUT STRING LENGTH TO 40-------------------------------//
String reduceTo40(String s){
  if (s.length() > 40){
    s = s.substring(0, 40);
  }
  return s;
}


//-----------------------------DRAW A FINAL ALIGNMENT-------------------------------//
void drawAlign(String[] finalAlign, int thisy){ 
  fill(0);
  for(int i = 0; i < finalAlign[0].length(); i++){
    char c = finalAlign[0].charAt(i);
    textSize(10);
    int xcor = 15 + 8*i;
    text(c, xcor , thisy);
  }
  
  for(int i = 0; i < finalAlign[1].length(); i++){
    char c = finalAlign[1].charAt(i);
    textSize(10);
    int xcor = 15 + 8*i;
    text(c, xcor , thisy + 20);
  } 
}

//-----------------------------DRAW EVERYTHING-------------------------------//
PFont myFont = createFont("Arial", 8);

void setup(){
  size(1200, 250);
  background(255);
  fill(34,139,34);
  
  tableParser(); 
  ArrayList<Exon> someExons = exonParserSeq();
  ArrayList<Exon> someExons2 = exonParserGiv();
  
  
  //FIRST SET OF EXONS TO COMPARE
  textSize(12);
  fill(34,139,34);
  text("Comparing exons from csv tables: ",15, 20);
  String test_a = exonToString(someExons.get(0));
  String test_b = exonToString(someExons2.get(0)); 
  String seqA = reduceTo40(test_a);
  String seqB = reduceTo40(test_b);
  println(seqA);
  println(seqB); 
  Cell[][] matrix = new Cell[seqA.length()+1][seqB.length()+1];
  initializeTable(matrix, seqA, seqB); //in Matrix.pde
  String[] finalAlign = traceback(matrix, seqA, seqB); 
  drawAlign(finalAlign, 40);
  
  
  
  //SECOND SET OF EXONS TO COMPARE
  textSize(12);
  fill(50,205,50);
  text("Comparing manually input sequences: ",15, 100);
  seqA = reduceTo40("TTATCCACAGATTTGTTCTTTACTAATAATAATAGTAATTATTATTTTTTATTTTTTTTATTTTTTTGAA");
  seqB = reduceTo40("AAGCAGAAGTTAAGGATTTAATTTGTAACCATTACTCTGTTGTTGGTGTGTTAACACAAAATGAAATTAA");
  println(seqA);
  println(seqB); 
  matrix = new Cell[seqA.length()+1][seqB.length()+1];
  initializeTable(matrix, seqA, seqB); //in Matrix.pde
  finalAlign = traceback(matrix, seqA, seqB); 
  drawAlign(finalAlign, 120);
  
  
  
  //A LONGER DATA SET
  textSize(12);
  fill(102,205,170);
  text("A longer sequence pair: ",15, 180);
  seqA = "GATCCTAATATACTTAATGGTATGATTGTAAAGGTGAATAATACTATTTTTGATTTATCTGCTCAAAATCTTATTTCTGTAAGTGATGGTATTATAAAAATCAATGGTCTTTCTAACGTAATGTTAGGTGAAATGATTTT";
  seqB = "TTATTTCTGTAAGTGATGGTATTATAAAAATCAATGGTCTTTCTAACGTAATGTTAGGTGAAATGATTTTAAGCAGAAGTTAAGGATTTAATTTGTAACCATTACTCTGTTGTTGGTGTGTTAACACAAAATGAAATTAA";
  println(seqA);
  println(seqB); 
  matrix = new Cell[seqA.length()+1][seqB.length()+1];
  initializeTable(matrix, seqA, seqB); //in Matrix.pde
  finalAlign = traceback(matrix, seqA, seqB); 
  drawAlign(finalAlign, 200);
  
}

