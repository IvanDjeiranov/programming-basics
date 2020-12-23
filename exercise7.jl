#=
    ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних перегородок)
    РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, 
    и все остальные клетки поля промаркированы в шахматном порядке
=#
function mark_shahmat!(r::Robot)
    j = 1
    side = Ost
    num_vert = moves_end!(r, Sud)
    num_hor = moves_end!(r, West)
    sum = num_hor + num_vert
    i = moves_end!(r,Ost) - 1
    moves!(r,West)
    if sum % 2 == 0
        move_nechet(r,i)
    else 
        move_chet(r,i)
    end
    moves!(r, Sud)
    moves!(r, West)
    moves_end!(r, Nord, num_vert)
    moves_end!(r, Ost, num_hor) 
end

function moves!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
    end
end

function putmark_nechet!(r::Robot,side::HorizonSide,i::Int)
    for k in 0:i
        if k == 0
            putmarker!(r)
            move!(r,side)
        elseif k % 2 == 1
            move!(r,side)
            putmarker!(r)
            k+=1
        else
            move!(r,side)
            k+=1
        end
    end
end

function putmark_chet!(r::Robot,side::HorizonSide,i::Int)
    for k in 0:i 
        if k % 2 == 0
            move!(r,side)
            putmarker!(r)
            k+=1
        else
            move!(r,side)
            k+=1
        end
    end
end


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

function move_nechet(r::Robot,i::Int)
    side = Ost
    while (isborder(r,Nord) == false)
        putmark_nechet!(r,side,i) 
        move!(r,Nord)
        side = inverse(side)
    end
    if (isborder(r,Nord) == true)
        putmark_nechet!(r,side,i) 
    end        
end

function move_chet(r::Robot,i::Int)
    side = Ost
    while (isborder(r,Nord) == false)
        putmark_chet!(r,side,i) 
        move!(r,Nord)
        side = inverse(side)
    end
    while (isborder(r,Nord) == true)
        putmark_chet!(r,side,i)
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))