require_relative '00_tree_node.rb'


class KnightPathFinder

    attr_accessor  :root_node, :considered_positions

    def initialize (start)
        @considered_positions = [start]
        @root_node = PolyTreeNode.new(start)
        self.build_move_tree(@root_node)
    end

    def build_move_tree(root_node)
        return nil if considered_positions.size == 64
        moves = new_move_positions(root_node.value)
        unless moves.nil? # || moves.empty?

        #     return root_node
        # end

        new_nodes = moves.map do |pos|
            PolyTreeNode.new(pos)
        end
        new_nodes.each do |node|
            root_node.add_child(node)
        end
        # p root_node.children
        new_nodes.each do |node|
            build_move_tree(node)
        end
    end


        # #until @considered_positions.size == 64
        #     moves = new_move_positions(root_node.value)
        #     new_moves = moves.map do |pos|
        #         PolyTreeNode.new(pos)
        #     end
        # #end


            

        # end

        # return nil if moves.empty?
        # node_array = moves.map do |move|
        #     PolyTreeNode.new(move)
        # end
        # node_array.each do |node|
        #     root_node.add_child(node)
        #     build_move_tree(node)
        # end
    end





    def self.valid_moves(pos)
        x, y = pos
        z = [1,2,-1,-2]
        z = z.permutation(2).to_a 
        z = z.select {|i|  i.sum.abs == 1 || i.sum.abs == 3 }
        z.map! {|i| i = [i[0] + x, i[1] + y] }
        z.select {|i| i.all? {|j| j >= 0 && j < 8 } }
    end

    def new_move_positions(pos)
        # considered_positions = []

        x = KnightPathFinder.valid_moves(pos)
        y = x.reject{|i| considered_positions.include?(i)}
        if y.nil? || y.empty? 
            return nil
        end
        considered_positions.concat(y)
        y
        
    end

    











end
a = KnightPathFinder.new([3,3])

