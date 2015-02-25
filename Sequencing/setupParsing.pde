
//helper structures
Table resultsTable = new Table();
Table resultsTable2 = new Table();
Table loader = new Table();
Table loader2 = new Table();

//total list of exons, each exon a string on the list
ArrayList<String> sequence = new ArrayList<String>();
ArrayList<String> given = new ArrayList<String>();

//Exons to be compared
ArrayList<Exon> s_Ex = new ArrayList<Exon>();
ArrayList<Exon> g_Ex = new ArrayList<Exon>();


String stringRow;


class Exon{
  ArrayList<String> singles = new ArrayList<String>();
  int lengthOf;
  
  Exon(ArrayList<String> input){
    singles = input;
    lengthOf = singles.size();
  }
}


void tableParser(){
  loader = loadTable("sequence.fasta", "csv");
  boolean firstRow = false;

  for(TableRow row : loader.rows()){
    if(firstRow == true){
      resultsTable.addRow(row); //strings and numerics get added as they are
      stringRow = row.getString(0);
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

void exonParser(){
  loader = loadTable("sequenceGenTable.csv", "csv");
  for(TableRow row : loader.rows()){
      stringRow = row.getString(0);
      String thisChar;
      for(int i = 0; i < stringRow.length(); i++){
        thisChar = String.valueOf(stringRow.charAt(i));
        newStr.add(thisChar); 
      }
      s_Ex.add(new Exon(newStr));
  }
  
  loader = loadTable("givenGenTable.csv", "csv");
  for(TableRow row : loader.rows()){
      stringRow = row.getString(0);
      String thisChar;
      for(int i = 0; i < stringRow.length(); i++){
        thisChar = String.valueOf(stringRow.charAt(i));
        newStr.add(thisChar); 
      }
      g_Ex.add(new Exon(newStr));
  }
}  
