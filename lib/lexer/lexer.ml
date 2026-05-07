open String
open Fmt

(** Base lexer type*)
type t = {input: string; position: int; ch: char option} [@@deriving show]

(** Take input and return token *)
let init input =
  if String.is_empty input then {input; position= 0; ch= None}
  else {input; position= 0; ch= Some (String.get input 0)}


let rec next_token lexer =
  let lexer = skip_whitespace lexer in
  let open Token in
  match lexer.ch with
  | None -> lexer, None
  | Some ch ->
     let lexer, token =
       match ch with
       | '(' -> advance lexer, LeftParentheses
       | ')' -> advance lexer, RightParentheses
       | '!' -> if_peeked lexer '=' ~default:Bang ~matched:NotEqual
       | ch when is_identifier ch -> read_identifier lexer
       | ch -> Fmt.failwith "Unknown char: %c" ch

     and peek_char lexer =
       if lexer.position >= String.length lexer.input - 1
       then None
       else Some (String.get lexer.input (lexer.position + 1))

     and seek lexer condition =
       let rec loop lexer = if condition lexer.ch then loop @@ advance lexer else lexer in
       let lexer = loop lexer in
       lexer, lexer.position

     and read_while lexer condition =
       let pos_start = lexer.position in
       let lexer, pos_end =
         seek lexer (function
             | Some character -> condition character
             | None -> false)
in lexer, String.sub lexer.input ~pos:pos_start ~len:(pos_end - pos_start)


     (** Skip whitespace in *)
     and skip_whitepsace lexer =
       let lexer, _ =
         seek lexer (function
           | Some ch -> Char.is_whitespace ch
           | None -> false)
       in lexer
     (** Check if character is matched with provided character*)
     and if_peeked lexer ch ~default ~matched =
       let lexer, result =
         match peek_char lexer with
         | Some peeked when Char.(peeked = ch) -> advance lexer, matched
         | _ -> lexer, default
       in
       advance lexer, result
     and read_identifier lexer =
       let lexer, ident = read_while lexer is_identifier in
       lexer, Token.lookup_ident ident

and is_identifier ch = Char.(ch = '_' || is_alpha ch)
