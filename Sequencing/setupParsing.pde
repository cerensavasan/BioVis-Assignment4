
//helper structures
Table resultsTable = new Table();
Table resultsTable2 = new Table();
Table loader = new Table();
Table loader2 = new Table();

//total list of exons, each exon a string on the list
ArrayList<String> sequence = new ArrayList<String>();
ArrayList<String> given = new ArrayList<String>();

//Exons to be compared
ArrayList<Exon> s_Exon = new ArrayList<Exon>();
ArrayList<Exon> g_Exon = new ArrayList<Exon>();

String test1;
String test2;

String stringRow;
String stringRow2;


class Exon{
  ArrayList<String> singles = new ArrayList<String>();
  int lengthOf;
  
  Exon(ArrayList<String> input){
    singles = input;
    lengthOf = singles.size();
  }
}

void printExon(Exon thisE){
  for(int i = 0; i < thisE.lengthOf; i++){
    print(thisE.singles.get(i));
  }
}



void tableParser(){
  loader = loadTable("sequence.fasta", "csv");
  boolean firstRow = false;

  for(TableRow row : loader.rows()){
    if(firstRow == true){
      resultsTable.addRow(row); //strings and numerics get added as they are
      stringRow = row.getString(0);
      test1 = stringRow;
      test2 = stringRow;
      println("string row is:" + stringRow);
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


ArrayList<String> newStr = new ArrayList<String>();
ArrayList<String> newStr2 = new ArrayList<String>();

void exonParser(){
  loader = loadTable("sequenceGenTable.csv", "csv");
  for(TableRow row : loader.rows()){
      stringRow = row.getString(0);
      String thisChar;
      for(int i = 0; i < stringRow.length(); i++){
        thisChar = String.valueOf(stringRow.charAt(i));
        newStr.add(thisChar); 
      }
      s_Exon.add(new Exon(newStr));
  }
  
  loader = loadTable("givenGenTable.csv", "csv");
  for(TableRow row : loader.rows()){
      stringRow2 = row.getString(0);
      String thisChar2;
      for(int i = 0; i < stringRow2.length(); i++){
        thisChar2 = String.valueOf(stringRow2.charAt(i));
        newStr2.add(thisChar2); 
      }
      g_Exon.add(new Exon(newStr2));
  }
}  
