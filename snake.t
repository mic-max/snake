% right = 0, left = 1, up = 2, down = 3
const maxSnake := maxx * maxy

var control : array char of boolean
var x : array 0 .. maxSnake of nat1
var y : array 0 .. maxSnake of nat1
var long : nat2
var dir, add : nat1
var applex, appley : int

proc apple
    loop
	randint (applex, 0, maxx)
	randint (appley, 0, maxy)
	var flag : boolean := true
	for j : 0 .. maxy
	    for i : 0 .. maxx
		if x (i) = applex and y (i) = appley then
		    flag := false;
		end if
	    end for
	end for
	exit when (flag)
    end loop
end apple

proc setup
    x (0) := 128
    y (0) := 128
    long := 30
    add := 0
    dir := 0
    for i : 1 .. long
	x (i) := x (i - 1) - 1
	y (i) := y (0)
    end for
    apple
end setup

proc input
    Input.KeyDown (control)
    if control (KEY_RIGHT_ARROW) and dir not= 1 then
	dir := 0
    elsif control (KEY_LEFT_ARROW) and dir not= 0 then
	dir := 1
    elsif control (KEY_UP_ARROW) and dir not= 3 then
	dir := 2
    elsif control (KEY_DOWN_ARROW) and dir not= 2 then
	dir := 3
    end if
end input

proc logic
    if x (0) = applex and y (0) = appley then
	apple
	add := 10
    end if

    if add > 0 then
	add -= 1
	x (long + 1) := x (long)
	y (long + 1) := y (long)
	long += 1
    end if

    for i : 1 .. long
	if x (0) = x (i) and y (0) = y (i) then
	    setup
	end if
    end for

    for decreasing i : long .. 1
	x (i) := x (i - 1)
	y (i) := y (i - 1)
    end for

    if dir = 0 and x (0) < maxx then
	x (0) += 1
    elsif dir = 1 and x (0) > 0 then
	x (0) -= 1
    elsif dir = 2 and y (0) < maxy then
	y (0) += 1
    elsif dir = 3 and y (0) > 0 then
	y (0) -= 1
    else
	setup
    end if
end logic

proc draw
    cls
    colorback (black)
    Draw.Dot (applex, appley, 39)
    for i : 0 .. long
	Draw.Dot (x (i), y (i), 46)
    end for
    Font.Draw ("Score: ", 10, maxy - 18, Font.New ("mono:9"), white)
    Font.Draw (intstr (long - 30), 55, maxy - 18, Font.New ("mono:9"), white)
    View.Update
end draw

View.Set ("graphics:256;256, offscreenonly, nobuttonbar, title:Snake")
setup
loop
    input
    logic
    draw
    Time.Delay (16)
end loop
