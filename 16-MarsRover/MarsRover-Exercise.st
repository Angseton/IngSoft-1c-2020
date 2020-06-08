!classDefinition: #MarsRoverTests category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FML 6/8/2020 02:16:46'!
test01PositionAndDirectionAreCorrectWhenCreated

	marsRover := MarsRover at: 0@0 lookingTo: #N.
	
	self assert: 0@0 equals: marsRover position.
	self assert: #N equals: marsRover direction.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FML 6/8/2020 15:41:03'!
test02PositionAndDirectionDontChangeWhenNoCommandsAreSent

	marsRover := MarsRover at: 0@0 lookingTo: #N.
	
	marsRover processCommands: ''.
	
	self assert: 0@0 equals: marsRover position.
	self assert: #N equals: marsRover direction.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FML 6/8/2020 15:42:21'!
test03

	marsRover := MarsRover at: 0@0 lookingTo: #N.
	
	marsRover processCommands: 'f'.
	
	self assert: 1@0 equals: marsRover position.
	self assert: #N equals: marsRover direction.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FML 6/8/2020 15:50:37'!
test04

	marsRover := MarsRover at: 0@0 lookingTo: #N.
	
	marsRover processCommands: 'b'.
	
	self assert: -1@0 equals: marsRover position.
	self assert: #N equals: marsRover direction.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FML 6/8/2020 15:52:31'!
test05

	marsRover := MarsRover at: 0@0 lookingTo: #N.
	
	marsRover processCommands: 'r'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: #E equals: marsRover direction.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FML 6/8/2020 15:53:48'!
test06

	marsRover := MarsRover at: 0@0 lookingTo: #N.
	
	marsRover processCommands: 'l'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: #W equals: marsRover direction.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FML 6/8/2020 16:23:25'!
test07

	marsRover := MarsRover at: 0@0 lookingTo: #N.
	
	marsRover processCommands: 'fffff'.
	
	self assert: 5@0 equals: marsRover position.
	self assert: #N equals: marsRover direction.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FML 6/8/2020 16:24:31'!
test08

	marsRover := MarsRover at: 0@0 lookingTo: #N.
	
	marsRover processCommands: 'rrr'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: #W equals: marsRover direction.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'FML 6/8/2020 16:34:45'!
test09

	marsRover := MarsRover at: 0@0 lookingTo: #N.
	
	marsRover processCommands: 'lll'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: #E equals: marsRover direction.! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'FML 6/8/2020 16:36:58'!
initializeAt: aPoint looking: aCardinalPoint 
	
	position := aPoint.
	direction := aCardinalPoint.! !


!MarsRover methodsFor: 'accessing' stamp: 'FML 6/8/2020 02:18:39'!
direction
	
	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'FML 6/8/2020 02:18:29'!
position
	
	^position! !


!MarsRover methodsFor: 'processing - private' stamp: 'FML 6/8/2020 16:26:55'!
processSingleCommand: aCommand

		aCommand = $f ifTrue: [
			self moveForward
		].
	
		aCommand = $b ifTrue: [
			self moveBackwards
		].
	
		aCommand = $r ifTrue: [
			self rotateRight
		].
	
		aCommand = $l ifTrue: [
			self rotateLeft
		].
	
		^self! !


!MarsRover methodsFor: 'movement' stamp: 'FML 6/8/2020 16:25:58'!
moveBackwards
		
		position _ position - (1@0)! !

!MarsRover methodsFor: 'movement' stamp: 'FML 6/8/2020 16:25:21'!
moveForward
		
		position _ position + (1@0)! !

!MarsRover methodsFor: 'movement' stamp: 'FML 6/8/2020 16:34:01'!
rotateLeft
		
		direction = #N ifTrue: [^direction _ #W].
		direction = #E ifTrue: [^direction _ #N].
		direction = #S ifTrue: [^direction _ #E].
		direction = #W ifTrue: [^direction _ #S].! !

!MarsRover methodsFor: 'movement' stamp: 'FML 6/8/2020 16:33:25'!
rotateRight
		
		(direction = #N) ifTrue: [^direction _ #E].
		direction = #E ifTrue: [^direction _ #S].
		direction = #S ifTrue: [^direction _ #W].
		direction = #W ifTrue: [^direction _ #N].! !


!MarsRover methodsFor: 'processing' stamp: 'FML 6/8/2020 16:52:02'!
processCommands: aString

		aString do: [ :aCommand |
			self processSingleCommand: aCommand
			]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FML 6/8/2020 16:36:58'!
at: aPoint lookingTo: aCardinalPoint

	^self new initializeAt: aPoint looking: aCardinalPoint.! !
