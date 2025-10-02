package main
import  fmt "core:fmt"
import rl "vendor:raylib"
import cards "../classes"
import c "core:c"

main :: proc()
{
    fmt.println("Stonk Card Game - Odin Edition")
    rl.InitWindow(1600, 900, "Stonk Card Game - Odin Edition");
    defer rl.CloseWindow();
    
    

    myDeck : cards.Deck = cards.initDeck();
    cards.shuffleDeck(&myDeck);

    // cardSheet := rl.LoadTexture("/assets/Tilesheet/cardsMedium_tilemap_packed.png");
    cardSheet := rl.LoadTexture("../../assets/Tilesheet/cardsLarge_tilemap.png");
    sheetCols, sheetRows : c.int = 14, 4; // 14 columns and 4 rows in the sprite sheet
    width := f32(cardSheet.width) /f32(sheetCols)
    height := f32(cardSheet.height) / f32(sheetRows);

    myCard := myDeck.cards[0]

    cards.printCard(myCard)
    fmt.println(width,height,cardSheet.width,cardSheet.height,myCard.face)
    

    
    
    
    



    rotation, scale : f32 = 0.0, 1;
    pos : rl.Vector2 

    i : i32 = 0
    for (!rl.WindowShouldClose()) 
    {
        rl.BeginDrawing();
        rl.ClearBackground(rl.RAYWHITE);
        
        if rl.IsKeyPressed(.W)
        {  
            if i < 51 {i += 1;} else {i = 0;}

            rotation += 1.0;

            fmt.println("W Pressed ", i+1);
        }

        if rl.IsKeyPressed(.S)
        {  
            if i > 0 {i -= 1;} else {i = 51;}
            rotation -= 1.0;


            fmt.println("S Pressed ", i+1);
            
        }

        if rl.IsKeyPressed(.RIGHT)
        {
            if i < 51 {i += 1;} else {i = 0;}
            j := (i+3)%52

        }


        rl.DrawTexture(cardSheet, 0,0, rl.WHITE);
        cardFace := myDeck.cards[i].face

        sourceRecforSinglecard := rl.Rectangle{cardFace[0]*width, cardFace[1]*height, width *scale, height *scale};
        // fmt.println(cardFace[0]*width)
        // fmt.println(cardFace[1]*height)
        
        // rl.DrawText(cards.toString(&myDeck.cards[i]), 10, 10, 20, rl.DARKGRAY);
        // cards.printCard(myDeck.cards[i])
        rl.DrawTexturePro(cardSheet, sourceRecforSinglecard, rl.Rectangle{800, 450, f32(width*scale), f32(-height*scale)}, rl.Vector2{f32(width*scale/2), f32(height*scale/2)}, rotation, rl.WHITE);
        

        
        rl.EndDrawing();
    }

    defer rl.UnloadTexture(cardSheet);
    
}