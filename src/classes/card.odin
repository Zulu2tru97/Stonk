package classes
import  fmt "core:fmt"
import  "core:strings"
import  runtime "base:runtime"

Rank:: enum 
{
    Two = 2,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Ten,
    Jack,
    Queen,
    King,
    Ace,
}
Suit::enum 
{
    Clubs,
    Diamonds,
    Hearts,
    Spades,
} 

Card :: struct 
{
    rank: Rank,
    suit: Suit,
    face: cstring
}


setCardFace :: proc(c: ^Card) 
{
    //Odin only allows compile-time string concatenation for constants. For runtime values (enum -> string) you must use runtime APIs. strings.join is a core:strings API and was the user's requested library.
    // Raylib's LoadTexture expects a C-style NUL-terminated string (cstring). Odin string values are not guaranteed to be NUL-terminated, so we copy the bytes into a u8 buffer and append a 0 byte, then pass that buffer's pointer as cstring.
    // This avoids compile-time-only concatenation and keeps the call safe for the C API.
    // build path at runtime using strings.join
    filePath := strings.join([]string{"../../assets/PlayingCards/PNG/", rank_to_str(c.rank), suit_to_str(c.suit), ".png"}, "");
    buf, _ := runtime.make_slice([]u8, len(filePath) + 1);
    for i := 0; i < len(filePath); i += 1 
    {
        buf[i] = cast(u8)filePath[i];
    }
    buf[len(filePath)] = 0;
    cstr := cast(cstring)(&buf[0]);
    c.face = cstr;
        
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
