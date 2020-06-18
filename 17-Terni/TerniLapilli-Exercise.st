!classDefinition: #'Tests-TerniLapilli' category: #'TerniLapilli-Exercise'!
TestCase subclass: #'Tests-TerniLapilli'
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 18:02:15'!
test01PlayerXShouldMoveFirst

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: terniLapilliGame isPlayingX equals: true.
	self assert: terniLapilliGame isPlayingO equals: false.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 18:11:08'!
test02NewGameIsNotOver

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: terniLapilliGame isOver equals: false.
	self assert: terniLapilliGame isTied equals: false.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 18:26:31'!
test03PlayerCanNotPlacePieceOutsideTheBoard

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	self should: [terniLapilliGame putXAt: -1@1]
		raise: Error
		withMessageText: terniLapilliGame class invalidPositionErrorDescription.

	self should: [terniLapilliGame putXAt: 1@4]
		raise: Error
		withMessageText: terniLapilliGame class invalidPositionErrorDescription.

	self should: [terniLapilliGame putXAt: 1@-1]
		raise: Error
		withMessageText: terniLapilliGame class invalidPositionErrorDescription.

	self should: [terniLapilliGame putXAt: 4@1]
		raise: Error
		withMessageText: terniLapilliGame class invalidPositionErrorDescription.
! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 18:35:01'!
test04NoPlayerWonTheNewGame

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	self assert: terniLapilliGame hasPlayerOWon equals: false.
	self assert: terniLapilliGame hasPlayerXWon equals: false.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 21:15:28'!
test05PlayerCanNotPlaceMoreThanThreePieces

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 2@2.
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 1@3.
	terniLapilliGame putXAt: 3@1.
	terniLapilliGame putOAt: 3@3.
	
	self should: [terniLapilliGame putXAt: 2@3]
		raise: Error
		withMessageText: terniLapilliGame class OnlyThreePiecesPerPlayerAllowedErrorDescription.
		
	self should: [terniLapilliGame putOAt: 2@1]
		raise: Error
		withMessageText: terniLapilliGame class OnlyThreePiecesPerPlayerAllowedErrorDescription.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:21:39'!
test06PlayerCanNotPlaceAPieceOnAnOccupiedPosition

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self should: [terniLapilliGame putOAt: 1@1]
		raise: Error
		withMessageText: terniLapilliGame class PositionUnavailableErrorDescription.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 20:35:07'!
test07PlayersShouldAlternateToPutPieces

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	
	self assert: terniLapilliGame isPlayingO equals: true.
	
	self should: [terniLapilliGame putXAt: 1@2]
		raise: Error
		withMessageText: terniLapilliGame class WrongPlayerErrorDescription.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 19:33:33'!
test08CanNotMoveUntilAllPiecesArePlaced

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 2@2.
	
	self should: [terniLapilliGame moveXFrom: 1@1 to: 1@2]
		raise: Error
		withMessageText: terniLapilliGame class NotAllPiecesPlacedErrorDescription.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 19:45:20'!
test09PlayerCanNotMoveAPieceToAnOccupiedPosition

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 2@2.
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 1@3.
	terniLapilliGame putXAt: 3@1.
	terniLapilliGame putOAt: 3@3.
	
	self should: [terniLapilliGame moveXFrom: 1@1 to: 1@2]
		raise: Error
		withMessageText: terniLapilliGame class PositionUnavailableErrorDescription.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 19:57:03'!
test10PlayerCanOnlyMoveAPieceFromAPositionOccupiedByThemselves

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 2@2.
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 1@3.
	terniLapilliGame putXAt: 3@1.
	terniLapilliGame putOAt: 3@3.
	
	self should: [terniLapilliGame moveXFrom: 2@2 to: 2@3]
		raise: Error
		withMessageText: terniLapilliGame class invalidMoveErrorDescription.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 20:02:18'!
test11PlayerCanNotMoveAPieceOutsideTheBoard

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 2@2.
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 1@3.
	terniLapilliGame putXAt: 3@1.
	terniLapilliGame putOAt: 3@3.
	
	self should: [terniLapilliGame moveXFrom: 3@1 to: 4@1]
		raise: Error
		withMessageText: terniLapilliGame class invalidPositionErrorDescription.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 20:12:08'!
test11PlayerCanOnlyMoveToANearPosition

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 2@2.
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 1@3.
	terniLapilliGame putXAt: 3@1.
	terniLapilliGame putOAt: 3@3.
	
	self should: [terniLapilliGame moveXFrom: 3@1 to: 2@3]
		raise: Error
		withMessageText: terniLapilliGame class invalidMoveErrorDescription.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 20:36:42'!
test12PlayersShouldAlternateToMovePieces

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 2@2.
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 1@3.
	terniLapilliGame putXAt: 3@1.
	terniLapilliGame putOAt: 3@3.
	
	self assert: terniLapilliGame isPlayingX equals: true.
	
	self should: [terniLapilliGame moveOFrom: 3@3 to: 2@3]
		raise: Error
		withMessageText: terniLapilliGame class WrongPlayerErrorDescription.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 21:07:52'!
test13

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 2@2.
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 2@3.
	terniLapilliGame putXAt: 1@3.
	
	self assert: terniLapilliGame isOver equals: true.
	self assert: terniLapilliGame hasPlayerXWon equals: true.! !

!Tests-TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 21:16:32'!
test14

	| terniLapilliGame |
	
	terniLapilliGame := TerniLapilliGame new.
	
	terniLapilliGame putXAt: 1@1.
	terniLapilliGame putOAt: 2@2.
	terniLapilliGame putXAt: 1@2.
	terniLapilliGame putOAt: 2@3.
	terniLapilliGame putXAt: 1@3.
	
	self assert: terniLapilliGame isOver equals: true.
	self assert: terniLapilliGame hasPlayerXWon equals: true.
	
	self should: [terniLapilliGame putOAt: 3@1]
		raise: Error
		withMessageText: terniLapilliGame class gameOverErrorDescription.! !


!classDefinition: #MovementManager category: #'TerniLapilli-Exercise'!
Object subclass: #MovementManager
	instanceVariableNames: 'game player'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!MovementManager methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:54:01'!
checkForInvalidPosition: aPosition

	aPosition x < 1 ifTrue: [game signalInvalidPositionError].
	aPosition x > 3 ifTrue: [game signalInvalidPositionError].
	aPosition y < 1 ifTrue: [game signalInvalidPositionError].
	aPosition y > 3 ifTrue: [game signalInvalidPositionError].! !

!MovementManager methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:24:09'!
move

	^self subclassResponsibility! !


!classDefinition: #MovementManagerMove category: #'TerniLapilli-Exercise'!
MovementManager subclass: #MovementManagerMove
	instanceVariableNames: 'startPosition endPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!MovementManagerMove methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:58:03'!
checkIfNeighbours

((startPosition x - endPosition x) abs = 1 and: [startPosition y = endPosition y]) ifTrue: [^true].
	((startPosition y - endPosition y) abs = 1 and: [startPosition x = endPosition x]) ifTrue: [^true].
	((startPosition x - endPosition x) abs = 1 and: 
		[(startPosition y - endPosition y) abs = 1 and: 
			[startPosition x - endPosition x = startPosition y - endPosition y and:
			[(startPosition x + endPosition y) = 4 or: [startPosition x = endPosition y]]]]) ifTrue: [^true].
	
	^game signalInvalidMoveError! !

!MovementManagerMove methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:33:19'!
initializeIn: aGame with: aPlayer from: aStartingPosition to: anEndingPosition

	game := aGame.
	
	player := aPlayer.
	
	startPosition := aStartingPosition.
	
	endPosition := anEndingPosition.! !

!MovementManagerMove methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:57:29'!
move

	self checkForInvalidPosition: startPosition.
	
	self checkForInvalidPosition: endPosition.
	
	self checkIfNeighbours.
	
	game removePosition: startPosition with: player.
	
	game updatePosition: endPosition with: player.
	
	game updatePlayers. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MovementManagerMove class' category: #'TerniLapilli-Exercise'!
MovementManagerMove class
	instanceVariableNames: ''!

!MovementManagerMove class methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:32:13'!
in: aGame with: aPlayer from: aStartingPosition to: anEndingPosition

	^self new initializeIn: aGame with: aPlayer from: aStartingPosition to: anEndingPosition! !


!classDefinition: #MovementManagerPut category: #'TerniLapilli-Exercise'!
MovementManager subclass: #MovementManagerPut
	instanceVariableNames: 'endPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!MovementManagerPut methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:55:22'!
initializeIn: aGame with: aPlayer at: aPosition

	game := aGame.

	player := aPlayer.
	
	endPosition := aPosition.! !

!MovementManagerPut methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:33:39'!
move

	self checkForInvalidPosition: endPosition.
	
	game updatePosition: endPosition with: player.
	
	game updatePlayers.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MovementManagerPut class' category: #'TerniLapilli-Exercise'!
MovementManagerPut class
	instanceVariableNames: ''!

!MovementManagerPut class methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:55:56'!
in: aGame with: aPlayer at: aPosition

	^self new initializeIn: aGame with: aPlayer at: aPosition! !


!classDefinition: #TerniLapilliGame category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliGame
	instanceVariableNames: 'board winner state playerX playerO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:20:39'!
changeToMoveState

	state := TerniLapilliGameStateMoveStage of: self.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:49:21'!
clean: aPosition

	board i: aPosition x j: aPosition y put: (TerniLapilliEmptyPosition at: self with: aPosition)! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:23:20'!
getOPositions

	| OPositions |
	
	OPositions := OrderedCollection new.
	board withIndexesDo: [:i :j :aPosition | aPosition isO ifTrue: [OPositions add: i@j]].
	
	^OPositions.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:44:40'!
getPosition: aPosition
	
	^board i: aPosition x j: aPosition y.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:38:01'!
getXPositions

	| XPositions |
	
	XPositions := OrderedCollection new.
	board withIndexesDo: [:i :j :aPosition | aPosition isX ifTrue: [XPositions add: i@j]].
	
	^XPositions.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:50:41'!
hasPlayerOWon

	^winner = playerO.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:50:48'!
hasPlayerXWon

	^winner = playerX.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:01:43'!
initialize

	| height width |
	
	height := 3.
	width := 3.
	
	board := Array2D height: height width: width.
	
	board replaceValues: [ :i :j :value | TerniLapilliEmptyPosition at: self with: i@j].
	
	playerX := TerniLapilliXPlayer at: self withState: TerniLapilliPlayerStateActive new.
	
	playerO := TerniLapilliOPlayer at: self withState: TerniLapilliPlayerStateInactive new.
	
	state := TerniLapilliGameStatePutStage of: self.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:50:54'!
isOver
	
	^state isOver! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:50:19'!
isPlayingO
	
	^playerO isActive! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:49:12'!
isPlayingX
	
	^playerX isActive! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 18:11:34'!
isTied
	
	^false! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:15:44'!
leftDiagonal: aListOfPositions
	
	^(((aListOfPositions at: 1) x + (aListOfPositions at: 1) y) = 4 and: [((aListOfPositions at: 2) x + (aListOfPositions at: 2) y) = 4 and: [((aListOfPositions at: 3) x + (aListOfPositions at: 3) y) = 4]])! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:30:42'!
manageMove: aPlayer from: aPosition to: anotherPosition

	| manager |
	
	manager := MovementManagerMove in: self with: aPlayer from: aPosition to: anotherPosition.
	
	manager move.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:56:41'!
managePut: aPlayer at: aPosition

	| manager |
	
	manager := MovementManagerPut in: self with: aPlayer at: aPosition.
	
	manager move.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:26:43'!
move: aPlayer from: aStartingPosition to: anEndingPosition

	aPlayer movePieceFrom: aStartingPosition to: anEndingPosition! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:59:51'!
moveOFrom: aPosition to: anotherPosition

	state move: playerO from: aPosition to: aPosition.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:43:37'!
moveXFrom: aPosition to: anotherPosition

	state move: playerX from: aPosition to: anotherPosition.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:14:51'!
put: aPlayer at: aPosition

	aPlayer putPieceAt: aPosition! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 17:00:46'!
putOAt: aPosition

	state put: playerO at: aPosition! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 17:00:50'!
putXAt: aPosition

	state put: playerX at: aPosition.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:35:37'!
removePosition: aPosition with: aPlayer

	(self getPosition: aPosition) removeFrom: aPlayer! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:15:36'!
rightDiagonal: aListOfPositions
	
	^((aListOfPositions at: 1) x = (aListOfPositions at: 1) y and: [(aListOfPositions at: 2) x = (aListOfPositions at: 2) y and: [(aListOfPositions at: 3) x = (aListOfPositions at: 3) y]])! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:47:27'!
safePut: aPlayer at: aPosition

	board i: aPosition x j: aPosition y put: (aPlayer getPosition: aPosition at: self)! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:15:31'!
sameColumn: aListOfPositions
	
	^((aListOfPositions  at: 1) y = (aListOfPositions at: 2) y and: [(aListOfPositions at: 2) y = (aListOfPositions at: 3) y])! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:15:25'!
sameRow: aListOfPositions
	
	^((aListOfPositions  at: 1) x = (aListOfPositions at: 2) x and: [(aListOfPositions at: 2) x = (aListOfPositions at: 3) x])! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:36:39'!
setWinnerO

	winner := playerO.
	
	state := TerniLapilliGameStateOver new.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:52:28'!
setWinnerX

	winner := playerX.
	
	state := TerniLapilliGameStateOver of: self.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 21:12:22'!
signalGameOverError

	self error: self class gameOverErrorDescription! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 19:58:15'!
signalInvalidMoveError

	self error: self class invalidMoveErrorDescription! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 18:31:12'!
signalInvalidPositionError

	self error: self class invalidPositionErrorDescription! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 19:37:27'!
signalNotAllPiecesPlacedError

	self error: self class NotAllPiecesPlacedErrorDescription ! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 21:11:25'!
signalOnlyThreePiecesPerPlayerAllowedError

	self error: self class OnlyThreePiecesPerPlayerAllowedErrorDescription.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/17/2020 19:10:36'!
signalPositionUnavailableError

	self error: self class PositionUnavailableErrorDescription.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:17:49'!
signalWrongPlayerError

	self error: self class WrongPlayerErrorDescription.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:12:10'!
updatePlayers
	
	self updateWinner.

	playerX update.
	
	playerO update.
	
	! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:43:52'!
updatePosition: aPosition with: aPlayer

	(self getPosition: aPosition) updateWith: aPlayer.! !

!TerniLapilliGame methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:09:45'!
updateWinner

	playerX checkIfWinner.
	
	playerO checkIfWinner.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGame class' category: #'TerniLapilli-Exercise'!
TerniLapilliGame class
	instanceVariableNames: ''!

!TerniLapilliGame class methodsFor: 'error handling' stamp: 'FML 6/17/2020 19:34:24'!
NotAllPiecesPlacedErrorDescription
	
	^'Not all pieces are placed yet'! !

!TerniLapilliGame class methodsFor: 'error handling' stamp: 'FML 6/17/2020 18:43:37'!
OnlyThreePiecesPerPlayerAllowedErrorDescription
	
	^'Only Three Pieces Per Player Allowed'! !

!TerniLapilliGame class methodsFor: 'error handling' stamp: 'FML 6/17/2020 19:11:13'!
PositionUnavailableErrorDescription
	
	^'Position Unavailable'! !

!TerniLapilliGame class methodsFor: 'error handling' stamp: 'FML 6/18/2020 16:18:09'!
WrongPlayerErrorDescription

	^'Wrong Player'! !

!TerniLapilliGame class methodsFor: 'error handling' stamp: 'FML 6/17/2020 21:12:38'!
gameOverErrorDescription
	
	^'Game Over'! !

!TerniLapilliGame class methodsFor: 'error handling' stamp: 'FML 6/17/2020 19:56:45'!
invalidMoveErrorDescription
	
	^'Invalid Move'! !

!TerniLapilliGame class methodsFor: 'error handling' stamp: 'FML 6/17/2020 18:27:13'!
invalidPositionErrorDescription
	
	^'Invalid Position'! !

!TerniLapilliGame class methodsFor: 'error handling' stamp: 'FML 6/17/2020 18:49:15'!
newGame

	self new initialize! !


!classDefinition: #TerniLapilliGameState category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliGameState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliGameState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:42:24'!
initializeWith: aGame

	game := aGame.! !

!TerniLapilliGameState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:51:08'!
isOver

	^self subclassResponsibility! !

!TerniLapilliGameState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:24:10'!
move: aPlayer from: aPosition to: anotherPosition

	^self subclassResponsibility ! !

!TerniLapilliGameState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:13:47'!
put: aPlayer at: aPosition

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameState class' category: #'TerniLapilli-Exercise'!
TerniLapilliGameState class
	instanceVariableNames: ''!

!TerniLapilliGameState class methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:42:09'!
of: aGame

	^self new initializeWith: aGame! !


!classDefinition: #TerniLapilliGameStateMoveStage category: #'TerniLapilli-Exercise'!
TerniLapilliGameState subclass: #TerniLapilliGameStateMoveStage
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliGameStateMoveStage methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:51:15'!
isOver

	^false! !

!TerniLapilliGameStateMoveStage methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:26:02'!
move: aPlayer from: aPosition to: anotherPosition

	game move: aPlayer from: aPosition to: anotherPosition! !

!TerniLapilliGameStateMoveStage methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:13:15'!
put: aPlayer at: aPosition

	game signalOnlyThreePiecesPerPlayerAllowedError! !


!classDefinition: #TerniLapilliGameStateOver category: #'TerniLapilli-Exercise'!
TerniLapilliGameState subclass: #TerniLapilliGameStateOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliGameStateOver methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:51:22'!
isOver

	^true! !

!TerniLapilliGameStateOver methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:24:36'!
move: aPlayer from: aPosition to: anotherPosition

	game signalGameOverError! !

!TerniLapilliGameStateOver methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:13:07'!
put: aPlayer at: aPosition

	game signalGameOverError! !


!classDefinition: #TerniLapilliGameStatePutStage category: #'TerniLapilli-Exercise'!
TerniLapilliGameState subclass: #TerniLapilliGameStatePutStage
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliGameStatePutStage methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:51:29'!
isOver

	^false! !

!TerniLapilliGameStatePutStage methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:25:15'!
move: aPlayer from: aPosition to: aontherPosition

	game signalNotAllPiecesPlacedError! !

!TerniLapilliGameStatePutStage methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:12:29'!
put: aPlayer at: aPosition

	game put: aPlayer at: aPosition! !


!classDefinition: #TerniLapilliPlayer category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliPlayer
	instanceVariableNames: 'state game pieces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:11:00'!
checkIfWinner

	state checkIfWinner: self.! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:03:25'!
initializeAt: aGame with: aState

	game := aGame.
	
	state := aState with: self.
	
	pieces := 0.! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:49:30'!
isActive

	^state isActive! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:29:51'!
manageMoveFrom: aPosition to: anotherPosition

	game manageMove: self from: aPosition to: anotherPosition! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:20:42'!
managePutAt: aPosition

	game managePut: self at: aPosition! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:27:25'!
movePieceFrom: aPosition to: anotherPosition

	state movePieceFrom: aPosition to: anotherPosition.! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:15:58'!
putPieceAt: aPosition

	state putPieceAt: aPosition! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:38:23'!
removeFromOPosition

	^self subclassResponsibility! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:38:18'!
removeFromXPosition

	^self subclassResponsibility! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:29:44'!
safeCheckIfWinner

	^self subclassResponsibility! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:19:13'!
signalWrongPlayerError

	game signalWrongPlayerError ! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:59:57'!
update

	state updateCount: self.
	
	state := state getNext.! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:01:41'!
updateCount

	^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayer class' category: #'TerniLapilli-Exercise'!
TerniLapilliPlayer class
	instanceVariableNames: ''!

!TerniLapilliPlayer class methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:45:49'!
at: aGame withState: aState.

	^self new initializeAt: aGame with: aState.! !


!classDefinition: #TerniLapilliOPlayer category: #'TerniLapilli-Exercise'!
TerniLapilliPlayer subclass: #TerniLapilliOPlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliOPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:14:30'!
getPosition: aPosition at: aGame

	^TerniLapilliOPosition at: aGame with: aPosition.! !

!TerniLapilliOPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:40:39'!
removeFromOPosition: aPosition

	game clean: aPosition

	! !

!TerniLapilliOPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:54:09'!
removeFromXPosition: aPosition

	game signalInvalidMoveError! !

!TerniLapilliOPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:35:39'!
safeCheckIfWinner

	| positions |

	positions := game getOPositions.
	
	positions size < 3 ifTrue: [^self].
	
	((game sameRow: positions) or:
	[(game sameColumn: positions) or:
	[(game rightDiagonal: positions) or:
	[game leftDiagonal: positions]	
	]
	]) ifTrue: [game setWinnerO]! !

!TerniLapilliOPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:02:32'!
updateCount

	pieces := pieces + 1.
	
	pieces = 3 ifTrue: [game changeToMoveState]! !


!classDefinition: #TerniLapilliXPlayer category: #'TerniLapilli-Exercise'!
TerniLapilliPlayer subclass: #TerniLapilliXPlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliXPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:02:45'!
getPosition: aPosition at: aGame

	^TerniLapilliXPosition at: aGame with: aPosition! !

!TerniLapilliXPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:41:41'!
removeFromOPosition: aPosition

	game signalInvalidMoveError ! !

!TerniLapilliXPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:41:25'!
removeFromXPosition: aPosition

	game clean: aPosition ! !

!TerniLapilliXPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:37:09'!
safeCheckIfWinner

	| positions |

	positions := game getXPositions.
	
	positions size < 3 ifTrue: [^self].
	
	((game sameRow: positions) or:
	[(game sameColumn: positions) or:
	[(game rightDiagonal: positions) or:
	[game leftDiagonal: positions]	
	]
	]) ifTrue: [game setWinnerX]! !

!TerniLapilliXPlayer methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:01:58'!
updateCount

	pieces := pieces + 1! !


!classDefinition: #TerniLapilliPlayerState category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliPlayerState
	instanceVariableNames: 'player'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPlayerState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:11:22'!
checkIfWinner: aPlayer

	^self subclassResponsibility! !

!TerniLapilliPlayerState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:04:15'!
getNext

	^self subclassResponsibility! !

!TerniLapilliPlayerState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:49:41'!
isActive

	^self subclassResponsibility! !

!TerniLapilliPlayerState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:28:07'!
movePieceFrom: aPosition to: anotherPosition

	^self subclassResponsibility! !

!TerniLapilliPlayerState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:16:16'!
putPieceAt: aPosition

	^self subclassResponsibility! !

!TerniLapilliPlayerState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:00:23'!
updateCount: aPlayer

	^self subclassResponsibility! !

!TerniLapilliPlayerState methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:46:43'!
with: aPlayer

	player := aPlayer ! !


!classDefinition: #TerniLapilliPlayerStateActive category: #'TerniLapilli-Exercise'!
TerniLapilliPlayerState subclass: #TerniLapilliPlayerStateActive
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPlayerStateActive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:12:37'!
checkIfWinner: aPlayer

	aPlayer safeCheckIfWinner.! !

!TerniLapilliPlayerStateActive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:13:24'!
getNext

	^TerniLapilliPlayerStateInactive new with: player.! !

!TerniLapilliPlayerStateActive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:49:53'!
isActive

	^true! !

!TerniLapilliPlayerStateActive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:29:14'!
movePieceFrom: aPosition to: anotherPosition

	player manageMoveFrom: aPosition to: anotherPosition! !

!TerniLapilliPlayerStateActive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:20:15'!
putPieceAt: aPosition

	player managePutAt: aPosition! !

!TerniLapilliPlayerStateActive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:00:59'!
updateCount: aPlayer

	aPlayer updateCount.! !


!classDefinition: #TerniLapilliPlayerStateInactive category: #'TerniLapilli-Exercise'!
TerniLapilliPlayerState subclass: #TerniLapilliPlayerStateInactive
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPlayerStateInactive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:12:53'!
checkIfWinner: aPlayer

	^self! !

!TerniLapilliPlayerStateInactive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:13:43'!
getNext

	^TerniLapilliPlayerStateActive new with: player.! !

!TerniLapilliPlayerStateInactive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:50:03'!
isActive

	^false! !

!TerniLapilliPlayerStateInactive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:28:39'!
movePieceFrom: aPosition to: anotherPosition

	player signalWrongPlayerError! !

!TerniLapilliPlayerStateInactive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:17:05'!
putPieceAt: aPosition

	player signalWrongPlayerError! !

!TerniLapilliPlayerStateInactive methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:00:37'!
updateCount: aPlayer

	^self! !


!classDefinition: #TerniLapilliPosition category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliPosition
	instanceVariableNames: 'game position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:47:34'!
getPosition

	^position! !

!TerniLapilliPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:01:28'!
initializeAt: aGame with: aPosition

	game := aGame.
	
	position := aPosition.! !

!TerniLapilliPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:30:24'!
isO

	^self subclassResponsibility! !

!TerniLapilliPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:38:12'!
isX

	^self subclassResponsibility! !

!TerniLapilliPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:35:55'!
removeFrom: aPlayer

	^self subclassResponsibility! !

!TerniLapilliPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:38:20'!
updateWith: aPlayer

	^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPosition class' category: #'TerniLapilli-Exercise'!
TerniLapilliPosition class
	instanceVariableNames: ''!

!TerniLapilliPosition class methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:00:59'!
at: aGame with: aPosition

	^self new initializeAt: aGame with: aPosition! !


!classDefinition: #TerniLapilliEmptyPosition category: #'TerniLapilli-Exercise'!
TerniLapilliPosition subclass: #TerniLapilliEmptyPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliEmptyPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:31:02'!
isO

	^false! !

!TerniLapilliEmptyPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:38:23'!
isX

	^false! !

!TerniLapilliEmptyPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:53:39'!
removeFrom: aPlayer

	game signalInvalidMoveError! !

!TerniLapilliEmptyPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:36:27'!
removeWith: aPlayer

	game signalInvalidPositionError! !

!TerniLapilliEmptyPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:42:29'!
updateWith: aPlayer

	game safePut: aPlayer at: position! !


!classDefinition: #TerniLapilliOPosition category: #'TerniLapilli-Exercise'!
TerniLapilliPosition subclass: #TerniLapilliOPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliOPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:31:09'!
isO

	^true! !

!TerniLapilliOPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:38:31'!
isX

	^false! !

!TerniLapilliOPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:49:02'!
removeFrom: aPlayer

	aPlayer removeFromOPosition: position! !

!TerniLapilliOPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:39:55'!
updateWith: aPlayer

	game signalPositionUnavailableError! !


!classDefinition: #TerniLapilliXPosition category: #'TerniLapilli-Exercise'!
TerniLapilliPosition subclass: #TerniLapilliXPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliXPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:31:21'!
isO

	^false! !

!TerniLapilliXPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 15:38:41'!
isX

	^true! !

!TerniLapilliXPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 16:49:10'!
removeFrom: aPlayer

	aPlayer removeFromXPosition: position! !

!TerniLapilliXPosition methodsFor: 'as yet unclassified' stamp: 'FML 6/18/2020 14:39:30'!
updateWith: aPlayer

	game signalPositionUnavailableError! !
