package main
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
    
    

    myDeck : cards.Deck = cards.initDeck();
    cards.shuffleDeck(&myDeck);

    // cardSheet := rl.LoadTexture("/assets/Tilesheet/cardsMedium_tilemap_packed.png");
    cardSheet := rl.LoadTexture("../../assets/Tilesheet/cardsLarge_tilemap.png");
    sheetCols, sheetRows : c.int = 14, 4; // 14 columns and 4 rows in the sprite sheet
    width := f32(cardSheet.width) /f32(sheetCols)
    height := f32(cardSheet.height) / f32(sheetRows);

    rotation, scale : f32 = 0.0, 5;
    // pos : rl.Vector2 
    destinationRec := rl.Rectangle{WindowGirth/2, WindowHeight/2, f32(width*scale), f32(-height*scale)}
    origin := rl.Vector2{f32(width*scale/2), f32(height*scale/2)}

    myCard := myDeck.cards[0]

    cards.printCard(myCard)
    fmt.println(width,height,cardSheet.width,cardSheet.height,myCard.face)
    

    
    
    
    



    

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

        sourceRecforSinglecard := rl.Rectangle{cardFace[0]*width, cardFace[1]*height, width, height};
        // destinationRec := rl.Rectangle{800, 450, f32(width*scale), f32(-height*scale)}
        // origin := rl.Vector2{f32(width*scale/2), f32(height*scale/2)}
        // fmt.println(cardFace[0]*width)
        // fmt.println(cardFace[1]*height)
        
        // rl.DrawText(cards.toString(&myDeck.cards[i]), 10, 10, 20, rl.DARKGRAY);
        // cards.printCard(myDeck.cards[i])
        rl.DrawTexturePro(cardSheet, sourceRecforSinglecard, destinationRec, origin, rotation, rl.WHITE);
        rl.DrawLine(i32(destinationRec.x), 0, i32(destinationRec.x), WindowHeight, rl.GRAY);
        rl.DrawLine(0,i32(destinationRec.y), WindowGirth,i32(destinationRec.y), rl.GRAY);

        

        
        rl.EndDrawing();
    }

    defer rl.UnloadTexture(cardSheet);
    
}