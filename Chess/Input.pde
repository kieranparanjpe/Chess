boolean k,r,q,b;

void keyReleased()
{
   if((key == 'z' || key == 'Z') && canUndo && out != "")
   {
    String[] a = out.split(":");
    
    String[] b = a[0].split(",");
    String[] c = a[1].split(",");
    
    out = b[0] + "," + b[1] + "," + c[2] + ":" + 
      c[0] + "," + c[1] + "," + lastTaken;
    

     Parse(out);
     
     out = "e" + out;
     
     myServer.write(out);
     
     canUndo = false;
     myTurn = true;
   }
   if(key == 'q' || key == 'Q')
   {
     q = false;
   }
   if(key == 'r' || key == 'R')
   {
     r = false;
   }
      if(key == 'k' || key == 'K')
   {
     k = false;
   }
      if(key == 'b' || key == 'B')
   {
     b = false;
   }
}

void keyPressed()
{
  if(key == 'q' || key == 'Q')
   {
     q = true;
   }
   if(key == 'r' || key == 'R')
   {
     r = true;
   }
      if(key == 'k' || key == 'K')
   {
     k = true;
   }
      if(key == 'b' || key == 'B')
   {
     b = true;
   }
}
