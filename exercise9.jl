#=
    ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер.
    Робот - в произвольной клетке поля.
    РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.
=#

function find_marker(r)
    num_steps_max=1
    side=Nord
    while ismarker(r)==false
        for _ in 1:2
            find_marker(r,side,num_steps_max)
            side=next(side)
        end
        num_steps_max+=1
    end
end

function find_marker(r,side,num_steps_max)
    for _ in 1:num_steps_max
        if ismarker(r)
            return nothing
        end
        move!(r,side)
    end
end

next(side::HorizonSide)=HorizonSide(mod(Int(side)+1,4))