class Hangman

    def initialize

    @wordHash = read_file
    @theWord = random_word
    @attempts = 0
    @alreadyUsed = []



    end

    # Returns hash of words
    def read_file()
        fileName = "words.txt"
        rtnHash = Hash.new()
        inputFile = File.open(fileName, "r")
        counter = 0

        inputFile.each_line do |line|
            rtnHash[counter] = line.chomp
            counter += 1

        end
        inputFile.close

        return rtnHash
    end

    def random_word()

        randomNum = rand(0..@wordHash.count)

        return @wordHash[randomNum]


    end

    # will print stick figure to user
    def stick_figure(mistakeNum)

        
        mistake = [
            """
        ------
        |    |
        |
        |
        |
        |
        |
    ------------
    """, """
        ------
        |    |
        |    O
        |
        |
        |
        |
    ------------
    """, """
        ------
        |    |
        |    O
        |    |
        |    |
        |
        |
    ------------
    """, """
        ------
        |    |
        |    O
        |    |
        |    |
        |   /
        |
    ------------
    """, """
        ------
        |    |
        |    O
        |    |
        |    |
        |   / \\
        |
    ------------
    """, """
        ------
        |    |
        |    O
        |  --|
        |    |
        |   / \\
        |
    ------------
    """, """
        ------
        |    |
        |    O
        |  --|--
        |    |
        |   / \\
        |
    ------------
    """]
        puts mistake[mistakeNum]
    end

    def word_line(randWord)
        rtnHash = Hash.new
        wordLineArr = []
        randWord.each_char do |char| 
            
            wordLineArr << char
        end

        return wordLineArr

    end

    def under_line(wordLineArr)
        underscore_line = []
        for i in (0...wordLineArr.size)
            underscore_line << " _ "
        end
        return underscore_line
    end

    # Will return either an array of indexes or false depending 
    # if the user's guess was in the secret word
    def letter_guess_test(wordArr)
        rtnArray = []
        userChoice = gets.chomp.downcase
        while userChoice.size > 1
            puts("Enter only one character")
            userChoice = gets.chomp.downcase
        end

        @alreadyUsed << userChoice

        wordArr.each_with_index do |char, index|
            if userChoice == char
                rtnArray << index
            end
        end

        if rtnArray.empty?
            return false

        else 
            return rtnArray
        end

    end
        


    def userLineAlteration(positionArr, userArr, wordArr)
        # Error handling to catch the false case. 
        if !positionArr
            @attempts += 1
            return 

        else
            counter = 0
            for counter in (0...positionArr.size)
                userArr[positionArr[counter]] = wordArr[positionArr[counter]]
                counter += 1
            end
        end
    end

    def save_game(userArr, wordArr)
        Dir.mkdir("saved_games") unless Dir.exist?("saved_games")

        #filename = "output/thanks_#{id}.html"
        fname = "saved_games/gamesave.txt"
        outfile = File.open(fname, "w")

        outfile.puts(userArr.join(""))
        outfile.puts(wordArr.join(""))
        outfile.puts(@alreadyUsed.join(""))
        outfile.puts(@attempts)

        outfile.close()

    end

    def welcome_message()
        puts "This is a command line game of hangman"
        puts "You will have to enter letters one at a time"
        puts "before your buddy is completly hung"
        puts "Good luck!"
        
    end

    def startFromSave?()
        puts "Would you like to start from the last saved game? (y or n)"
        choice = gets.chomp
        if choice == "n"
            return false

        else
            return true

        end
    end

    def read_save_file()
        fileName = "saved_games/gamesave.txt"
        rtnHash = Hash.new()
        inputFile = File.open(fileName, "r")
        counter = 0

        inputFile.each_line do |line|
            rtnHash[counter] = line.chomp
            counter += 1

        end
        inputFile.close

        

        return rtnHash
    end

    def save_game_loop(savedHash)
        flag = false
        #user array, word array, attempts, and used letter array 
                # in that order 
            #word selection

            @theWord = savedHash[1]


            wordArray = word_line(@theWord)

            savedHash[2].each_char {|char| @alreadyUsed << char}

            # Creates an array of underscores the same length 
            # as the secret word
            userArr = []
            savedHash[0].each_char{|char| userArr << char}

            @attempts = savedHash[3].to_i()
            flag = false
            
            # while loop that goes until the game is won or
            # if the user exceeds 7 attempts
            while !flag && @attempts < 7

                # Print the man hanging. changes per attempt
                stick_figure(@attempts)

                # Prints the letters the user guessed. 
                # Also prints the user & word arrays for testing 
                puts "Already used: #{@alreadyUsed.join(", ")}"
                puts userArr.join("  ")
                puts wordArray.join
                
                # returns false or an array with the indexes of 
                # the letter the user guessed correctly
                positionArr = letter_guess_test(wordArray)

                # Used to change the user array based on the set of indices that
                # the position array contains 
                userLineAlteration(positionArr, userArr, wordArray)
                
                # Counter 
                

                # Saves the user array, word array, attempts, and used letter array 
                # in that order 
                save_game(userArr, wordArray)

                
                # Tests to see if the user won
                if userArr == wordArray
                    flag = true
                    break
                end
            end
            
            # If flag is true, the user won
            # if not, they suck
            if flag
                puts "You won"
            else
                puts "You suck"
            
            end

        
        end

    def gameloop()
        welcome_message()
        # flag to break out of loop
        
        if !startFromSave?
            flag = false
        
            #word selection
            wordArray = word_line(@theWord)

            # Creates an array of underscores the same length 
            # as the secret word
            userArr = under_line(wordArray)
            
            # while loop that goes until the game is won or
            # if the user exceeds 7 attempts
            while !flag && @attempts < 7

                # Print the man hanging. changes per attempt
                stick_figure(@attempts)

                # Prints the letters the user guessed. 
                # Also prints the user & word arrays for testing 
                puts "Already used: #{@alreadyUsed.join(", ")}"
                puts userArr.join("  ")
                puts wordArray.join
                
                # returns false or an array with the indexes of 
                # the letter the user guessed correctly
                positionArr = letter_guess_test(wordArray)

                # Used to change the user array based on the set of indices that
                # the position array contains 
                userLineAlteration(positionArr, userArr, wordArray)
                
                # Counter 
                

                # Saves the user array, word array, attempts, and used letter array 
                # in that order 
                save_game(userArr, wordArray)

                
                # Tests to see if the user won
                if userArr == wordArray
                    flag = true
                    break
                end
            end
            
            # If flag is true, the user won
            # if not, they suck
            if flag
                puts "You won"
            else
                puts "You suck"
            
            end

        else
            save_game_loop(read_save_file())
            




        end
        
        
    end


end