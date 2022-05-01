# CPLEX-James-Bond
Project developed using IBM CPLEX OPL.

## What it does
The code builds a mixed integer linear programming model for a problem and implement it in OPL. The statement of the problem is the following:

A set *S* of *n* codes must be entered in a door lock to unlock the door. The codes are sequences of m digits that can be either **0**s or **1**s. All codes must be entered exactly once except for the first and last codes which have to be a sequence of m **0**s, this code is also inside of the _S_ set. The zeros sequence must be entered at the beginning and at the end of the code entering  
The codes are entered using a display which has a sequence of m zeros as the first sequence and a cursor that is placed in the leftmost position. The system has three keys: 
-	**RIGHT** is used to move the cursor on the display one step to the right.
-	**FLIP** is used to change the value of the position where the cursor is placed to the opposite value.
-	**ENTER** is used to enter the code in the system. It can only be used when the cursor is at the rightmost position. Whenever enter is used, the cursor moves to the leftmost position and the entered code remains in the display. 

The set of codes that have to be entered is given as data. The set sizes (*m* columns *n* rows) is also given in the data as input.

The CPLEX implementation outputs the minimum number of **FLIP**s that have to be done while entering the code and the order of the entered codes. We had problems in the ordering output, it works for some of the datasets but fails to give a good order (respecting the constraints imposed in the model) in some cases.
