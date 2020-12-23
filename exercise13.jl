#=
ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.
(Подсказка: решение будет подобно решению задачи 1,
 если направление премещения Робота задавать кортежами пары значений типа HorizonSide)
=#
function mark_cross!(r::Robot)
    for side in((Nord,Ost),(West,Sud),(Nord,West),(Sud,Ost)) 
        putmarkers!(r,side)
        side_inv=inverse(side)
        move_by_marker!(r,side_inv)
    end
putmarker!(r)
end

function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

function move_by_marker!(r::Robot,side::HorizonSide)
    while ismarker(r)==true
        move!(r,side)
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))