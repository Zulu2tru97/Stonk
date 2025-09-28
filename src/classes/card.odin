package classes
import  fmt "core:fmt"
import  "core:strings"
import  runtime "base:runtime"
import "core:math/rand"

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

Deck :: struct 
{
    cards: [52]Card,
    top: int,
}

JokerDeck :: struct 
{
    d : Deck,
    cards: [54]Card,

}

initDeck :: proc() -> Deck 
{
    d: Deck;
    index := 0;
    for s in Suit 
    {
        for r in Rank 
        {
            d.cards[index].suit = s;
            d.cards[index].rank = r;
            setCardFace(&d.cards[index]);
            index += 1;
        }
    }
    d.top = 0;
    return d;
}

initJokerDeck :: proc() -> JokerDeck 
{
    d : JokerDeck;
    d.d = initDeck();
    // Add two jokers
    d.cards[52].rank = Rank.Ace;  // Arbitrary rank for joker
    d.cards[52].suit = Suit.Spades; // Arbitrary suit for joker
    setJokerCardFace(&d.cards[52], 1); // 1 for red joker
    
    d.cards[53].rank = Rank.Ace;  // Arbitrary rank for joker
    d.cards[53].suit = Suit.Hearts; // Arbitrary suit for joker
    setJokerCardFace(&d.cards[53], 2); // 2 for black joker
    
    d.d.top = 0;
    return d;
}

setJokerCardFace :: proc(c: ^Card, jokerType: int) 
{
    if jokerType == 1 
    {
        c.face = "../../assets/PlayingCards/PNG/RJ.png";
    } 
    else 
    {
        c.face = "../../assets/PlayingCards/PNG/BJ.png";
    }
}

printCard :: proc(c: Card) 
{
    fmt.println("Card: ", rank_to_str(c.rank), " of ", suit_to_str(c.suit));
}

Hand :: struct 
{
    cards: [dynamic]Card,
}

addCardToHand :: proc(h: ^[dynamic]Card, c: Card) 
{
   
    append(&h^, c);
}

removeCardFromHand :: proc(h: ^[dynamic]Card, index: int) -> Card 
{
    if index < 0 || index >= len(h) 
    {
        panic("Index out of bounds");
    }
    c := h[index];
    ordered_remove(&h^, index);
    return c;
}

shuffleDeck :: proc(d: ^[]Card) 
{
    for i := len(d) - 1; i > 0; i -= 1 
    {
        j := rand.int31_max(i32(i+1)); // Random index from 0 to i
        // Swap cards
        temp := d[i];
        d[i] = d[j];
        d[j] = temp;
    }
    
}