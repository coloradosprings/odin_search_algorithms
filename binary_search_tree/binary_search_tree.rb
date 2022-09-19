class Node
    attr_accessor :left,:right,:root
    def initialize(root)
        @root = root
    end
end

class Tree
    attr_accessor :root

    def initialize(array)
        @array = array.uniq.sort
        @root = BuildTree()
           
    end

    def BuildTree(array = @array)
        mid = array.length / 2
        if mid == 0
            if array != []
                root = Node.new(array[mid])
                return root
                nil
            else
                return
            end
        end
        root = Node.new(array[mid])
        left = array[..mid-1]
        right = array[mid+1..]
        root.left = BuildTree(left)
        root.right = BuildTree(right)
       #@@dict[:"#{array[mid]}"] = [root,root.left,root.right]
        return root    

    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.root}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def insert(number,root_number = @root)
        @array.include?(number) ? (puts 'number already in tree';return) : nil
        unless root_number == nil
            if number > root_number.root
                if root_number.right == nil
                    new_node = Node.new(number)
                    root_number.right = new_node
                    new_node.left = nil
                    new_node.right = nil
                    return
                end
                root_number = root_number.right          
            elsif number < root_number.root
                if root_number.left == nil
                    new_node = Node.new(number)
                    root_number.left = new_node
                    new_node.left = nil
                    new_node.right = nil
                    return
                end
                root_number = root_number.left
            end
            insert(number,root_number)
            end
    end

    def delete(number)
        lambda_parent = -> (node) {if @root_parent
                                    if @root_direction == 'left'
                                    @root_parent.left = node
                                    elsif @root_direction == 'right'
                                    @root_parent.right = node
                                    end
                                    else
                                    nil
                                    end
                                    }
        root = @root
        root_parent = nil
        
        until root.root == number
            if root.root < number
                @root_parent = root
                @root_direction = 'right'
                root = root.right
            elsif root. root > number
                @root_parent = root
                @root_direction = 'left'
                root = root.left
            end
        end
        case 
        when (root.left != nil && root.right != nil)
            root_bottomleft = root.left
            root_bottomleft_parent = root
            until root_bottomleft.left == nil
                root_bottomleft_parent = root_bottomleft
                root_bottomleft = root_bottomleft.left
                
            end
            case 
            when root_bottomleft.right != nil
                root_bottomleft_parent.left = root_bottomleft.right
                root.root = root_bottomleft.root
                return
                
            when root_bottomleft.right == nil
                root_bottomleft_parent.left = nil
                root.root = root_bottomleft.root
                return
                
            end
        when root.left == nil && root.right == nil
            lambda_parent.call(nil)
            
        when root.left != nil && root.right == nil
            lambda_parent.call(root.left)
            
        when root.left == nil && root.right == nil    
            right_root = root.right
            until right_root == nil
                insert(root.right)
                right_root = right_root.right
            end
            lambda_parent(nil)
        end   
    end

    def find(number)
        root_number = @root
        until root_number.root == number
            if number > root_number.root
                root_number = root_number.right   
            elsif number < root_number.root
                root_number = root_number.left
                end
            
            root_number == nil ? (puts 'Node wasn\'t found';return) : nil
        
        end 
            return root_number
    end

    def preorder()
        @block_given = block_given?
        @queue = []
        @values = []
        @queue.push(@root)
        @nodes = []
        def add_nodes(root = @root)   

            if root.root != nil
                @values.push(root.root)
                @nodes.push(root)
            end

            if root.left != nil
                add_nodes(root.left)
            end

            if root.right != nil
                add_nodes(root.right)
            end
             
            return root
        end

        if block_given?
            add_nodes()
            until @nodes == []
            yield @nodes.shift
            end
        else
            add_nodes()
            return @values
        end
    end
    
    def inorder()
        @block_given = block_given?
        @queue = []
        @values = []
        @queue.push(@root)
        @nodes = []
        def add_nodes(root = @root)       
                   
            if root.left != nil
                add_nodes(root.left)
            end

            if root.root != nil
                @values.push(root.root)
                @nodes.push(root)
            end

            if root.right != nil
                add_nodes(root.right)
            end
             
            return root
        end

        if block_given?
            add_nodes()
            until @nodes == []
            yield @nodes.shift
            end
        else
            add_nodes()
            return @values
        end
    end

    def postorder()
        @block_given = block_given?
        @queue = []
        @values = []
        @queue.push(@root)
        @nodes = []
        def add_nodes(root = @root)       
                   
            if root.left != nil
                add_nodes(root.left)
            end

            if root.right != nil
                add_nodes(root.right)
            end

            if root.root != nil
                @values.push(root.root)
                @nodes.push(root)
            end
             
            return root
        end

        if block_given?
            add_nodes()
            until @nodes == []
            yield @nodes.shift
            end
        else
            add_nodes()
            return @values
        end
    end

    def level_order()
        @queue = []
        @values = []
        @queue.push(@root)
        @nodes = []

        def add_nodes()
            @queue == [] ? return : nil
            until @queue == []
                item = @queue.shift        
                if item.left != nil
                    @queue.push(item.left)
                end
                if item.right != nil
                    @queue.push(item.right)
                end
                if item.root != nil
                    @values.push(item.root)
                    @nodes.push(item)
                end
                
            end
        end
        if block_given?
            add_nodes()
            until @nodes == []
            yield @nodes.shift
            end
        else
            add_nodes()
            return @values
        end
    end

    def height(node)
        @node = node
        @lengths = []
        def get_rootes(node = @node,height = 0)
            if !(node.left.nil?)
                height += 1
                get_rootes(node.left,height)
            end
            if !(node.right.nil?)
                height += 1
                get_rootes(node.right,height)
            end
            if node.left.nil?
                @lengths.push(height)
                return
            end
            if node.right.nil?
                @lengths.push(height)
                return
            end
        end
        get_rootes()
        return @lengths.max
    end

    def depth(node)
        number = node.root
        root_number = @root
        @current_depth = 0
        until root_number.root == number
            @current_depth += 1
            if number > root_number.root
                root_number = root_number.right   
            elsif number < root_number.root
                root_number = root_number.left
                end
            
            root_number == nil ? (puts 'Node wasn\'t found';return) : nil
        
        end 
        return @current_depth
    end

    def balanced?()
        @depths = []
        postorder() do |node|  
            (node.is_a? Integer) ? next : nil
            if height(node) == 0 
                depth_value = depth(node)
                @depths.push(depth_value)
            end 
        end
        @is_balanced = true
        @depths.each do |item|
            if @depths.any?{|number| item - number >= 2}
                @is_balanced = false
            end   
            
        end
        return @is_balanced  
        
    end

    def rebalance()
        @array = preorder().sort
        @root = BuildTree(@array)
    end
end

    #array = [7,123,43,21,5,5,6,6,33,33,321,64,43,21,235]
    #tree = Tree.new(array)
    #tree.insert(34)
    #tree.insert(99)
    #tree.pretty_print
    #tree.delete(21)
    #tree.rebalance()
    #tree.pretty_print
    #p tree.preorder(){|node| puts node.root}
    #tree.level_order(){|node| puts "|",node.root}
    #p tree.balanced?()

   

            
            

            

        
        
        