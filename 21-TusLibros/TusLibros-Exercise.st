!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'objectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:06:48'!
test01NewCartsAreCreatedEmpty

	self assert: objectFactory emptyCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:07:15'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := objectFactory emptyCart.
	
	self 
		should: [ cart add: objectFactory itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:08:21'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := objectFactory emptyCart.
	
	cart add: objectFactory itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:08:44'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := objectFactory emptyCart.
	
	self 
		should: [cart add: 0 of: objectFactory itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:09:11'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := objectFactory emptyCart.
	
	self 
		should: [cart add: 2 of: objectFactory itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:09:46'!
test06CartRemembersAddedItems

	| cart |
	
	cart := objectFactory emptyCart.
	
	cart add: objectFactory itemSoldByTheStore.
	self assert: (cart includes: objectFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:10:15'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := objectFactory emptyCart.
	
	self deny: (cart includes: objectFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:10:46'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := objectFactory emptyCart.
	
	cart add: 2 of: objectFactory itemSoldByTheStore .
	self assert: (cart occurrencesOf: objectFactory itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'setUp/tearDown' stamp: 'FML 7/15/2020 21:06:24'!
setUp

	objectFactory := TestObjectFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'objectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'FML 7/15/2020 17:44:34'!
test01CanNotCheckOutAnEmptyCart

	| aCashier aSalesBook|
	
	aSalesBook := objectFactory salesbook.
	
	aCashier := Cashier 
		forCart: objectFactory emptyCart
		withCreditCard: objectFactory validCreditCard
		onDate: objectFactory today
		withMerchantProcessor: objectFactory validMP
		withSalesBook: aSalesBook.
		
	self
		should: [aCashier checkout]
		raise: Error - MessageNotUnderstood
		withMessageText: aCashier class emptyCartErrorDescription.
		
	self assert: aSalesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:00:22'!
test02CanNotCheckOutWithAnExpiredCreditCardAndMPIsNotContacted

	| aCashier aSalesBook aMP |
	
	aMP := objectFactory validMP.
	
	aSalesBook := objectFactory salesbook.
	
	aCashier := Cashier 
		forCart: objectFactory cartWithAProduct
		withCreditCard: objectFactory expiredCreditCard
		onDate: objectFactory today
		withMerchantProcessor: aMP
		withSalesBook: aSalesBook.
		
	self
		should: [aCashier checkout]
		raise: Error - MessageNotUnderstood
		withMessageText: aCashier class expiredCardErrorDescription.
		
	self assert: aSalesBook isEmpty.
	self deny: aMP wasContacted.! !

!CashierTest methodsFor: 'tests' stamp: 'FML 7/15/2020 20:58:55'!
test03CanCheckOutACartWithAProductWithAValidCreditCard

	| aCashier aSalesBook total aMP|
	
	aMP := objectFactory validMP.
	
	aSalesBook := objectFactory salesbook.
	
	aCashier := Cashier 
		forCart: objectFactory cartWithAProduct
		withCreditCard: objectFactory validCreditCard 
		onDate: objectFactory today
		withMerchantProcessor: aMP
		withSalesBook: aSalesBook.
		
	total := aCashier checkout.
		
	self assert: 25 equals: total.
	
	self assert: aSalesBook notEmpty.
	self assert: total equals: aSalesBook first total.
	self assert: aMP wasContacted.! !

!CashierTest methodsFor: 'tests' stamp: 'FML 7/15/2020 20:59:37'!
test04CanNotMakeTheSaleIfCreditCardIsRobbed

	| aCashier aSalesBook aMP |
	
	aMP := objectFactory robbedCreditCardMP.
	
	aSalesBook := objectFactory salesbook.
	
	aCashier := Cashier 
		forCart: objectFactory cartWithAProduct
		withCreditCard: objectFactory validCreditCard 
		onDate: objectFactory today
		withMerchantProcessor: aMP
		withSalesBook: objectFactory salesbook.
		
	self
		should: [aCashier checkout]
		raise: Error - MessageNotUnderstood
		withMessageText: 'Tarjeta Robada'.
		
	self assert: aSalesBook isEmpty.
	self assert: aMP wasContacted.! !

!CashierTest methodsFor: 'tests' stamp: 'FML 7/15/2020 21:00:07'!
test05CanNotMakeTheSaleIfCreditCardIsOverLimit

	| aCashier aSalesBook aMP |
	
	aMP := objectFactory overLimitCreditCardMP.
	
	aSalesBook := objectFactory salesbook.
	
	aCashier := Cashier 
		forCart: objectFactory cartWithAProduct
		withCreditCard: objectFactory validCreditCard 
		onDate: objectFactory today
		withMerchantProcessor: aMP
		withSalesBook: objectFactory salesbook.
		
	self
		should: [aCashier checkout]
		raise: Error - MessageNotUnderstood
		withMessageText: 'El limite de la tarjeta fue superado'.
		
	self assert: aSalesBook isEmpty.
	self assert: aMP wasContacted.! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'FML 7/15/2020 17:09:19'!
setUp

	objectFactory := TestObjectFactory new.! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'objectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'FML 7/15/2020 19:46:18'!
test01CanCreateACardWithValidDataAndAccessIt
	
	self
	shouldnt: [objectFactory validCreditCard]
	raise: Error! !

!CreditCardTest methodsFor: 'tests' stamp: 'FML 7/15/2020 19:47:25'!
test02ACardWithFutureExpirationDateIsNotExpired

	self deny: (objectFactory validCreditCard isExpiredOn: objectFactory today).! !

!CreditCardTest methodsFor: 'tests' stamp: 'FML 7/15/2020 19:47:59'!
test03ACardWithPastExpirationDateIsExpired
	
	self assert: (objectFactory expiredCreditCard isExpiredOn: objectFactory today).! !

!CreditCardTest methodsFor: 'tests' stamp: 'FML 7/15/2020 19:50:27'!
test04CanNotCreateACardWithEmptyName
	
	self should: [CreditCard for: '' withNumber: 1234567812345678 andExpirationDate: objectFactory futureExpirationDate.]
		  raise: Error
		  withMessageText: CreditCard invalidNameErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'FML 7/15/2020 19:51:24'!
test05CanNotCreateACardWithANumberThatHasNot16Digits
	
	self should: [CreditCard for: 'Valid Name' withNumber: 123456 andExpirationDate: objectFactory futureExpirationDate.]
		raise: Error
		withMessageText: CreditCard invalidNumberErrorDescription.! !


!CreditCardTest methodsFor: 'setUp/tearDown' stamp: 'FML 7/15/2020 19:45:38'!
setUp

	objectFactory := TestObjectFactory new.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'FML 7/12/2020 17:55:30'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'FML 7/15/2020 19:42:05'!
products
	
	^items copy! !

!Cart methodsFor: 'queries' stamp: 'FML 7/12/2020 18:09:38'!
total
	
	^items inject: 0 into: [ :currentTotal :anItem | currentTotal + catalog at: anItem].! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook cart creditCard date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'FML 7/15/2020 17:26:35'!
checkout
	
	(creditCard isExpiredOn: date) ifTrue: [self signalExpiredCardError].
	
	cart isEmpty ifTrue: [self signalEmptyCartError].
	
	merchantProcessor debit: cart total from: creditCard.
	
	self registerSale.
	
	^cart total.! !


!Cashier methodsFor: 'checkout - private' stamp: 'FML 7/15/2020 20:52:48'!
registerSale

	| sale |
	
	sale := Sale of: cart products withTotal: cart total with: creditCard on: date.
	
	salesBook add: sale.! !


!Cashier methodsFor: 'initialization' stamp: 'FML 7/15/2020 16:58:09'!
initializeFor: aCart withCreditCard: aCreditCard onDate: aDate withMerchantProcessor: aMerchantProcessor withSalesBook: aSalesBook

	cart := aCart.
	creditCard := aCreditCard.
	date := aDate.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.! !


!Cashier methodsFor: 'error handling' stamp: 'FML 7/12/2020 17:40:02'!
signalEmptyCartError
	
	^self error: self class emptyCartErrorDescription.! !

!Cashier methodsFor: 'error handling' stamp: 'FML 7/12/2020 17:46:53'!
signalExpiredCardError
	
	^self error: self class expiredCardErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error handling' stamp: 'FML 7/13/2020 15:22:07'!
MPErrorDescription
	
	^'Merchant Processor could not process payment.'! !

!Cashier class methodsFor: 'error handling' stamp: 'FML 7/12/2020 17:37:52'!
emptyCartErrorDescription
	
	^'Can not check out an empty cart.'! !

!Cashier class methodsFor: 'error handling' stamp: 'FML 7/12/2020 17:45:42'!
expiredCardErrorDescription
	
	^'The Credit Card Is Expired'! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'FML 7/15/2020 16:55:54'!
forCart: aCart withCreditCard: aCreditCard onDate: aDate withMerchantProcessor: aMerchantProcessor withSalesBook: aSalesBook

	^self new initializeFor: aCart withCreditCard: aCreditCard onDate: aDate withMerchantProcessor: aMerchantProcessor withSalesBook: aSalesBook! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'name number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FML 7/15/2020 16:44:31'!
initializeFor: aName withNumber: aNumber andExpirationMonth: anExpirationDate 
	
	name := aName.
	number := aNumber.
	expirationDate := anExpirationDate.! !


!CreditCard methodsFor: 'testing' stamp: 'FML 7/15/2020 16:47:27'!
isExpiredOn: aDate
	
	^expirationDate lastDate < aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FML 7/15/2020 16:44:31'!
for: aName withNumber: aNumber andExpirationDate: anExpirationDate

	aName isEmpty ifTrue: [^self signalInvalidNameError].
	
	(aNumber decimalDigitLength = 16) ifFalse: [^self signalInvalidNumberError].

	^self new initializeFor: aName withNumber: aNumber andExpirationMonth: anExpirationDate. ! !


!CreditCard class methodsFor: 'error handling' stamp: 'FML 7/12/2020 16:42:41'!
invalidNameErrorDescription
	
	^'Name can not be empty'.! !

!CreditCard class methodsFor: 'error handling' stamp: 'FML 7/12/2020 16:47:59'!
invalidNumberErrorDescription
	
	^'Credit Card number should have 16 digits'! !

!CreditCard class methodsFor: 'error handling' stamp: 'FML 7/12/2020 16:45:06'!
signalInvalidNameError

	^self error: self invalidNameErrorDescription.! !

!CreditCard class methodsFor: 'error handling' stamp: 'FML 7/12/2020 16:58:26'!
signalInvalidNumberError

	^self error: self invalidNumberErrorDescription.! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'FML 7/15/2020 19:52:24'!
debit: anAmount from: aCreditCard

	self subclassResponsibility! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
MerchantProcessor subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBehaviour contacted'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'FML 7/15/2020 20:57:57'!
initializeWith: aDebitBehaviour 
	
	debitBehaviour := aDebitBehaviour.
	contacted := false.! !


!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'FML 7/15/2020 20:58:15'!
debit: anAmount from: aCreditCard

	contacted := true.
	debitBehaviour value: aCreditCard value: anAmount.! !


!MerchantProcessorSimulator methodsFor: 'testing' stamp: 'FML 7/15/2020 20:57:36'!
wasContacted
	
	^contacted! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'FML 7/15/2020 20:45:15'!
with: aDebitBehaviour

	^self new initializeWith: aDebitBehaviour! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'collectionOfProducts creditCard date total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'FML 7/15/2020 20:51:35'!
initializeOf: aCollectionOfProducts withTotal: aTotal with: aCreditCard on: aDate 
	
	collectionOfProducts := aCollectionOfProducts.
	total := aTotal.
	creditCard := aCreditCard.
	date := aDate.! !


!Sale methodsFor: 'queries' stamp: 'FML 7/15/2020 20:49:24'!
total
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'FML 7/15/2020 20:52:34'!
of: aCollectionOfProducts withTotal: aTotal with: aCreditCard on: aDate

	^self new initializeOf: aCollectionOfProducts withTotal: aTotal with: aCreditCard on: aDate.! !


!classDefinition: #TestObjectFactory category: #TusLibros!
Object subclass: #TestObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjectFactory methodsFor: 'cart' stamp: 'FML 7/15/2020 17:34:22'!
cartWithAProduct
	
	^self emptyCart add: self itemSoldByTheStore.! !

!TestObjectFactory methodsFor: 'cart' stamp: 'FML 7/15/2020 17:38:33'!
catalog
	
	^Dictionary new at: self itemSoldByTheStore put: 25; yourself.! !

!TestObjectFactory methodsFor: 'cart' stamp: 'FML 7/15/2020 17:10:37'!
emptyCart
	
	^Cart acceptingItemsOf: self catalog! !

!TestObjectFactory methodsFor: 'cart' stamp: 'FML 7/15/2020 21:07:40'!
itemNotSoldByTheStore
	
	^'invalid book'! !

!TestObjectFactory methodsFor: 'cart' stamp: 'FML 7/15/2020 17:15:16'!
itemSoldByTheStore
	
	^'valid book'! !

!TestObjectFactory methodsFor: 'cart' stamp: 'FML 7/15/2020 17:21:35'!
salesbook
	
	^OrderedCollection new.! !


!TestObjectFactory methodsFor: 'merchantProcessor' stamp: 'FML 7/15/2020 20:47:04'!
overLimitCreditCardMP

	^MerchantProcessorSimulator with: [ :aCreditCard :anAmount | self error: 'El limite de la tarjeta fue superado'].! !

!TestObjectFactory methodsFor: 'merchantProcessor' stamp: 'FML 7/15/2020 20:46:50'!
robbedCreditCardMP
	
	^MerchantProcessorSimulator with: [ :aCreditCard :anAmount | self error: 'Tarjeta Robada'].! !

!TestObjectFactory methodsFor: 'merchantProcessor' stamp: 'FML 7/15/2020 20:47:37'!
validMP
	
	^MerchantProcessorSimulator with: [ :aCreditCard :anAmount | ].! !


!TestObjectFactory methodsFor: 'creditCard' stamp: 'FML 7/15/2020 17:39:36'!
expiredCreditCard
	
	^CreditCard for: 'Valid Name' withNumber: 1234567812345678 andExpirationDate: self pastExpirationDate! !

!TestObjectFactory methodsFor: 'creditCard' stamp: 'FML 7/15/2020 17:20:07'!
futureExpirationDate
	
	^GregorianMonthOfYear current next! !

!TestObjectFactory methodsFor: 'creditCard' stamp: 'FML 7/15/2020 17:40:03'!
pastExpirationDate
	
	^GregorianMonthOfYear current previous! !

!TestObjectFactory methodsFor: 'creditCard' stamp: 'FML 7/15/2020 17:28:47'!
today
	
	^FixedGregorianDate today! !

!TestObjectFactory methodsFor: 'creditCard' stamp: 'FML 7/15/2020 17:18:03'!
validCreditCard
	
	^CreditCard for: 'Valid Name' withNumber: 1234567812345678 andExpirationDate: self futureExpirationDate! !
