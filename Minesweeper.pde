

import de.bezier.guido.*;
private  int NUM_ROWS = 20;
private  int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private boolean gameLost= false;
private int numClicked = 0;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    //Interactive.make(this);
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
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
    while(bombs.size() < 30)
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

    background(0);
    if(gameLost == true)
    {
        displayLosingMessage();
    }

    if(isWon() && gameLost == false)
        displayWinningMessage();

}
public boolean isWon()
{
    if(numClicked >= (NUM_ROWS*NUM_COLS) - bombs.size())
    {
        return true;
    }
    return false;
}
public void displayLosingMessage()
{
    stroke(255, 0, 0);
    String losingMessage = "You Lose";
   //shows where the bombs are when you lose
    for(int j = 0; j < bombs.size(); j++)
    {
        bombs.get(j).mousePressed();
    }
    //clicks all other buttons when you lose
    for(int k = 0; k < NUM_ROWS; k++)
    {
        for(int l = 0; l < NUM_COLS; l++)
        {
            buttons[k][l].mousePressed();
            buttons[k][l].setLabel("");
        }
        
    }
    //tells player they lost
    for(int i = 0; i < losingMessage.length(); i++)
    {
        buttons[NUM_ROWS/2 - 1][NUM_COLS/2 - 4 + i].setLabel(losingMessage.substring(i, i+1));
    }


}
public void displayWinningMessage()
{
    String winningMessage = "You Win!";
    for(int i = 0; i < winningMessage.length(); i++)
    {
        buttons[NUM_ROWS/2 - 1][NUM_COLS/2 - 4 + i].setLabel(winningMessage.substring(i, i+1));
    }
}

public class MSButton
{   
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
        numClicked++;

        if(keyPressed) 
        {
            if(isMarked())
            {
                marked = false;
            }

            if(!isMarked()) 
            {
                marked = true;
            }
        }

        else if(bombs.contains(this))
        {
            gameLost = true;
        }

        else if(countBombs(r,c) > 0)
        {
            int countBombs = countBombs(r, c);
            label = Integer.toString(countBombs(r,c));
        }

        else
        {
            if(isValid(r + 1,c - 1))
            {
                    if(!buttons[r+1][c-1].isClicked())
                {
                    buttons[r+1][c-1].mousePressed();

                }
            }
            if(isValid(r + 1,c))
            {
                if(!buttons[r+1][c].isClicked())
                {
                    buttons[r+1][c].mousePressed();
                }
            }
          
           
            if(isValid(r + 1,c + 1))
            {
                if(!buttons[r+1][c+1].isClicked())
                {
                    buttons[r+1][c+1].mousePressed();
                }
            }
               
             //left and right of clicked
            if(isValid(r,c - 1))
            {
                if(!buttons[r][c-1].isClicked())
                {
                    buttons[r][c-1].mousePressed();
                }
            }
            
              
            if(isValid(r,c + 1))
            {
                if(!buttons[r][c+1].isClicked())
                {
                    buttons[r][c+1].mousePressed();
                }
            }
              
            //below clicked
            if(isValid(r- 1,c - 1))
            {
                if(!buttons[r-1][c-1].isClicked())
                {
                    buttons[r-1][c-1].mousePressed();
                }
            }
            
            if(isValid(r - 1,c))
            {
                if(!buttons[r-1][c].isClicked())
                {
                    buttons[r-1][c].mousePressed();
                }
            }
             
            if(isValid(r - 1,c + 1))
            {
                if(!buttons[r-1][c+1].isClicked())
                {
                    buttons[r-1][c+1].mousePressed();
                }
            }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if(clicked && bombs.contains(this)) 
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
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
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



