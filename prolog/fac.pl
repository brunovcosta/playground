left(A,B):-
	nth0(0,A,AX),
	nth0(1,A,AY),
	nth0(0,B,BX),
	nth0(1,B,BY),
	AX<BX.
directionVector(A,B,AB):-
	nth0(0,A,AX),
	nth0(1,A,AY),
	nth0(0,B,BX),
	nth0(1,B,BY),
	nth0(0,AB,ABX),
	nth0(1,AB,ABY),
	BX-AX = ABX,
	BY-AY = ABY.
crossProduct(A,B,C):-
	
/*
* Check intersection of lines L1:=[A1,B1] and L2[A2,B2]
* Method (cross product):
* 	sign(A1B2 x A1B1)=sign(A1B1 x A1A2)
* 	sign(C1)=sign(C2)
* 	and
* 	sign(A2A1 x A2B2)=sign(A2B2 x A2B1)
* 	sign(C3)=sign(C4)
*/
intersect(L1,L2):-
	nth0(0,L1,A1),
	nth0(1,L1,B1),
	nth0(0,L2,A2),
	nth0(1,L2,B2),
	directionVector(A1,B1,A1B1),
	directionVector(A1,B2,A1B2),
	directionVector(A1,A2,A1A2),
	directionVector(A2,A1,A2A1),
	directionVector(A2,B1,A2B1),
	directionVector(A2,B2,A2B2),
	crossProduct(A1B2,A1B1,C1),
	crossProduct(A1B1,A1A2,C2),
	crossProduct(A2A1,A2B2,C3),
	crossProduct(A2B2,A2B1,C4),
	sameSign(C1,C2),
	sameSign(C3,C4).

