!classDefinition: #CartTests category: #'TusLibros-Exercise'!
TestCase subclass: #CartTests
	instanceVariableNames: 'aCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!CartTests methodsFor: 'setUp/tearDown' stamp: 'FML 7/5/2020 18:00:25'!
setUp
	
	aCart := Cart withID: 465.! !


!CartTests methodsFor: 'tests' stamp: 'FML 7/5/2020 18:00:49'!
test01CartIsEmptyWhenCreated
	
	self assert: aCart list isEmpty! !

!CartTests methodsFor: 'tests' stamp: 'FML 7/5/2020 18:01:04'!
test02ABookIsCorrectlyAdded
	
	aCart add: 1 ofBook: 123.
	
	self assert: 1 equals: (aCart list occurrencesOf: 123).! !

!CartTests methodsFor: 'tests' stamp: 'FML 7/5/2020 18:01:16'!
test03SeveralBooksAreCorrectlyAdded

	aCart add: 3 ofBook: 123.
	
	self assert: 3 equals: (aCart list occurrencesOf: 123).! !

!CartTests methodsFor: 'tests' stamp: 'FML 7/5/2020 18:01:30'!
test04CanNotAddANegativeAmountOfBooks
	
	self should: [aCart add: -1 ofBook: 123]
		raise: Error
		withMessageText: aCart class invalidAmountErrorDescription! !

!CartTests methodsFor: 'tests' stamp: 'FML 7/5/2020 18:01:40'!
test05CartHasCorrectID

	self assert: 465 equals: aCart id.! !


!classDefinition: #Cart category: #'TusLibros-Exercise'!
Object subclass: #Cart
	instanceVariableNames: 'books id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Exercise'!

!Cart methodsFor: 'interface' stamp: 'FML 7/5/2020 17:53:02'!
add: anAmount ofBook: anISBN
		
	self assertBookAmountToAddToCartIsPositive: anAmount.
		
	books add: anISBN withOccurrences: anAmount! !

!Cart methodsFor: 'interface' stamp: 'FML 7/5/2020 17:42:57'!
id
	
	^id! !

!Cart methodsFor: 'interface' stamp: 'FML 7/5/2020 17:36:23'!
list
	
	^books copy! !


!Cart methodsFor: 'private' stamp: 'FML 7/5/2020 17:33:11'!
assertBookAmountToAddToCartIsPositive: anAmount
		
	(anAmount > 0) ifFalse: [self signalInvalidAmountError].! !

!Cart methodsFor: 'private' stamp: 'FML 7/5/2020 14:36:27'!
signalInvalidAmountError

	^self error: self class invalidAmountErrorDescription.! !


!Cart methodsFor: 'initialization' stamp: 'FML 7/5/2020 14:24:11'!
initialize
	
	books := Bag new.! !

!Cart methodsFor: 'initialization' stamp: 'FML 7/5/2020 17:54:30'!
withID: anID
	
	id := anID.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Exercise'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'FML 7/5/2020 17:54:51'!
withID: anID 

	^self new withID: 465! !


!Cart class methodsFor: 'error handling' stamp: 'FML 7/5/2020 14:35:18'!
invalidAmountErrorDescription
	
	^'Amount of Books Should Be At Least 1'! !
