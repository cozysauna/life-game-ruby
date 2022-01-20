class LifeGame
    ALIVE = 1
    DEAD = 0
    def initialize(h, w)
        @field = []
        @H = h
        @W = w 
        (0...h).each {|i|
            @field[i] = []
            (0...w).each {|j|
                @field[i][j] = rand(ALIVE+1)
            }
        }
    end
    def display
        puts ''
        (0...@H).each{|i|
            (0...@W).each{|j|
                if @field[i][j] == DEAD
                    print "_"
                else
                    print "@"
                end
            }
            puts ''
        }
    end

    def alter
        new_field = []
        (0...@H).each{|i|
            new_field[i] = []
            (0...@W).each{|j|
                cnt_adj_cells = 0
                (-1..1).each{|dx|
                    (-1..1).each{|dy|
                        next if dx == 0 && dy == 0
                        new_i = i + dx 
                        new_j = j + dy 
                        if 0 <= new_i && new_i < @H && 0 <= new_j && new_j < @W
                            cnt_adj_cells += @field[new_i][new_j] 
                        end
                    }
                }
                if cnt_adj_cells <= 1 || cnt_adj_cells >= 4
                    new_field[i][j] = DEAD
                elsif cnt_adj_cells == 3 
                    new_field[i][j] = ALIVE
                else
                    new_field[i][j] = @field[i][j] 
                end
            }
        }
        @field = new_field
    end

    def isDead 
        @field.flatten.inject(:+) == 0
    end

    def start(limit=100)
        (0...limit).each{|turn|
            alter
            display
            if isDead
                print "FINISH"
                print turn 
                break 
            end 
        }
    end
end

env = LifeGame.new(5, 5)
env.start