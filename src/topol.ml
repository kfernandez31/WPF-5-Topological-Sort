(************************************************************)
(* Author: Kacper Kramarz-Fernandez, index: 429629, gr: IV *)
(* Reviewer: Patryk Malcher, index: ???, gr: I *)
(************************************************************)

exception Cykliczne
;;

(* 
    Nodes can be categorised as:
    - white: unvisited, neighbors unvisited
    - grey: visited, neighbors unvisited
    - black: visited, neighbors visited
*)
type color = White | Grey | Black 
;;

(*  
    A graph is a map, where:
    - keys: nodes
    - values: node's neighbors, node's color
*)
type 'a graph = ('a, ('a list) * color) PMap.t
;;

let topol (adj_list: ('a*'a list) list) : ('a list) =
(* Preprocesses the adjacency list, merging all tuples having the same first element by joining their lists *)
    let preprocess_list (adj_list: ('a*'a list) list) : (('a*'a list) list) =
        let cmp (v, vlist) (w, wlist) = 
            compare v w in
        let sorted_list = List.sort cmp adj_list in
        let rec aux lst acc = 
            let rec append_same (v, vlist) lst = 
                match lst with
                | [] -> ((v, vlist), [])
                | (x, xlist)::tx -> 
                    if x = v then append_same (v, vlist @ xlist) tx
                    else ((v, vlist), lst) in
            match lst with
            | [] -> acc
            | (v, vlist)::tv -> 
                let (appended, next) = append_same (v, vlist) tv in
                aux next (appended :: acc)
        in aux sorted_list []
    in let prepr_list = preprocess_list adj_list in

(* Creates a graph based on the input list of edges, where an edge is a (value, neighbor) pair. *)
    let make_graph (lst: ('a*'a list) list) : ('a graph) =
        let f acc (v, neighbors) =
            PMap.add v (neighbors, White) acc in
        let empty_graph = PMap.create compare in
        List.fold_left f empty_graph lst in 
    let graph = ref (make_graph prepr_list) in

(* DFS of a graph that detects cycles and colors nodes along the way. *)
    let res = ref [] in
    let rec dfs (v: 'a) : unit =
        let node =
            try PMap.find v !graph with
            | Not_found -> ([], White) in (* node with only entering edges *)
        match node with
        | (_, Black) -> () 
        | (_, Grey) -> raise Cykliczne 
        | (neighbors, White) -> (* white node *)
        begin
            graph := PMap.add v (neighbors, Grey) !graph; (* mark node as grey *)
            List.iter dfs neighbors;
            graph := PMap.add v (neighbors, Black) !graph; (* mark node as black *)
            res := v::!res;
        end
    in
    List.iter (fun (v, _) -> dfs v) prepr_list;
    !res
;;