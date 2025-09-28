package main
import  fmt "core:fmt"
import rl "vendor:raylib"

// Make sure the card module exists at the specified path or update the path accordingly
import card "../classes"


main :: proc()
{
    fmt.println("Stonk Card Game - Odin Edition")
    rl.InitWindow(800, 600, "Stonk Card Game - Odin Edition");
    defer rl.CloseWindow();
    
    // Create a sample card
    myCard: card.Card;
    myCard.rank = card.Rank.Ace;
    myCard.suit = card.Suit.Spades;
    card.setCardFace(&myCard);
    
    // Load the texture for the card face
    cardTexture := rl.LoadTexture(myCard.face);
   
    
    // Main game loop
    for (!rl.WindowShouldClose()) 
    {
        rl.BeginDrawing();
        rl.ClearBackground(rl.RAYWHITE);
        
        // Draw the card texture at the center of the window
        rl.DrawTexture(cardTexture, (800 - cardTexture.width) / 2, (600 - cardTexture.height) / 2, rl.WHITE);
        
        rl.EndDrawing();
    }
    
}