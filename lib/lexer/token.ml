(** Token Types *)
(** Main types for our lisp values*)
type t =
  (** Error Type*)
  | Error
  (* Basic Types *)
  | Symbol
  | Number
  | Function
  (** Parenthesis*)
  | LeftParetheses
  | RightParetheses
  (** Equal and Not Equal*)
  | Equal
  | NotEqual
  (** Misc *)
  | Bang
  (** Keywords *)
  | DefineFunction
  | DefineVariable
  | True
  | Nil
  | If
  | DefineMacro

(** Look up identifier*)
let lookup_ident str =
  match str with
  | "fn" -> DefineFunction
  | "def"  -> DefineVariable
  | "t" -> True
  | "nil" -> Nil
  | "if" -> If
  | "macro" -> DefineMacro
;;
