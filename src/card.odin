package FIRSTTRY
import "core:fmt"

import  rl "vendor:raylib"

main :: proc() 
{

     Rank: enum 
        {
            two = 2,
            three,
            four,
            five,
            six,
            seven,
            eight,
            nine,
            ten,
            jack,
            queen,
            king,
            ace,  
        }
        Suit: enum 
        {
            clubs,
            diamonds,
            hearts,
            spades,
        } 
    Card :: struct 
    {
        rank: rank,
        suit: suit,
        face: rl.Texture2D
    }

    setCardFace :: proc(c: ^Card) 
    {
        filePath: string = "assets/Cards/" + rank_to_str(c.rank) + suit_to_str(c.suit) + ".svg";
        c.face = rl.LoadTexture(filePath);
    }

    showCard :: proc(c: ^Card, x: int, y: int) 
    {
        rl.DrawTexture(c.face, i32(x), i32(y), rl.WHITE);
    }

    rank_to_str :: proc(r: Rank) -> string 
    {
        switch r 
        {
            case Rank.Two:   return "2"
            case Rank.Three: return "3"
            case Rank.Four:  return "4"
            case Rank.Five:  return "5"
            case Rank.Six:   return "6"
            case Rank.Seven: return "7"
            case Rank.Eight: return "8"
            case Rank.Nine:  return "9"
            case Rank.Ten:   return "T"
            case Rank.Jack:  return "J"
            case Rank.Queen: return "Q"
            case Rank.King:  return "K"
            case Rank.Ace:   return "A"
        }
        return "?"  // fallback (shouldn't happen)
    }

    suit_to_str :: proc(s: Suit) -> string 
    {
        switch s 
        {
            case Suit.Clubs:    return "C"
            case Suit.Diamonds: return "D"
            case Suit.Hearts:   return "H"
            case Suit.Spades:   return "S"
        }
        return "?"
    }

    {
        fmt.println("Hello, Odin!");
    }

    

   rl.InitWindow(800, 450, "raylib Card Example");

    rl.SetTargetFPS(60); 
 
    myCard: Card;
    myCard.rank = rank.ace;
    myCard.suit = suit.spades;
    setCardFace(&myCard);

    for !rl.WindowShouldClose() 
    {
         rl.BeginDrawing();
         rl.ClearBackground(rl.RAYWHITE);
         showCard(&myCard, 100, 100);
         rl.EndDrawing();
    }

    defer rl.CloseWindow();
}