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

        str0 = 
        
        
    "------
    |    |
    |
    |
    |
    |
    |
    ------------"
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
            attempts += 1
            return 

        else
            counter = 0
            for counter in (0...positionArr.size)
                userArr[positionArr[counter]] = wordArr[positionArr[counter]]
                counter += 1
            end
        end
    end

    





    def gameloop()
        # Welcome message

        # flag to break out of loop
        flag = false
        
        #word selection
        wordArray = word_line(@theWord)
        userArr = under_line(wordArray)
        
        while !flag || @attempts > 7

            stick_figure(@attempts)

            puts "Already used: #{@alreadyUsed.join(", ")}"
            puts userArr.join("")
            puts wordArray.join
            
            positionArr = letter_guess_test(wordArray)


            userLineAlteration(positionArr, userArr, wordArray)
            

            if userArr == wordArray
                flag = true
                break

            end
        end
        
        if flag
            puts "You won"
        else
            puts "You suck"
        
        end
    end


end