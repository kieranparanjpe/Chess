
import processing.net.*;

color lightbrown = #FFFFC3;
color darkbrown  = #D8864E;
PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;
boolean firstClick;
int row1, col1, row2, col2;

Client myClient;

boolean myTurn = false;
boolean canUndo = true;


String out = "";

      char lastTaken = ' ';

char grid[][] = {
  {'R', 'B', 'N', 'Q', 'K', 'N', 'B', 'R'}, 
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'}, 
  {'r', 'b', 'n', 'q', 'k', 'n', 'b', 'r'}
};

void setup() {
  size(800, 800);

  firstClick = true;

  brook = loadImage("blackRook.png");
  bbishop = loadImage("blackBishop.png");
  bknight = loadImage("blackKnight.png");
  bqueen = loadImage("blackQueen.png");
  bking = loadImage("blackKing.png");
  bpawn = loadImage("blackPawn.png");

  wrook = loadImage("whiteRook.png");
  wbishop = loadImage("whiteBishop.png");
  wknight = loadImage("whiteKnight.png");
  wqueen = loadImage("whiteQueen.png");
  wking = loadImage("whiteKing.png");
  wpawn = loadImage("whitePawn.png");
  
  myClient = new Client(this, "127.0.0.1", 1234);
  
  textAlign(CENTER);
}

void draw() {
  drawBoard();
  drawPieces();
  
  int available = myClient.available();
  
  if(available > 0)
  {
    String in = myClient.readString();
    
    if(in.charAt(0) == 'e')
    {
           myTurn = false; 
             in = in.substring(1);

    }
    else
    {
       myTurn = true;
              canUndo = false;

    }
    
    Parse(in);

  }
  
  for(int i = 0; i < 8; i++)
  {
    if(grid[0][i] == 'p')
    {
            fill(0);
      rect(100, 350, 600, 100);
      myTurn = false;
      textSize(20);
      fill(0, 0, 255);
      text("please hold, opponent is promoting...", 
      400, 400);
    }
    if(grid[7][i] == 'P')
    {
            fill(0);
      rect(100, 350, 600, 100);
      textSize(20);
      fill(255, 255, 0);
      text("q for queen, r for rook, k for knight and b for bishop", 
      400, 400);
      if(q)
      {
        grid[7][i] = 'Q';
        
        out = "7," + i + ",Q" + ":" + "7," + i + ",Q";
        canUndo = false;
        myClient.write(out);
      }
      if(r)
      {
        grid[7][i] = 'R';
        
        out = "7," + i + ",R" + ":" + "7," + i + ",R";
        canUndo = false;
        myClient.write(out);
      }
      if(k)
      {
        grid[7][i] = 'N';
        
        out = "7," + i + ",N" + ":" + "7," + i + ",N";
        canUndo = false;
        myClient.write(out);
      }
      if(b)
      {
        grid[7][i] = 'B';
        
        out = "7," + i + ",B" + ":" + "7," + i + ",B";
        canUndo = false;
        myClient.write(out);
      }
    }
  }
  
  fill(100);
  
  //if(myTurn)
    //rect(400, 400, 20, 20);

}

void drawBoard() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) { 
      if ( (r%2) == (c%2) ) { 
        fill(lightbrown);
      } else { 
        fill(darkbrown);
      }
      rect(c*100, r*100, 100, 100);
    }
  }
}

void drawPieces() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if (grid[r][c] == 'r') image (wrook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'R') image (brook, c*100, r*100, 100, 100);
      if (grid[r][c] == 'b') image (wbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'B') image (bbishop, c*100, r*100, 100, 100);
      if (grid[r][c] == 'n') image (wknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'N') image (bknight, c*100, r*100, 100, 100);
      if (grid[r][c] == 'q') image (wqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'Q') image (bqueen, c*100, r*100, 100, 100);
      if (grid[r][c] == 'k') image (wking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'K') image (bking, c*100, r*100, 100, 100);
      if (grid[r][c] == 'p') image (wpawn, c*100, r*100, 100, 100);
      if (grid[r][c] == 'P') image (bpawn, c*100, r*100, 100, 100);
    }
  }
}

void mouseReleased() {
  if(!myTurn)
    return;
  
  if (firstClick) {
    row1 = mouseY/100;
    col1 = mouseX/100;
    if(Character.isLowerCase(grid[row1][col1]) || grid[row1][col1] == ' ')
      return;
    firstClick = false;
  } else {
    row2 = mouseY/100;
    col2 = mouseX/100;
    if(Character.isUpperCase(grid[row2][col2]))
    return;
    if (!(row2 == row1 && col2 == col1)) {
            lastTaken = grid[row2][col2];

      grid[row2][col2] = grid[row1][col1];
      grid[row1][col1] = ' ';
      firstClick = true;
      
      out = row1 + "," + col1 + "," + grid[row1][col1] + ":" + row2 + "," + col2 + "," + grid[row2][col2];
      
      myTurn = false;
            canUndo = true;

      myClient.write(out);
    }
  }
}
