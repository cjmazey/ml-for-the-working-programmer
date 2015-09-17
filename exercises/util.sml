infixr 0 $
fun (f $ x) = f x

(* time: (unit -> unit) -> int -> unit
 *
 * run f n times and print timing info
 *)
fun time f n =
   let fun loop i = if i < 1
                       then ()
		    else (f ()
			  ; loop (i - 1))
       val t = Timer.startCPUTimer ()
       val _ = loop n
       val {gc = {sys = gs, usr = gu},
	    nongc = {sys = ns, usr = nu}} =
	   Timer.checkCPUTimes t
   in
      print "\n>>> TIMING INFO <<<\n"
      ; print $ " gc sys    : " ^ Time.toString gs ^ "\n"
      ; print $ " gc usr    : " ^ Time.toString gu ^ "\n"
      ; print $ " nongc sys : " ^ Time.toString ns ^ "\n"
      ; print $ " nongc sys : " ^ Time.toString nu ^ "\n\n"
   end
