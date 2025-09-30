package main
import  fmt "core:fmt"
import rl "vendor:raylib"
import cards "../classes"

main :: proc()
{
    fmt.println("Stonk Card Game - Odin Edition")
    rl.InitWindow(1600, 900, "Stonk Card Game - Odin Edition");
    defer rl.CloseWindow();
    
    // Create a sample card
    // myCard: cards.Card
    // myCard.rank = cards.Rank.Ace;
    // myCard.suit = cards.Suit.Spades;
    // cards.setCardFace(&myCard);

    myDeck : cards.Deck = cards.initDeck();
    cards.shuffleDeck(&myDeck);

    cardTexture := rl.LoadTexture(myDeck.cards[0].face)
    cardTexture2 := rl.LoadTexture(myDeck.cards[3].face)

    rotation, scale : f32 = 0.0, 0.2;
    pos := [2]f32{(800 - f32(cardTexture.width)*scale) / 2,(600 - f32(cardTexture.height)*scale) / 2} ;

    i : i32 = 0
    for (!rl.WindowShouldClose()) 
    {
        rl.BeginDrawing();
        rl.ClearBackground(rl.RAYWHITE);
        
        if rl.IsKeyPressed(.W)
        {  
            if i < 51 {i += 1;} else {i = 0;}

            rotation += 1.0;
            cardTexture = rl.LoadTexture(myDeck.cards[i].face);

            fmt.println("W Pressed ", i+1);
            cards.printCard(myDeck.cards[i]);           
        }

        if rl.IsKeyPressed(.S)
        {  
            if i > 0 {i -= 1;} else {i = 51;}
            rotation -= 1.0;
            cardTexture = rl.LoadTexture(myDeck.cards[i].face);

            fmt.println("S Pressed ", i+1);
            cards.printCard(myDeck.cards[i]);        
        }

        if rl.IsKeyPressed(.RIGHT)
        {
            if i < 51 {i += 1;} else {i = 0;}
            j := (i+3)%52
            cardTexture2 = rl.LoadTexture(myDeck.cards[j].face)
        }

        rl.DrawTextureEx(cardTexture, pos ,rotation,scale, rl.WHITE);

        temp := pos[0]
        pos[0] += f32(cardTexture.width)*scale
        rl.DrawTextureEx(cardTexture2, pos ,rotation,scale, rl.WHITE);
        pos[0] = temp

        rl.DrawText("Press W to rotate and change card", 10, 10, 20, rl.DARKGRAY);    
        rl.EndDrawing();
    }

    defer rl.UnloadTexture(cardTexture)
    defer rl.UnloadTexture(cardTexture2)
    
}