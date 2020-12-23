#=
Подсчитать число и вертикальных и горизонтальных прямолинейных перегородок (прямоугольных - нет)
=#
function num_borders(r::Robot)
    side = Nord
    num=0
    while isborder(r,Ost)==false
        while isborder(r,side)==false
            if pass_the_borders(r,side) == true
                num += 1
                walk_by(r,side)
            end
        end
        move!(r,Ost)
        side = inverse(side)
    end
    return num
end

function pass_the_borders(r::Robot,side::HorizonSide) 
    while isborder(r,Ost)==false 
        if isborder(r,side) == true
            return false
        end
        move!(r,side) 
    end
    return true
end

walk_by(r::Robot,side::HorizonSide) = while isborder(r,Ost)==true move!(r,side) end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))