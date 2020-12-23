#=
    ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля
    РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы
=#

function mark_all!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
    side = Ost
    putmarkers!(r,side)
    while isborder(r,Nord)==false    
        if isborder(r,side)==true
            side = inverse(side)
            putmarkers!(r,side)
        end
    end  
    putmarkers_last!(r,Ost)
    moves!(r, West)
    moves!(r, Sud)
    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor)
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps # символ "_" заменяет фактически не используемую переменную
        move!(r,side)
    end
end

function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        putmarker!(r) 
        move!(r,side)
    end
    putmarker!(r)
    move!(r,Nord)
end

function putmarkers_last!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        putmarker!(r) 
        move!(r,side)
    end
    putmarker!(r)
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))
