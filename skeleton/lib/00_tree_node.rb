require 'byebug'
class PolyTreeNode
    
    attr_reader :value, :parent, :children
    attr_writer :children

    def initialize(value)
        @value = value
        @children = []
        @parent = nil
    end

    def parent=(newparent)
        
        unless self.parent.nil?
            self.parent.children.delete(self)
        end

        @parent = newparent

        unless newparent == nil
            unless newparent.children.include?(self)
                newparent.children << self
            end
        end

    end




    

    def add_child(child_node)
        child_node.parent = self
        unless self.children.include?(child_node)
            self.children << child_node
        end
    end

    def remove_child(child_node)
        raise "Wrong type" unless self.children.include?(child_node)
        child_node.parent = nil
        self.children.delete(child_node)
    end
    def has_parent?
        self.parent != nil
    end
    def has_child?(node)
        self.children.include?(node)
    end
    def dfs(target)
        return self if self.value == target
        return nil if self.children.empty?
        self.children.each do |node|
            x = node.dfs(target)
            return x unless x.nil?
        end
        nil
    end

    def bfs(target)
        cnt = 0
        queue = [self]
        until queue.empty?
            cur = queue.shift
            cnt += 1
            if cur.value == target
                p cnt
                return cur
            else
                cur.children.each do |i|
                    queue << i
                end
            end
        end
        nil

    end

    def treesize
        return 0 if self.children.size == 0
        cnt = self.children.map do |child|
            child.treesize
        end
        
        self.children.size + cnt.sum
    end
    

    


end