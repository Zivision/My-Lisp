(* This is an interface file to lex.ml *)

(** Main type for the lexer *)
type t

(** Create a new lexer from string input *)
val init : string -> t

(** Move the lexer to the next token *)
val next_token : t -> t* Token.t option

(** Pretty printing the lexer *)
val pp : Format.formatter -> t -> uint
val show : t -> string
