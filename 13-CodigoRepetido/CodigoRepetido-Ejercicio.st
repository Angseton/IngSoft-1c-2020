!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'helper' stamp: 'Gaston 5/6/2020 18:02:31'!
AssertThat: aBlock willFailOn: Error doing: aCatchBlock

	[ aBlock value.
	self fail ]
		on: Error 
		do: aCatchBlock
	

	
	
! !

!CustomerBookTest methodsFor: 'helper' stamp: 'Gaston 5/4/2020 20:35:20'!
timeTakenToEvaluate: aBlock

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning-millisecondsBeforeRunning
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'Gaston 5/4/2020 20:38:05'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	
	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: (self timeTakenToEvaluate: [customerBook addCustomerNamed: 'John Lennon'.]) < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Gaston 5/4/2020 20:39:52'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assert: (self timeTakenToEvaluate: [customerBook removeCustomerNamed: paulMcCartney.]) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Gaston 5/6/2020 18:25:48'!
test03CanNotAddACustomerWithEmptyName
	
	| customerBook |
			
	customerBook := CustomerBook new.

	self AssertThat: [ customerBook addCustomerNamed: ''.] willFailOn: Error doing: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Gaston 5/6/2020 18:11:40'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self AssertThat: [ customerBook removeCustomerNamed: 'Paul McCartney'.] willFailOn: NotFound doing: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Gaston 5/4/2020 21:00:20'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	customerBook assertThatNumberOfActiveCustomersIs: 0 andNumberOfSuspendedCustomersIs: 1 andNumberOfCustomersis: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Gaston 5/4/2020 21:00:46'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	customerBook assertThatNumberOfActiveCustomersIs: 0 andNumberOfSuspendedCustomersIs: 0 andNumberOfCustomersis: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Gaston 5/6/2020 18:13:00'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self AssertThat: [ customerBook suspendCustomerNamed: 'Ringo Starr'.] willFailOn: CantSuspend doing: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Gaston 5/6/2020 18:15:40'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self AssertThat: [ customerBook suspendCustomerNamed: johnLennon.] willFailOn: CantSuspend doing: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)]
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'Gaston 5/4/2020 21:03:16'!
assertThatNumberOfActiveCustomersIs: activeNumber andNumberOfSuspendedCustomersIs: suspendedNumber andNumberOfCustomersis: customersNumber

	Assert that: activeNumber isEqualTo: self numberOfActiveCustomers.
	Assert that: suspendedNumber isEqualTo: self numberOfSuspendedCustomers.
	Assert that: customersNumber isEqualTo: self numberOfCustomers.
! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'helper' stamp: 'Gaston 5/6/2020 19:29:27'!
signalError: errorMessage
	
	self error: (errorMessage asMessage sendTo: self class)! !


!CustomerBook methodsFor: 'customer management' stamp: 'Gaston 5/6/2020 19:35:49'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Gaston 5/6/2020 19:00:23'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Gaston 5/6/2020 19:04:26'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^ NotFound signal.].].

! !

!CustomerBook methodsFor: 'customer management' stamp: 'Gaston 5/6/2020 19:30:07'!
signalCustomerAlreadyExists 

	self signalError: #customerAlreadyExistsErrorMessage
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'Gaston 5/6/2020 19:21:59'!
signalCustomerNameCannotBeEmpty 

	self signalError: #customerCanNotBeEmptyErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
