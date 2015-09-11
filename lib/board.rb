class Board

  attr_reader :board, :map, :hits, :misses

  def initialize
    @board = ["A1","A2","A3","A4","A5","A6","A7","A8","A9","A10",
              "B1","B2","B3","B4","B5","B6","B7","B8","B9","B10",
              "C1","C2","C3","C4","C5","C6","C7","C8","C9","C10",
              "D1","D2","D3","D4","D5","D6","D7","D8","D9","D10",
              "E1","E2","E3","E4","E5","E6","E7","E8","E9","E10",
              "F1","F2","F3","F4","F5","F6","F7","F8","F9","F10",
              "G1","G2","G3","G4","G5","G6","G7","G8","G9","G10",
              "H1","H2","H3","H4","H5","H6","H7","H8","H9","H10",
              "I1","I2","I3","I4","I5","I6","I7","I8","I9","I10",
              "J1","J2","J3","J4","J5","J6","J7","J8","J9","J10"]

    @map = [  "A1","A2","A3","A4","A5","A6","A7","A8","A9","A10",
              "B1","B2","B3","B4","B5","B6","B7","B8","B9","B10",
              "C1","C2","C3","C4","C5","C6","C7","C8","C9","C10",
              "D1","D2","D3","D4","D5","D6","D7","D8","D9","D10",
              "E1","E2","E3","E4","E5","E6","E7","E8","E9","E10",
              "F1","F2","F3","F4","F5","F6","F7","F8","F9","F10",
              "G1","G2","G3","G4","G5","G6","G7","G8","G9","G10",
              "H1","H2","H3","H4","H5","H6","H7","H8","H9","H10",
              "I1","I2","I3","I4","I5","I6","I7","I8","I9","I10",
              "J1","J2","J3","J4","J5","J6","J7","J8","J9","J10"]

    @hits = []
    @misses = []

  end

  def place(ship, coord, direction)

    overlap_fail(ship.size, coord, direction)
    off_the_board_fail(ship.size, coord, direction)

    i = board.index(coord)
    board[i] = ship
    d = direction[0].downcase
    n = 1

    while n < ship.size
      if d == 'n'
        i -= 10
        board[i] = ship
      elsif d == 's'
        i += 10
        board[i] = ship
      elsif d == 'e'
        i += 1
        board[i] = ship
      elsif d =='w'
        i -= 1
        board[i] = ship
      else
        raise 'Invalid direction'
      end
      n += 1
    end

  end

  def fire(coord)

    duplicate_shot?(coord)

    i = map.index(coord)

    if board[i] != map[i]
      puts "Hit!"
      board[i].hit
      @hits << coord

      winner?

    else
      puts "Miss!"
      @misses << coord
    end

  end

  private

  def winner?
    puts "Congratulations you have won the game!" if board.select{|s| s.kind_of? Ship}.all? {|d| d.health == 0}
  end

  def duplicate_shot?(coord)
    raise "You've already recorded a hit in that location" if hits.include?(coord)
    raise "You've already recorded a miss in that location" if misses.include?(coord)
  end

  def overlap_fail(size, coord, direction)
    i = map.index(coord)
    d = direction[0].downcase
    error_message = "Unable to place ship. Overlapping ships"

    if board[i] != map[i]
     raise error_message
    end

    n = 1
    while n < size
      if d == 'n'
        i -= 10
        raise error_message if board[i] != map[i]
      elsif d == 's'
        i += 10
        raise error_message if board[i] != map[i]
      elsif d == 'e'
        i += 1
        raise error_message if board[i] != map[i]
      elsif d =='w'
        i -= 1
        raise error_message if board[i] != map[i]
      else
        raise 'Invalid direction'
      end
      n += 1
    end

  end

  def off_the_board_fail(size, coord, direction)
    i = map.index(coord)
    d = direction[0].downcase
    error_message = "Unable to place ship. Ship placed off the board"

    if board[i] == nil
     raise error_message
    end

    board_width = 10
    row_number = (i / board_width) + 1
    column_number = (i % board_width) + 1

    if d == 'n'
      raise error_message if row_number - size < 0
    elsif d == 's'
      raise error_message if row_number + size > board_width
    elsif d == 'e'
      raise error_message if column_number + size > board_width
    elsif d =='w'
      raise error_message if column_number - size < 0
    else
      raise 'Invalid direction'
    end
  end

end

