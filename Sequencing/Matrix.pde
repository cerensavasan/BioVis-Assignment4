//-----------------------------CREATE MATRIX-------------------------------//
void initializeTable(Cell[][] matrix, String seqA, String seqB){
  int gap = -2;
  int match = 2;
  int mismatch = -1;

  //initialize all cells
  for(int i = 0; i < seqA.length() + 1; i++){
    for(int j = 0; j < seqB.length() + 1; j++){
      matrix[i][j] = new Cell(i,j);
      matrix[i][j].setScore(0);  //start with all scores 0
    }
  }
  
  for(int i = 1; i < seqA.length() + 1; i++){
    for(int j = 1; j < seqB.length() + 1; j++){
      Cell thisCell = matrix[i][j];
      Cell left = matrix[i][j-1];
      Cell diagonal = matrix[i-1][j-1];
      Cell top = matrix[i-1][j];
      
     
      //calculate scores with gaps into account
      int diagScore = diagonal.getScore();
      int row_gap = top.getScore() + gap;
      int column_gap = left.getScore() + gap;
      
      if(seqB.charAt(thisCell.get_row() - 1) == seqA.charAt(thisCell.get_column() - 1)){
        diagScore += match;
      }
      else {
        diagScore += mismatch;
      }
     
      if(row_gap >= column_gap) {
         if(diagScore >= row_gap) {
            thisCell.setScore(diagScore);
            thisCell.setPointer(diagonal);
         }
         else {
           thisCell.setScore(row_gap);
           thisCell.setPointer(top);
         }
      }
      else {
        if(diagScore >= column_gap) {
           thisCell.setScore(diagScore);
           thisCell.setPointer(diagonal);
        }
        else {
           thisCell.setScore(column_gap);
           thisCell.setPointer(left);
        }
      }
    }
  }
}

//-----------------------------TRACEBACK-------------------------------//
String[] traceback(Cell[][] matrix, String seqA, String seqB){
  Cell maxCell = matrix[seqB.length()][seqA.length()]; //bottom right cell is the result
  String alignment0 = "";
  String alignment1 = "";
  Cell current = maxCell;

  while (current.getPointer() != null) { //get alignments
    if (current.get_row() - current.getPointer().get_row() == 1) {
      alignment1 = seqB.charAt(current.get_row() - 1) + alignment1;
    }
    else {
      alignment1 = "-" + alignment1;
    }
    if (current.get_column() - current.getPointer().get_column() == 1) {
      alignment0 = seqA.charAt(current.get_column() - 1) + alignment0;
    }
    else {
      alignment0 = "-" + alignment0;
    }
    current = current.getPointer();
  }

  String[] finalAlignment = new String[] {alignment0.toString(), alignment1.toString()};
  return finalAlignment;
}
