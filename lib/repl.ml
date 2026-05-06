(* Basic Test REPL *)

let repl =
  print_string "LISP REPL v0.0.1\n";
  print_string "Press Ctrl+c to Exit\n";
  while true do
    (* Output prompt *)
    print_string "LISP> ";

    (* Take input and return it *)
    let input = read_line () in
    print_endline ("Hello, " ^ input)
  done
;;
