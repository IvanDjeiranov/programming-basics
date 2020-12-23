#=
    ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
    РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы
=#
function mark_frame_perimetr!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
    for side in (Nord,Ost,Sud,West)
        while isborder(r,side)==false
            putmarkers!(r,side)
        end
    end
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
    for _ in 1:num_steps 
        move!(r,side)
    end
end

function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
    if isborder(r,side)==true
        putmarker!(r)
    end
end
