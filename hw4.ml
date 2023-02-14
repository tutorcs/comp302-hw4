https://tutorcs.com
WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
(* ------------------------------------------------------------------------*)
(* Q1 : Money in the Bank *)
(* ------------------------------------------------------------------------*)

let open_account (initial_pass: passwd) : bank_account =
  notimplemented ()
;;

(* ------------------------------------------------------------------------*)
(* Q2 : I Want to Travel *)
(* ------------------------------------------------------------------------*)
(* TODO: Write some tests for neighbours. Consider creating a graph first,
 and then writing your tests based on it *)

(* Reminder: If a test case requires multiple arguments, use a tuple:
let myfn_with_2_args_tests = [
  ((arg1, arg1), (expected_output))
]
*)

(* We've added a type annotation here so that the compiler can help
   you write tests of the correct form. *)
let neighbours_tests: ((string graph * string) * (string * weight) list) list = [
]

(* TODO: Implement neighbours. *)
let neighbours (g: 'a graph) (vertex: 'a) : ('a * weight) list =
  notimplemented ()

(* TODO: Implement find_path. *)
let find_path (g: 'a graph) (a: 'a) (b: 'a) : ('a list * weight) =
  let rec aux_node (node: 'a * weight) (visited : 'a list) : ('a list * weight) =
    notimplemented ()
  and aux_list (nodes: ('a * weight) list) (visited: 'a list) : ('a list * weight) =
    notimplemented ()
  in
  notimplemented ()

(* TODO: Implement find_path'. *)
let find_path' (g: 'a graph) (a: 'a) (b: 'a) : ('a list * weight) =
  let rec aux_node (node: 'a * weight) (visited : 'a list) fc sc : ('a list * weight)=
    notimplemented ()
  and aux_list (nodes: ('a * weight) list) (visited: 'a list) fc sc : ('a list * weight) =
    notimplemented ()
  in
  notimplemented ()


(* TODO: Implement find_all_paths *)
let find_all_paths (g: 'a graph) (a: 'a) (b: 'a) : ('a list * weight) list =
  let rec aux_node (node: 'a * weight) (visited : 'a list) : ('a list * weight) list =
    notimplemented ()
  and aux_list (nodes: ('a * weight) list) (visited: 'a list) : ('a list * weight) list =
    notimplemented ()
  in
  notimplemented ()


(* TODO: Implement find_longest_path *)
let find_longest_path (g: 'a graph) (a: 'a) (b: 'a) : ('a list * weight) option =
  notimplemented ()
