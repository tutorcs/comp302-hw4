https://tutorcs.com
WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
let notimplemented () =
  failwith "This function is not yet implemented."

(* For Question 1 *)
exception Msg of string

type passwd = string
type bank_account = {
  update_pass : passwd -> passwd -> unit;
  retrieve    : passwd -> int -> unit;
  deposit     : passwd -> int -> unit;
  show_balance : passwd -> int;
}

(* Bank account errors *)
let negative_amount = Msg "Money amount below 0"
let wrong_pass = Msg "Wrong password"
let too_many_failures = Msg "Please change your password"
let not_enough_balance = Msg "Insufficient balance"

(* For Question 2 *)
exception Fail

(* The type of graphs. *)
type weight = int
type 'a graph = {
  nodes: 'a list;
  edges: ('a * 'a * weight) list
}
