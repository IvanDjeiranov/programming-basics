#=
    ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. 
    Робот - в произвольной клетке поля между внешней и внутренней перегородками. 
    РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.
=#
function find_peregarotka(r::Robot)
    side = Ost
    while isborder(r,Nord)==false
        moves!(r,side)
        if isborder(r,Nord)==false
            move!(r,Nord)
            side = inverse(side)
        end        
    end
    putmarker!(r)
    obhod(r,side)
end

function moves!(r::Robot,side::HorizonSide)
    while (isborder(r,Nord)==false) && (isborder(r,side)==false)
        move!(r,side)
    end
end

function obhod(r::Robot,side::HorizonSide)
    while isborder(r,Nord)==true
        move!(r,side)
        putmarker!(r)
    end
    move!(r,Nord)
    putmarker!(r)
    side = inverse(side)
    if isborder(r,side)==true
        while isborder(r,side)==true
            move!(r,Nord)
            putmarker!(r)
        end 
    end
    move!(r,side)
    putmarker!(r)
    while isborder(r,Sud)==true
        move!(r,side)
        putmarker!(r)
    end
    side = inverse(side)
    move!(r,Sud)
    putmarker!(r)
    while isborder(r,side)==true
        move!(r,Sud)
        putmarker!(r)
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))

next(side::HorizonSide)=HorizonSide(mod(Int(side)+1,4))