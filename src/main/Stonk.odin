package src
import  fmt "core:fmt"
import rl "vendor:raylib"
import cards "../classes"
import c "core:c"




main :: proc()
{
    WindowGirth, WindowHeight :: 1600, 900
    fmt.println("Stonk Card Game - Odin Edition")

    rl.InitWindow(WindowGirth, WindowHeight, "Stonk Card Game - Odin Edition");
    defer rl.CloseWindow();
    rl.SetTargetFPS(60);

    cardSheet := rl.LoadTexture("../../assets/Tilesheet/cardsLarge_tilemap.png");
    sheetCols, sheetRows : c.int = 14, 4; // 14 columns and 4 rows in the sprite sheet
    width := f32(cardSheet.width) /f32(sheetCols)
    height := f32(cardSheet.height) / f32(sheetRows);


    getCardRect :: proc(card: cards.Card,width:f32,height:f32) -> rl.Rectangle
    {
        
        cardFace := card.face
        return rl.Rectangle{cardFace[0]*width, cardFace[1]*height, width, height};
    }

    myDeck : cards.Deck = cards.initDeck(); 
    numCards := 5
    numPlayers := 4

  
    

    rotation, scale : f32 = 0.0, 1.5

 

    origin := rl.Vector2{f32(width*scale/2), f32(height*scale/2)}

    myCard := myDeck.cards[0]
    


    cards.printCard(myCard)
    fmt.println(width,height,cardSheet.width,cardSheet.height,myCard.face)

    hands : [dynamic]cards.Hand
    cards.shuffleDeck(&myDeck)
    cards.deal(&myDeck, &hands, numCards, numPlayers)

    for h in hands
    {
        fmt.println("Hand:")
        for c in h.cards
        {
            cards.printCard(c)
        }
    }
    

  
    for (!rl.WindowShouldClose()) 
    {
        

        if rl.IsKeyPressed(.SPACE)
        {
            cards.shuffleDeck(&myDeck)
            cards.deal(&myDeck, &hands, numCards, numPlayers)

        }

        
        rl.BeginDrawing();
        rl.ClearBackground(rl.RAYWHITE);
        
        // for i := 0; i < (numCards * numPlayers); i += 1
        // {
        //     np:= i % numPlayers
        //     nc:= i % numCards
        //     destRec := rl.Rectangle{f32(100 + f32(np) * (width*scale + 20)), f32(50 + f32(i / numPlayers) * (height*scale + 20)), width*scale, height*scale}
        //     rl.DrawTexturePro(cardSheet, getCardRect(hands[np].cards[nc],width,height),destRec ,rl.Vector2{0,0}, 0.0, rl.WHITE);
            
           
        // }
        i := 0
        for h in hands
        {
            pos := rl.Vector2{f32(100 + f32(i) * (width*scale + 20)), 20}
            ipos := [2]i32{i32(pos[0]), i32(pos[1])}
        
            rl.DrawText(fmt.ctprintf("Player %d",i+1), ipos[0],ipos[1], 20, rl.DARKGRAY)
            j:= 0
            for c in h.cards
            {
                
                destRec := rl.Rectangle{f32(100 + f32(i) * (width*scale + 20)), f32(50 + f32(j) * (height*scale + 20)), width*scale, height*scale}
                rl.DrawTexturePro(cardSheet, getCardRect(c,width,height),destRec ,rl.Vector2{0,0}, 0.0, rl.WHITE);
                j += 1
            }
            i += 1
        }
        

        // for !rl.IsKeyPressed(.Q)
        // {
            
        // }
     
        rl.EndDrawing();
    }

    defer rl.UnloadTexture(cardSheet);
    
}