#=
    ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, 
    на котором могут находиться также внутренние прямоугольные перегородки 
    (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)
    РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры
=#

function mark_angles(r::Robot)
    num_vert = moves_end!(r, Sud)
    num_hor = moves_end!(r, West)
    for side in (Nord,Ost,Sud,West)
        moves!(r,side)
        putmarker!(r)
    end
    moves!(r, Sud)
    moves!(r, West)
    moves_end!(r, Nord, num_vert)
    moves_end!(r, Ost, num_hor)  
end

function moves!(r,side)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

moves!(r,side,num_steps) = for _ in 1:num_steps move!(r,side) end

function moves_end!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves_end!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps 
        move!(r,side)
    end
end