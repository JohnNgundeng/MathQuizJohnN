-- Title: LivesandTimers
-- Name: John Ngundneg
-- Course: ICS2O
-- This program this program displays a math question
-- and asks the user to answer in a numeric text field terminal.
------------------------------------------------------------------------
----hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background", 130/255, 20/255, 220/255)
-------------------------------------------------------------------------
--LOCAL VARIABLES
-------------------------------------------------------------------------

--create local variables
local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local randomNumber3
local randomNumber4
local userAnswer
local correctAnswer
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer
local lives = 5
local heart1
local heart2
local heart3
local heart4
local points = 0
local pointsObject
local randomOperator
local gameOver
local areaText 
local Sound1 = audio.loadSound("sounds/yeah.mp3") 
local Sound2 = audio.loadSound("sounds/Morty.mp3")
local morty
local yeah

------------------------------------------------------------------------
--LOCAL FUNCTIONS
------------------------------------------------------------------------

local function AskQuestion()
	-- generate 2 random numbers  between a max. and a min. number
	randomNumber1 = math.random(0,20)
	randomNumber2 = math.random(0,20)
	randomNumber3 = math.random(0,10)
	randomNumber4 = math.random(0,10)
	randomOperator = math.random(1,4)

	-- subtraction 
	if (randomOperator == 1) then
		correctAnswer = randomNumber1 - randomNumber2
		questionObject.text = randomNumber1 .. " - " ..  randomNumber2 .. " = "


		if (correctAnswer < 0) then 
			questionObject.text = randomNumber2 .. " - " ..  randomNumber1 .. " = "
			correctAnswer = randomNumber2 - randomNumber1
		end

		-- multiplication
	elseif (randomOperator == 2) then  
		correctAnswer = randomNumber3 * randomNumber4
		questionObject.text = randomNumber3 .. " x " ..  randomNumber4 .. " = "
	


		-- addition 
	elseif (randomOperator == 3) then
		correctAnswer = randomNumber1 + randomNumber2
		questionObject.text = randomNumber1 .. " + " ..  randomNumber2 .. " = "

	elseif (randomOperator == 4) then
		correctAnswer = randomNumber3 * randomNumber4 
		randomNumber3 = correctAnswer
		correctAnswer = randomNumber3 / randomNumber4
		questionObject.text = randomNumber3 .. " / " .. randomNumber4 .. " = "  
	end
end

 
local function UpdateTime()
	
	--decrement the number of seconds	
	secondsLeft = secondsLeft - 1

	--display the number of seconds left in the clock object
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0) then
		--reset the number of seconds
		secondsLeft = totalSeconds
		lives = lives -1
		AskQuestion()

		if (lives == 4) then
			heart1.isVisible = true
			heart2.isVisible = true
			heart3.isVisible = true
			heart4.isVisible = true

		elseif (lives == 3) then
			heart1.isVisible = true
			heart2.isVisible = true
			heart3.isVisible = true
			heart4.isVisible = false
		
		elseif (lives == 2) then
			heart1.isVisible = true
			heart2.isVisible = true
			heart3.isVisible = false
			heart4.isVisible = false
		
		elseif (lives == 1) then
			heart1.isVisible = true
			heart2.isVisible = false
			heart3.isVisible = false
			heart4.isVisible = false
		
		elseif (lives == 0) then
			heart1.isVisible = false
			heart2.isVisible = false
			heart3.isVisible = false
			heart4.isVisible = false
			morty = audio.play(Sound2)
			gameOver.isVisible = true
			numericField.isVisible = false
			clockText.isVisible = false
			pointsObject.isVisible = false
			questionObject.isVisible = false
			areaText.isVisible = false
		end
	end
end

local function StartTimer()
	-- create a countdown timer that loops indefinetly
	countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
end

local function HideCorrect()
 	correctObject.isVisible = false
 	AskQuestion()
 end

local function HideIncorrect()
 	incorrectObject.isVisible = false
	AskQuestion()
 end


local function NumericFieldListener( event )
 	
 	--User begins editing "numericField"
 	if ( event.phase == "began" ) then


 	elseif ( event.phase == "submitted" ) then

 		--when the answer is submitted (enter key is pressed) set user,
 		-- input to user's answer
 		userAnswer = tonumber(event.target.text)

 		--if the user's answer and the correct answer are the same:
 		if (userAnswer == correctAnswer) then
 			correctObject.isVisible = true
 			timer.performWithDelay(2200, HideCorrect)
 			event.target.text = ""
 			points = points + 1
 			pointsObject.text = points 
 			yeah = audio.play(Sound1)

 		elseif (userAnswer ~= correctAnswer) then
 			lives = lives -1
 			incorrectObject.isVisible = true
 			timer.performWithDelay(2200, HideIncorrect)
 			event.target.text = ""

			if (lives == 4) then
				heart1.isVisible = true
				heart2.isVisible = true
				heart3.isVisible = true
				heart4.isVisible = false
			elseif (lives == 3) then
				heart1.isVisible = true
				heart2.isVisible = true
				heart3.isVisible = false
				heart4.isVisible = false
			elseif (lives == 2) then
				heart1.isVisible = true
				heart2.isVisible = false
				heart3.isVisible = false
				heart4.isVisible = false
			elseif (lives == 1) then
				heart1.isVisible = false
				heart2.isVisible = false
				heart3.isVisible = false
				heart4.isVisible = false
			elseif (lives == 0) then
				heart1.isVisible = false
				heart2.isVisible = false
				heart3.isVisible = false
				heart4.isVisible = false
				morty = audio.play(Sound2)
				gameOver.isVisible = true
				numericField.isVisible = false
				clockText.isVisible = false
				pointsObject.isVisible = false
				questionObject.isVisible = false
				areaText.isVisible = false
			end
  		end
 	end
end

------------------------------------------------------------------------------------------------------------------------------------
--OBJECT CREATION
------------------------------------------------------------------------------------------------------------------------------------
--create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7/8
heart1.y = display.contentHeight * 1/7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6/8
heart2.y = display.contentHeight * 1/7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5/8
heart3.y = display.contentHeight * 1/7

heart4 = display.newImageRect("Images/heart.png", 100, 100)
heart4.x = display.contentWidth * 4/8
heart4.y = display.contentHeight * 1/7

--create the gameover screen
gameOver = display.newImageRect("Images/gameOver.png", 1100, 1100)
gameOver.x = 500
gameOver.y = 400
gameOver.isVisible = false

--create the clock object
clockText = display.newText("", 100, 100, Arial, 55)
clockText:setTextColor(1, 0, 0)

--displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/3, nil, 55)
questionObject:setTextColor(130/255, 210/255, 198/255)

--Create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/1.9, display.contentHeight/2, Georgia, 60)
correctObject:setTextColor(0/255, 150/255, 255/255)
correctObject.isVisible = false

--Create the points text object and make it invisible
pointsObject = display.newText(points, display.contentWidth/1.9, display.contentHeight*2/3, Georgia, 70)
pointsObject:setTextColor(0/255, 255/255, 0/255)
pointsObject.isVisible = true

areaText = display.newText("Points:", display.contentWidth/2.5, display.contentHeight*2/3, Georgia, 70)
areaText:setTextColor(0/255, 255/255, 0/255)

--Create the correct text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/1.9, display.contentHeight/2, Georgia, 60)
incorrectObject:setTextColor(255/255, 0/255, 0/255)
incorrectObject.isVisible = false

--create a numeric field
numericField = native.newTextField( display.contentWidth/1.9, display.contentHeight/3, 170, 80 )
numericField.inputType = "number"

--add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

------------------------------------------------------------------------------------------------------------------------------------
--FUNCTION CALLS
------------------------------------------------------------------------------------------------------------------------------------

--call the function to ask the question
AskQuestion()
UpdateTime()
StartTimer()
