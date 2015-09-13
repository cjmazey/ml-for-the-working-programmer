signature STACK =
   sig
      type 'a t

      exception StackEmpty

      val empty: unit -> 'a t
      val isEmpty: 'a t -> bool
      val push: 'a * 'a t -> unit
      val pop: 'a t -> 'a
   end

structure Stack:> STACK =
   struct
      type 'a t = 'a list ref

      exception StackEmpty

      val empty = fn () => ref []

      fun isEmpty s = null (!s)

      fun push (x, s) =
         (s := x :: !s
          ; ())

      fun pop s =
         case !s of
            x :: xs => (s := xs
                        ; x)
          | _ => raise StackEmpty
   end

fun increase (k, n): IntInf.int =
   if (k + 1) * (k + 1) > n
      then k
   else k + 1

fun intRoot n =
   let val s : IntInf.int Stack.t = Stack.empty ()
       val r = ref 0
       val m = ref n
   in
      (while !m <> 0
       do
          (Stack.push (!m, s)
           ; m := !m div 4)
       ; while (not (Stack.isEmpty s))
         do
            r := increase (2 * !r, Stack.pop s)
       ; !r)
   end
