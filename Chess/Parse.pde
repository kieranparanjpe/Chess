
public void Parse(String in)
{
    String[] a = in.split(":");
    
    String[] b = a[0].split(",");
    String[] c = a[1].split(",");

    grid[parseInt(b[0])][parseInt(b[1])] = (b[2].charAt(0));
    grid[parseInt(c[0])][parseInt(c[1])] = (c[2].charAt(0)); 
}
