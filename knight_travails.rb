@chess_tupel = []

for i in 0..7
    for k in 0..7
        @chess_tupel.push([i,k])
    end
end

def knight_fields(position)
    next_fields = @chess_tupel.filter{|field| (field[0] - position[0]).abs == 2 && (field[1] - position[1]).abs == 1 || (field[0] - position[0]).abs == 1 && (field[1] - position[1]).abs == 2}
end

def knight_moves(current,next_field)
    depth = 1
    array = knight_fields(current)
    new_array = knight_fields(current)

    until new_array.include?(next_field)
        depth += 1
        new_array = []
        array.each do |item|
            new_array += knight_fields(item)
        end
        array = new_array
        
    end

    @depth = depth
    @current_path = []
    index = -1
    @next_field = next_field
    @path_found = false

    def recursion(item,index)
        @path_found ? return : nil
        index += 1
        @current_path[index] = item
        if index >= @depth 
            if @current_path[@depth] == @next_field
                @path = @current_path
                @path_found = true
                return 
            else
            end
        else
            knight_fields(item).each{|field| recursion(field,index)}
        end
    end

    recursion(current,index)
    puts "It takes #{depth} moves, here's the path"
    @path.each{|field| p field}
    return 
    
end

#the field is 8x8 index starting at 0
knight_moves([8,4],[1,0])
