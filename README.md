## References: Money in the Bank

1. Define a function `open_account` that takes an initial password as an argument and creates a bank account that stores the password, the current balance of the account (initially 0), and provides four methods, with signatures as indicated in the `bank_account` type:

   - `update_pass` takes the old password as the first argument and the new password as the second argument, and updates the stored password if the provided old password is correct. It does not check if the old password is the same as the new password.
   - `deposit` allows a user to deposit money into the account, if the user provides the correct password.
   - `retrieve` allows a user to retrieve money from the account, if the user provides the correct password and there are sufficient funds available in the account.
   - `show_balance` allows the user to query the account balance, if the user provides the correct password.

   For all functions, you should raise an error message if the password provided is incorrect (see `wrong_pass` in the prelude). If the user has given the wrong password five times *in a row*, no `deposit`, `retrieve`, or `show_balance`operations should be allowed until the password is changed (see `too_many_failures` in the prelude). Note that on the fifth incorrect attempt, the `wrong_pass` exception should be raised, and on *subsequent* attempts `too_many_failures`should be raised, regardless of whether or not the provided password is correct. The only exception is `update_pass`which should keep raising the `wrong_pass` error message even after 6 or more failed consecutive passwords; it should never return the `too_many_failures` message.

   An error should also be raised if the user tries to use a negative value of money (see `negative_amount` in the prelude) for `deposit` and `retrieve`, but only if the provided password is correct. Likewise, another error should also be raised if the user tries to withdraw more money than is in their account (see `not_enough_balance` in the prelude), but only after passing the password check. The required exceptions are provided in the prelude, and you must use them to get full credit.

   Here is an example of a sequence of function calls and the expected results:

   ```
   # let a = open_account "123";;
   val a : bank_account =
     {update_pass = <fun>;
      retrieve = <fun>;
      deposit = <fun>;
      show_balance = <fun>}
   # a.deposit "123" 500;;
   - : unit = ()
   # a.deposit "123" (-150);;
   Exception: Msg "Money amount below 0".
   # a.deposit "12" 50;;
   Exception: Msg "Wrong password".       (* Authentication failures: 1 *)
   # a.update_pass "123" "234";;
   - : unit = ()                          (* Correct password - failure count resets to 0 *)
   # a.deposit "123" 50;;
   Exception: Msg "Wrong password".       (* Authentication failures: 1 *)
   # a.show_balance "123";;
   Exception: Msg "Wrong password".       (* Authentication failures: 2 *)
   # a.retrieve "123" 6000;;
   Exception: Msg "Wrong password".       (* Authentication failures: 3 *)
   # a.show_balance "abc";;
   Exception: Msg "Wrong password".       (* Authentication failures: 4 *)
   # a.retrieve "pass" (-31415);;
   Exception: Msg "Wrong password".       (* Authentication failures: 5 *)
   # a.show_balance "234";;
   Exception: Msg "Please change your password". (* Correct password, but failed too many already *)
   # a.show_balance "23";;
   Exception: Msg "Please change your password".
   # a.update_pass "234" "232";;
   - : unit = ()
   # a.show_balance "232";;
   - : int = 500
   # a.deposit "232" 50;;
   - : unit = ()
   # a.show_balance "232";;
   - : int = 550
   # a.retrieve "232" 100;;
   - : unit = ()
   # a.retrieve "232" -100;;
   Exception: Msg "Money amount below 0".
   # a.retrieve "232" 500;;
   Exception: Msg "Insufficient balance".
   # a.show_balance "232";;
   - : int = 450
   # let b = open_account "123";;
   val b : bank_account =
     {update_pass = <fun>;
      retrieve = <fun>;
      deposit = <fun>;
      show_balance = <fun>}
   # b.deposit "123" 700;;
   - : unit = ()
   # b.update_pass "123" "232";;
   - : unit = ()
   # b.show_balance "232";;
   - : int = 700
   # a.show_balance "232";;
   - : int = 450
   ```

## Control flow and backtracking: I Want to Travel

Given the COVID pandemic and all travel restrictions, we don't travel as much as we are used to, but we can still dream to travel around Canada and make some plans. So, you sit down to relax and you dream about visiting places and you start to wonder, how could I travel to Iqaluit and if I were in Iqaluit, where could I travel to?

In this exercise, we will be implementing backtracking search on labelled graphs, using exceptions. We will represent a graph using the record type `'a graph` as defined for you in the prelude: a graph is made up of a list of nodes of type `'a` and a list of edges. An edge is represented by a pair `(v1, v2, w)`, meaning a *directed*edge going from the node `v1` to the node `v2` and the associated cost is `w`.

In all of the following questions, you may assume that the input graphs are well-formed: the nodes list will be a list of *all* the nodes in the graph, and no other values will appear in the edge pairs. (However, it is possible for a node in the graph not to be connected to any other nodes.) You can also assume that there will be no duplicate nodes or edges, and that there will be no self-loops (edges from a node to itself).

1. To warm up and to get used to the representation of graphs we have given you, write tests for and implement a function `neighbours: 'a graph -> 'a -> ('a * int) list` which, given a graph and a node that is in that graph, returns a list of that node's *out-neighbours* together with the cost it takes to reach that node. A node `v2` is an out-neighbour of node `v1` if an edge `(v1, v2, w)` exists in the graph, i.e., if there exists a directed edge *from* `v1` *to* `v2` with label `w`.

   This function can be implemented very nicely and simply by using `List.fold_left` or `List.fold_right`, though we do not require you to do this.

   **Some notes**: for both your test cases and your implementation, the order of nodes in the result list does not matter. We also do not expect you to be using very large graphs in your test cases; keep them simple. Finally, your test cases for `neighbours` should use input graphs of type `string graph`.

2. Write a function `find_path: 'a graph -> 'a -> 'a -> 'a list * int` which, given a graph `g` and two nodes `a` and `b`in the graph, returns a path (a list of nodes to visit, in order) from `a` to `b` together with the total cost to get to `b` from `a`. This path should include both of its endpoints, i.e. the list you return should start with the node `a` and end with the node `b`. There may be many possible paths; you only need to return one of them; the path that you return does not need to be shortest one; any path will do. If no possible path exists, you should raise the exception `Fail`.

   For this question, your function should be implemented using **backtracking** with the `Fail` exception. We recommend implementing your function using two mutually recursive functions `aux_node` and `aux_list` which process a single node and a weight, and a list of nodes, respectively. In this question, you are also allowed to rewrite the **inner auxiliary functions and the way they are declared as you wish**, **as long as you keep the input and output types of the main function the same**.

   **Note**: the path that you return should *not* contain any cycles, so no node should appear in your path more than once. In order to accomplish this you will need to keep track of a list of visited nodes, as indicated in the template.

3. Write a function `find_path': 'a graph -> 'a -> 'a -> 'a list * int`, where once again `find_path' g a b`returns a path from `a` to `b`, or raises the exception `Fail` if no path exists. This time your function should be implemented **tail-recursively using continuations**. If your function is found by the grader not to be tail-recursive, you will receive a grade of 0.

   Your recursive helper(s) should now take two extra parameters for a failure continuation and success continuation, respectively, as indicated in the template (failure and success continuations). You should not be raising any exceptions during execution unless no path exists between the two given nodes. In this question, you are also allowed to rewrite the **inner auxiliary functions and the way they are declared as you wish**, **as long as you keep their input and output types of the main function the same**.

4. Write a function `find_all_paths: 'a graph -> 'a -> 'a -> ('a list * int) list`, where `find_all_paths g a b`returns all path from `a` to `b` together with their associated cost. If no path exists, return an empty list.

   **Note**: think carefully how you build a set of paths recursively. In particular, you might want to ask: If there is an edge between `a` and `a'`, and given that I (recursively) already have a set of paths from `a'` to `b`, how can I generate a set of paths from `a` to `b`? - Imagine how these two sets look!

   In this question, you are also allowed to rewrite the **inner auxiliary functions and the way they are declared as you wish**, **as long as you keep their input and output types of the main function the same**.

5. Write a function `find_longest_path: 'a graph -> 'a -> 'a -> ('a list * int) option`, where `find_longest_path g a b` returns the longest (highest cost) path from `a` to `b` together with its associated cost, or returns `None` if no path exists.# comp302 hw4
# WeChat: cstutorcs

# QQ: 749389476

# Email: tutorcs@163.com

# Computer Science Tutor

# Programming Help

# Assignment Project Exam Help
