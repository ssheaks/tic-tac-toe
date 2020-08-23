----------------------------------------------
-- create new table to hold the board matrix
----------------------------------------------
local board = {}

----------------------------------------------
-- clear the board table
----------------------------------------------
function clear_board()
  for i = 1, 3 do
    -- new row
    board[i] = {}
    for j = 1, 3 do
      board[i][j] = " "
    end
  end
end

----------------------------------------------
-- display the board table
----------------------------------------------
function display_board()
  local header = {1, 2, 3}
  print("  "..header[1].."   "..header[2].."   "..header[3])
  for i,v in ipairs(board) do
    print(i.."["..v[1].."] ["..v[2].."] ["..v[3].."]")
  end
end

----------------------------------------------
-- is board full
----------------------------------------------
function board_full()
  for i,v in ipairs(board) do
    for j,val in ipairs(v) do
      if val == " " then
        return false
      end
    end
  end
  return true
end

-----------------------------------------------
-- function to check and return the winnner
-----------------------------------------------
function check_winner()
  local result
  -- check diagonals
  if board[1][1] ~= " " then
    if (board[1][1] == board[2][2]) and (board[1][1] == board[3][3]) then
        result = board[1][1]
        return result
    end
  end
  if board[1][3] ~= " " then
    -- check diagonals
    if (board[1][3] == board[2][2]) and (board[1][3] == board[3][1]) then
        result = board[1][3]
        return result
    end
  end
  --check cols
    for i=1, 3 do
      if board[1][i] ~= " " then
        if (board[1][i] == board[2][i]) and (board[1][i] == board[3][i]) then
            result = board[1][i]
            return result
        end
      end
    end
  --check rows
  for i,v in ipairs(board) do
    if v[1] ~= " " then
      if (v[1] == v[2]) and (v[1] == v[3]) then
        result = v[1]
        return result
      end
    end
  end
end

-----------------------------------------------
-- game starts
-----------------------------------------------
local player = "X"
local move = 0
local game_over = false

clear_board()

-- game loop
while not game_over do
  display_board()

  -- assign current player if the move is even or odd
  if move % 2 == 0 then
    player = "X"
  else
    player = "O"
  end

  print("Enter the row you want to place the symbol "..player..": ")
  local row_to_play = io.read("*n")
  print("Enter the col you want to place the symbol "..player..": ")
  local col_to_play = io.read("*n")

  -- assign move to the board
  if board[row_to_play][col_to_play] ~= " " then
    print("This square is already claimed. Please pick a different square")
  else
    board[row_to_play][col_to_play] = player
    move = move + 1
  end
  

  -- check if there is a winner
  local winner = check_winner()
  if winner ~= nil then
    display_board()
    print("Winner is "..winner)
    game_over = true
  elseif board_full() then
    display_board()
    print("Tie")
    game_over = true
  end
end
