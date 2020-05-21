!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Gaston 5/21/2020 00:09:20'!
test01PrefixCannotBeEmpty
		
	| sentenceFinderByPrefix stack sentences |
	
	stack _ OOStack new.
	sentenceFinderByPrefix _ SentenceFinderByPrefix new.
	sentences _ #('Hello World' 'Bye Bye World' 'Good Afternoon World' 'Sayonara World').
	sentences do: [:sentence | stack push: sentence.].
	
	self
		should: [ sentenceFinderByPrefix find: '' inStack: stack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription]
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Gaston 5/21/2020 00:09:40'!
test02PrefixCannotContainEmptySpaces
	
	| sentenceFinderByPrefix stack sentences |
	
	stack _ OOStack new.
	sentenceFinderByPrefix _ SentenceFinderByPrefix new.
	sentences _ #('Hello World' 'Bye Bye World' 'Good Afternoon World' 'Sayonara World').
	sentences do: [:sentence | stack push: sentence.].
	
	self
		should: [ sentenceFinderByPrefix find: 'Bye ' inStack: stack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptySpacesErrorDescription]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Gaston 5/21/2020 00:00:09'!
test03PrefixIsCaseSensitive

	| sentenceFinderByPrefix stack matches sentences |
	
	stack _ OOStack new.
	sentenceFinderByPrefix _ SentenceFinderByPrefix new.
	sentences _ #('Hello World' 'Bye Bye World' 'Good Afternoon World' 'Sayonara World').
	sentences do: [:sentence | stack push: sentence.].
	
	matches _ sentenceFinderByPrefix find: 'bye' inStack: stack.
	
	self assert: matches isEmpty.
	self assert: (stack size = sentences size).
	sentences reverseDo: [:sentence | self assert: sentence = stack pop.].
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Gaston 5/20/2020 23:05:50'!
test04NoMatchesInEmptyStack
	
	| sentenceFinderByPrefix stack matches |
	
	sentenceFinderByPrefix _ SentenceFinderByPrefix new.
	stack _ OOStack new.
	matches _ sentenceFinderByPrefix find: 'prefix' inStack: stack.
	
	
	self assert: matches isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Gaston 5/20/2020 23:42:36'!
test05StackRemainsUnaltered
	
	| sentenceFinderByPrefix stack matches sentences |
	
	stack _ OOStack new.
	sentenceFinderByPrefix _ SentenceFinderByPrefix new.
	sentences _ #('Hello World' 'Bye Bye World' 'Good Afternoon World' 'Sayonara World').
	sentences do: [:sentence | stack push: sentence.].
	
	matches _ sentenceFinderByPrefix find: 'Bye' inStack: stack.
	
	self assert: matches size = 1.
	self assert: ((matches at: 1) = 'Bye Bye World').
	self assert: (stack size = sentences size).
	sentences reverseDo: [:sentence | self assert: sentence = stack pop.].
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Gaston 5/20/2020 23:43:45'!
test06AllEqualMatchesShouldBeIncluded
	
	| sentenceFinderByPrefix stack matches sentences |
	
	stack _ OOStack new.
	sentenceFinderByPrefix _ SentenceFinderByPrefix new.
	sentences _ #('Hello World' 'Bye Bye World' 'Bye Bye World' 'Sayonara World').
	sentences do: [:sentence | stack push: sentence.].
	
	matches _ sentenceFinderByPrefix find: 'Bye' inStack: stack.
	
	self assert: matches size = 2.
	self assert: ((matches at: 1) = 'Bye Bye World').
	self assert: ((matches at: 2) = 'Bye Bye World').
	self assert: (stack size = sentences size).
	sentences reverseDo: [:sentence | self assert: sentence = stack pop.].
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Gaston 5/20/2020 23:47:26'!
test07NoMatchesFound
	
	| sentenceFinderByPrefix stack matches sentences |
	
	stack _ OOStack new.
	sentenceFinderByPrefix _ SentenceFinderByPrefix new.
	sentences _ #('Hello World' 'Bye Bye World' 'Bye Bye World' 'Sayonara World').
	sentences do: [:sentence | stack push: sentence.].
	
	matches _ sentenceFinderByPrefix find: 'Hola' inStack: stack.
	
	self assert: matches isEmpty .
	self assert: (stack size = sentences size).
	sentences reverseDo: [:sentence | self assert: sentence = stack pop.].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Gaston 5/20/2020 23:50:53'!
test08SomeMatchesFound
	
	| sentenceFinderByPrefix stack matches sentences |
	
	stack _ OOStack new.
	sentenceFinderByPrefix _ SentenceFinderByPrefix new.
	sentences _ #('Hello World' 'Bye Bye World' 'Bye Bye Beautiful' 'Sayonara World' 'Bye Grandad' 'Hey Ho!!').
	sentences do: [:sentence | stack push: sentence.].
	
	matches _ sentenceFinderByPrefix find: 'Bye' inStack: stack.
	
	self assert: matches size = 3.
	self assert: ((matches at: 1) = 'Bye Grandad').
	self assert: ((matches at: 2) = 'Bye Bye Beautiful').
	self assert: ((matches at: 3) = 'Bye Bye World').
	self assert: (stack size = sentences size).
	sentences reverseDo: [:sentence | self assert: sentence = stack pop.].! !


!classDefinition: #Container category: #'Stack-Exercise'!
Object subclass: #Container
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Container methodsFor: 'accessing' stamp: 'FML 5/18/2020 21:46:57'!
next

	^self subclassResponsibility ! !

!Container methodsFor: 'accessing' stamp: 'FML 5/18/2020 21:51:53'!
size

	^self subclassResponsibility ! !

!Container methodsFor: 'accessing' stamp: 'FML 5/18/2020 21:36:35'!
value

	^self subclassResponsibility ! !


!Container methodsFor: 'testing' stamp: 'FML 5/18/2020 21:17:43'!
isNull

	^self subclassResponsibility ! !


!classDefinition: #NullContainer category: #'Stack-Exercise'!
Container subclass: #NullContainer
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullContainer methodsFor: 'initialization' stamp: 'FML 5/18/2020 21:46:10'!
initializeWithStack: aStack

	stack _ aStack! !


!NullContainer methodsFor: 'accessing' stamp: 'FML 5/18/2020 21:46:57'!
next

	^self! !

!NullContainer methodsFor: 'accessing' stamp: 'FML 5/18/2020 21:52:05'!
size

	^0! !

!NullContainer methodsFor: 'accessing' stamp: 'FML 5/18/2020 21:45:10'!
value

	^stack error: stack class stackEmptyErrorDescription ! !


!NullContainer methodsFor: 'testing' stamp: 'FML 5/18/2020 21:17:57'!
isNull

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NullContainer class' category: #'Stack-Exercise'!
NullContainer class
	instanceVariableNames: ''!

!NullContainer class methodsFor: 'as yet unclassified' stamp: 'FML 5/18/2020 21:41:13'!
withStack: aStack

	^self new initializeWithStack: aStack.! !


!classDefinition: #StringContainer category: #'Stack-Exercise'!
Container subclass: #StringContainer
	instanceVariableNames: 'nextContenedor value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StringContainer methodsFor: 'initialization' stamp: 'FML 5/18/2020 21:29:23'!
initializeWith: aString before: aContenedor

	value _ aString.
	
	nextContenedor _ aContenedor! !


!StringContainer methodsFor: 'accessing' stamp: 'FML 5/18/2020 21:46:57'!
next

	^nextContenedor ! !

!StringContainer methodsFor: 'accessing' stamp: 'FML 5/18/2020 21:52:20'!
size

	^1! !

!StringContainer methodsFor: 'accessing' stamp: 'FML 5/18/2020 21:37:02'!
value

	^value! !


!StringContainer methodsFor: 'testing' stamp: 'FML 5/18/2020 21:18:09'!
isNull

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StringContainer class' category: #'Stack-Exercise'!
StringContainer class
	instanceVariableNames: ''!

!StringContainer class methodsFor: 'as yet unclassified' stamp: 'FML 5/18/2020 21:27:30'!
with: aString before: aContenedor

	^self new initializeWith: aString before: aContenedor.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'firstContenedor size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'FML 5/19/2020 18:17:09'!
initialize

	super initialize.
	
	firstContenedor _ NullContainer withStack: self.
	
	size _ 0.! !


!OOStack methodsFor: 'operations' stamp: 'Gaston 5/20/2020 23:39:01'!
pop

	| returnValue newFirstContenedor|

	returnValue _ firstContenedor value.
	
	newFirstContenedor _ firstContenedor next.
	
	firstContenedor _ newFirstContenedor.
	
	size _ size - 1.
	
	^returnValue
	
	
	! !

!OOStack methodsFor: 'operations' stamp: 'FML 5/19/2020 18:17:20'!
push: aString

	| newFirstContenedor |
	
	newFirstContenedor _ StringContainer with: aString before: firstContenedor.
	
	firstContenedor _ newFirstContenedor.
	
	size _ size + 1.
	
	
	
	! !

!OOStack methodsFor: 'operations' stamp: 'FML 5/18/2020 21:53:10'!
size

	^size
	
	
	! !

!OOStack methodsFor: 'operations' stamp: 'FML 5/18/2020 21:47:40'!
top

	| returnValue |

	returnValue _ firstContenedor value.
	
	^returnValue
	
	
	! !


!OOStack methodsFor: 'testing' stamp: 'FML 5/18/2020 21:28:55'!
isEmpty

	^firstContenedor isNull! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Gaston 5/21/2020 00:05:07'!
find: aPrefix inStack: aStack
	
	|sentence sentences auxStack|
	
	sentences _ OrderedCollection new.
	auxStack _ OOStack new.
	
	aPrefix isEmpty ifTrue: [self error: self class prefixEmptyErrorDescription ].
	(aPrefix findString: ' ') > 0 ifTrue: [self error: self class prefixEmptySpacesErrorDescription].
	
	[aStack isEmpty] whileFalse: [
		sentence _ aStack top.
		(sentence beginsWith: aPrefix) ifTrue: [ sentences add: sentence].
		auxStack push: aStack pop.
	].

	[auxStack isEmpty] whileFalse: [
		aStack push: auxStack pop.
	].

	^sentences! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'Gaston 5/21/2020 00:03:04'!
prefixEmptyErrorDescription
	
	^'Prefix cannot be empty'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'Gaston 5/21/2020 00:04:46'!
prefixEmptySpacesErrorDescription
	
	^'Prefix cannot contain empty spaces'.! !
