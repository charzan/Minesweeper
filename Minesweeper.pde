

import de.bezier.guido.*;
private  int NUM_ROWS = 20;
private  int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[20][20];
    bombs = new ArrayList <MSButton>();
    for(int row = 0; row < NUM_ROWS; row++)
    {
        for(int col = 0; col < NUM_COLS; col++)
        {
            buttons[row][col] = new MSButton(row,col);
        }
    }
    
    
    
    setBombs();
}
public void setBombs()
{
    //your code
    while(bombs.size() < 10)
    {
        int bombRow = (int)(Math.random()*NUM_ROWS);
        int bombCol = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[bombRow][bombCol]))
        {
            bombs.add(buttons[bombRow][bombCol]);
        }
    }
    
    
}

public void draw ()
{

    background( 0 );
    if(isWon())
        displayWinningMessage();

}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    fill(150, 56, 10, 250);
    System.out.println("got it");
    textSize(30);
    stroke(255, 0, 0);
    text("Game Over", 200, 200);
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{



    
    // * `public void mousePressed()` which:
    //     * sets `click` to true
    //     * if `keyPressed` is `true`, toggles `marked` to either either `true` or `false`
    //     * else if `bombs` contains `this` button display the losing message
    //     * else if `countBombs` returns a number of neighboring mines greater than zero, 
    //       set the label to that number
    //     * else recursively call `mousePressed` with the valid, unclicked, neighboring buttons 
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed)
            isMarked();
        else if(bombs.contains(this))
            displayLosingMessage();


        //your code here
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(!bombs.contains(buttons[r][c]))
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //above clicked
        if(isValid(row + 1,col - 1) && (bombs.contains(buttons[row + 1][col - 1])))
            numBombs ++;
        if(isValid(row + 1,col) && (bombs.contains(buttons[row + 1][col ])))
            numBombs ++;
       
        if(isValid(row + 1,col + 1) && (bombs.contains(buttons[row + 1][col + 1])))
            numBombs ++;
         //left and right of clicked
        if(isValid(row,col - 1) && (bombs.contains(buttons[row][col - 1])))
            numBombs ++;
        if(isValid(row,col + 1) && (bombs.contains(buttons[row][col + 1])))
            numBombs ++;
        //below clicked
        if(isValid(row - 1,col - 1) && (bombs.contains(buttons[row - 1][col - 1])))
            numBombs ++;
        if(isValid(row - 1,col) && (bombs.contains(buttons[row - 1][col])))
            numBombs ++;
        if(isValid(row - 1,col + 1) && (bombs.contains(buttons[row - 1][col + 1])))
            numBombs ++;

       
        return numBombs;
    }
}



