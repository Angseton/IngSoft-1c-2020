!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'FML 7/23/2020 00:49:17'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'FML 7/23/2020 00:49:47'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut total.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'FML 7/23/2020 00:50:36'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #SystemInterfaceTest category: #TusLibros!
TestCase subclass: #SystemInterfaceTest
	instanceVariableNames: 'testObjectsFactory authenticationBehaviour interface debitBehavior now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 14:08:35'!
test01CanNotCreateCartWithInvalidCredentials

	authenticationBehaviour _ self failedAuthentication.

	self
		should: [interface createCartFor:'user1' with: 'pass1']
		raise: Error - MessageNotUnderstood
		withMessageText: interface class invalidCredentialsErrorDescription! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 14:33:01'!
test02CorrectlyCreatedCartIsEmpty

	| aCartID |
	
	authenticationBehaviour _ self passedAuthentication.

	aCartID := interface createCartFor: 'user1' with: 'pass1'.
	
	self assert: (interface listCart: aCartID) isEmpty.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/23/2020 02:56:18'!
test03CanNotListAnInvalidCart

	| aCartID |
	
	authenticationBehaviour _ self passedAuthentication.

	aCartID := Object new.
		
	self
		should: [interface listCart: aCartID]
		raise: Error - MessageNotUnderstood
		withMessageText: interface class invalidCartErrorDescription.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/23/2020 02:56:30'!
test04CanNotAddABookToAnInvalidCart

	| aCartID book |
	
	authenticationBehaviour _ self passedAuthentication.

	aCartID := Object new.
	
	book := testObjectsFactory itemSellByTheStore.
	
	self
		should: [interface add: 1 of: book toCart: aCartID]
		raise: Error - MessageNotUnderstood
		withMessageText: interface class invalidCartErrorDescription.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 16:27:06'!
test05CanAddBooksToAValidCart

	| aCartID book |
	
	authenticationBehaviour _ self passedAuthentication.

	aCartID := interface createCartFor: 'user1' with: 'pass1'.
	
	book := testObjectsFactory itemSellByTheStore.
	
	interface add: 1 of: book toCart: aCartID.
	
	self assert: 1 equals: (interface listCart: aCartID) size.
	self assert: (interface listCart: aCartID) includes: book.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/23/2020 02:56:40'!
test06CanNotCheckoutAnInvalidCart

	| aCartID aCreditCardData|
	
	authenticationBehaviour _ self passedAuthentication.
	
	aCreditCardData := Dictionary new.
	
	aCreditCardData
						at: 'owner' put: 'valid name';
						at: 'expiration' put: testObjectsFactory notExpiredDate;
						at: 'number' put: 1234567812345678.

	aCartID := Object new.
	
	self
		should: [interface checkOutCart: aCartID withCreditCard: aCreditCardData]
		raise: Error - MessageNotUnderstood
		withMessageText: interface class invalidCartErrorDescription.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 17:20:27'!
test07CanNotCheckoutWithACreditCardWithEmptyName

	| aCartID aCreditCardData|
	
	authenticationBehaviour _ self passedAuthentication.
	
	aCreditCardData := Dictionary new.
	
	aCreditCardData
						at: 'owner' put: '';
						at: 'expiration' put: testObjectsFactory notExpiredDate;
						at: 'number' put: 1234567812345678.

	aCartID := interface createCartFor: 'user1' with: 'pass1'.
	
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: aCartID.
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	self
		should: [interface checkOutCart: aCartID withCreditCard: aCreditCardData]
		raise: Error - MessageNotUnderstood
		withMessageText: interface class invalidCreditCardErrorDescription.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 17:20:53'!
test08CanNotCheckoutWithACreditCardWithInvalidNumber

	| aCartID aCreditCardData|
	
	authenticationBehaviour _ self passedAuthentication.
	
	aCreditCardData := Dictionary new.
	
	aCreditCardData
						at: 'owner' put: 'valid name';
						at: 'expiration' put: testObjectsFactory notExpiredDate;
						at: 'number' put: 12345678.

	aCartID := interface createCartFor: 'user1' with: 'pass1'.
	
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: aCartID.
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	self
		should: [interface checkOutCart: aCartID withCreditCard: aCreditCardData]
		raise: Error - MessageNotUnderstood
		withMessageText: interface class invalidCreditCardErrorDescription.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 17:38:50'!
test09CanCheckoutAValidCartWithAValidCreditCard

	| aCartID aCreditCardData |
	
	authenticationBehaviour _ self passedAuthentication.
	
	aCreditCardData := Dictionary new.
	
	aCreditCardData
						at: 'owner' put: 'valid name';
						at: 'expiration' put: testObjectsFactory notExpiredDate;
						at: 'number' put: 1234567812345678.

	aCartID := interface createCartFor: 'user1' with: 'pass1'.
	
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: aCartID.
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	self shouldnt: [interface checkOutCart: aCartID withCreditCard: aCreditCardData] raise: Error.
	! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 17:42:00'!
test10CanNotOperateWithCartAfterACheckOut

	| aCartID aCreditCardData |
	
	authenticationBehaviour _ self passedAuthentication.
	
	aCreditCardData := Dictionary new.
	
	aCreditCardData
						at: 'owner' put: 'valid name';
						at: 'expiration' put: testObjectsFactory notExpiredDate;
						at: 'number' put: 1234567812345678.

	aCartID := interface createCartFor: 'user1' with: 'pass1'.
	
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: aCartID.
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	interface checkOutCart: aCartID withCreditCard: aCreditCardData.
	
	self
		should: [interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: aCartID]
		raise: Error
		withMessageText: EditorialSalesSystem invalidCartErrorDescription.
	! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 17:51:46'!
test11CanNotListPurchasesWithInvalidCredentials

	authenticationBehaviour _ self failedAuthentication.
	
	self
		should: [interface listPurchasesOf: 'user1' with: 'pass1']
		raise: Error - MessageNotUnderstood
		withMessageText: interface class invalidCredentialsErrorDescription.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 18:08:30'!
test12CanListPurchasesOfAUserWithNoPurchases

	| purchases |

	authenticationBehaviour _ self passedAuthentication.
	
	purchases := interface listPurchasesOf: 'user1' with: 'pass1'.
	
	self assert: (purchases at: 'items') isEmpty.
	self assert: 0 equals: (purchases at: 'total').! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/22/2020 18:16:16'!
test13ListPurchasesOfAUserAfterACheckOutXXXXXXX

	| purchases book cartID aCreditCardData |

	authenticationBehaviour _ self passedAuthentication.
	
	cartID := interface createCartFor: 'user1' with: 'pass1'.
	
	book := testObjectsFactory itemSellByTheStore.
	
	interface add: 1 of: book toCart: cartID.
	
	aCreditCardData := Dictionary new.
	
	aCreditCardData
						at: 'owner' put: 'valid name';
						at: 'expiration' put: testObjectsFactory notExpiredDate;
						at: 'number' put: 1234567812345678.
	
	interface checkOutCart: cartID withCreditCard: aCreditCardData.
	
	purchases := interface listPurchasesOf: 'user1' with: 'pass1'.
	
	self assert: 1 equals: ((purchases at: 'items') occurrencesOf: book).
	self assert: testObjectsFactory itemSellByTheStorePrice equals: (purchases at: 'total').! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/23/2020 02:51:34'!
test14CanNotAddToCartAfter30MinutesOfLastUsed

	| cartID |
	
	authenticationBehaviour _ self passedAuthentication.
	
	cartID := interface createCartFor: 'user1' with: 'pass1'.
	
	self advanceTime: 31.
	
	self
		should: [interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID]
		raise: Error - MessageNotUnderstood 
		withMessageText: interface class cartSessionExpiredErrorDescription.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/23/2020 02:59:25'!
test15CanNotListCartAfter30MinutesOfLastUsed

	| cartID |
	
	authenticationBehaviour _ self passedAuthentication.
	
	cartID := interface createCartFor: 'user1' with: 'pass1'.
	
	self advanceTime: 31.
	
	self
		should: [interface listCart: cartID]
		raise: Error - MessageNotUnderstood 
		withMessageText: interface class cartSessionExpiredErrorDescription.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/23/2020 03:02:24'!
test16CanNotCheckOutCartAfter30MinutesOfLastUsed

	| cartID aCreditCardData|
	
	authenticationBehaviour _ self passedAuthentication.
	
	cartID := interface createCartFor: 'user1' with: 'pass1'.
	
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	self advanceTime: 31.
	
	aCreditCardData := Dictionary new.
	
	aCreditCardData
						at: 'owner' put: 'valid name';
						at: 'expiration' put: testObjectsFactory notExpiredDate;
						at: 'number' put: 1234567812345678.
	
	self
		should: [interface checkOutCart: cartID withCreditCard: aCreditCardData]
		raise: Error - MessageNotUnderstood 
		withMessageText: interface class cartSessionExpiredErrorDescription.! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/23/2020 03:04:35'!
test17AddingAnItemToACartExtendsItsSessionTime

	| cartID aCreditCardData|
	
	authenticationBehaviour _ self passedAuthentication.
	
	cartID := interface createCartFor: 'user1' with: 'pass1'.
	
	self advanceTime: 29.
	
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	
	self advanceTime: 5.
	
	aCreditCardData := Dictionary new.
	
	aCreditCardData
						at: 'owner' put: 'valid name';
						at: 'expiration' put: testObjectsFactory notExpiredDate;
						at: 'number' put: 1234567812345678.
	
	self
		shouldnt: [interface checkOutCart: cartID withCreditCard: aCreditCardData]
		raise: Error - MessageNotUnderstood! !

!SystemInterfaceTest methodsFor: 'tests' stamp: 'FML 7/23/2020 03:10:36'!
test18ListingACartExtendsItsSessionTime

	| cartID |
	
	authenticationBehaviour _ self passedAuthentication.
	
	cartID := interface createCartFor: 'user1' with: 'pass1'.
	
	self advanceTime: 29.
	
	interface listCart: cartID.
	
	self advanceTime: 5.
	
	self
		shouldnt: [interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID]
		raise: Error - MessageNotUnderstood! !


!SystemInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'FML 7/23/2020 02:38:41'!
setUp

	| editorial |

	testObjectsFactory := StoreTestObjectsFactory new.
	
	editorial := EditorialSalesSystem
											for: testObjectsFactory defaultCatalog
											validatingSalesWith: self.
											
	interface := SystemInterface for: editorial authenticatingThrough: self gettingTimeFrom: self.
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	now := DateAndTime now.! !


!SystemInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'FML 7/22/2020 17:09:18'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!SystemInterfaceTest methodsFor: 'authentication system protocol' stamp: 'FML 7/22/2020 14:27:32'!
authenticate: aUser and: aPassword

	^authenticationBehaviour value.
	
	! !

!SystemInterfaceTest methodsFor: 'authentication system protocol' stamp: 'FML 7/22/2020 14:28:22'!
failedAuthentication
	
	^[false]! !

!SystemInterfaceTest methodsFor: 'authentication system protocol' stamp: 'FML 7/22/2020 14:33:26'!
passedAuthentication
	
	^[true]! !


!SystemInterfaceTest methodsFor: 'clock protocol' stamp: 'FML 7/23/2020 02:43:21'!
advanceTime: anAmountOfMinutes
	
	now _ now + (Duration minutes: anAmountOfMinutes).! !

!SystemInterfaceTest methodsFor: 'clock protocol' stamp: 'FML 7/23/2020 02:46:29'!
now
	
	^now! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'FML 7/22/2020 15:01:51'!
list
	
	^items copy! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


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
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'FML 7/23/2020 02:16:14'!
createSale

	^ Sale ofItems: cart list andTotal: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'FML 7/23/2020 00:48:00'!
registerSale

	^salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'FML 7/23/2020 00:48:48'!
checkOut

	| sale |

	self calculateTotal.
	self debitTotal.
	sale := self registerSale.

	^sale! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !



!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'FML 7/22/2020 16:45:00'!
initializeFor: anOwner expiringOn: aMonth withNumber: aNumber  
	
	expiration := aMonth.
	owner := anOwner.
	number := aNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FML 7/22/2020 16:44:30'!
for: anOwner expiringOn: aMonth withNumber: aNumber  
	
	^self new initializeFor: anOwner expiringOn: aMonth withNumber: aNumber! !


!classDefinition: #EditorialSalesSystem category: #TusLibros!
Object subclass: #EditorialSalesSystem
	instanceVariableNames: 'catalog merchantProcessor activeCarts salesBook cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!EditorialSalesSystem methodsFor: 'initialization' stamp: 'FML 7/23/2020 02:20:37'!
initializeFor: aCatalog validatingSalesWith: aMerchantProcessor   
	
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	activeCarts := Dictionary new.
	salesBook := OrderedCollection new.
	cartSessions := Dictionary new.! !


!EditorialSalesSystem methodsFor: 'operations' stamp: 'FML 7/23/2020 00:31:10'!
addCart: aCart withID: aCartID

	activeCarts at: aCartID put: aCart
	! !

!EditorialSalesSystem methodsFor: 'operations' stamp: 'FML 7/22/2020 14:59:02'!
catalog
	
	^catalog copy! !

!EditorialSalesSystem methodsFor: 'operations' stamp: 'FML 7/23/2020 02:12:20'!
checkout: aCart withCreditCard: aCreditCard 
	
	| cashier |
	
	cashier := Cashier
						toCheckout: aCart
						charging: aCreditCard
						throught: merchantProcessor
						on: Date today
						registeringOn: salesBook.
	
	^cashier checkOut.! !

!EditorialSalesSystem methodsFor: 'operations' stamp: 'FML 7/23/2020 00:31:10'!
invalidateCart: aCartID
	
	activeCarts removeKey: aCartID! !

!EditorialSalesSystem methodsFor: 'operations' stamp: 'FML 7/23/2020 02:11:00'!
itemsOf: aCartID
	
	^(cartSessions at: aCartID) items! !

!EditorialSalesSystem methodsFor: 'operations' stamp: 'FML 7/23/2020 02:00:09'!
saveSession: aSale for: aCartID

	cartSessions at: aCartID put: aSale.! !

!EditorialSalesSystem methodsFor: 'operations' stamp: 'FML 7/23/2020 02:17:32'!
totalOf: aCartID

	^(cartSessions at: aCartID) total
	
	! !

!EditorialSalesSystem methodsFor: 'operations' stamp: 'FML 7/23/2020 00:31:10'!
withCartID: aCartID do: aBlockClosure
	
	^aBlockClosure value: (activeCarts at: aCartID ifAbsent: [self signalInvalidCartError])! !


!EditorialSalesSystem methodsFor: 'error handling' stamp: 'FML 7/22/2020 15:59:28'!
signalInvalidCartError
	
	self error: self class invalidCartErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EditorialSalesSystem class' category: #TusLibros!
EditorialSalesSystem class
	instanceVariableNames: ''!

!EditorialSalesSystem class methodsFor: 'instance creation' stamp: 'FML 7/23/2020 02:20:51'!
for: aCatalog validatingSalesWith: aMerchantProcessor  

	^self new initializeFor: aCatalog validatingSalesWith: aMerchantProcessor ! !


!EditorialSalesSystem class methodsFor: 'error handling' stamp: 'FML 7/22/2020 15:57:52'!
invalidCartErrorDescription
	
	^'Ivalid cart'! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'queries' stamp: 'FML 7/23/2020 02:16:43'!
items

	^items! !

!Sale methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'FML 7/23/2020 02:15:00'!
initializeOfItems: aBagOfItems andTotal: aTotal

	total := aTotal.
	items := aBagOfItems.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'FML 7/23/2020 02:15:14'!
ofItems: aBagOfItems andTotal: aTotal

	^self new initializeOfItems: aBagOfItems andTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FML 7/22/2020 16:44:16'!
expiredCreditCard
	
	^CreditCard for: 'valid name' expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withNumber: 1234567812345678! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FML 7/22/2020 16:44:16'!
notExpiredCreditCard
	
	^CreditCard for: 'valid name' expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withNumber: 1234567812345678! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FML 7/22/2020 16:47:53'!
notExpiredDate
	
	^Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #SystemInterface category: #TusLibros!
Object subclass: #SystemInterface
	instanceVariableNames: 'editorial authenticationSystem nextCartID clientSessions clock expiringTimes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemInterface methodsFor: 'initialization' stamp: 'FML 7/23/2020 02:47:32'!
initializeFor: anEditorialSalesSystem authenticatingThrough: anAuthenticationSystem gettingTimeFrom: aClock 
	
	editorial := anEditorialSalesSystem.
	
	authenticationSystem := anAuthenticationSystem.
	
	nextCartID := 1.
	
	clientSessions := Dictionary new.
	
	clock := aClock.
	
	expiringTimes := Dictionary new.! !


!SystemInterface methodsFor: 'assertions' stamp: 'FML 7/22/2020 17:23:41'!
assertCorrectCreditCardData: aCreditCardData

	self assertValidName: (aCreditCardData at: 'owner' ifAbsent: [self signalInvalidCreditCardError]).
	self assertValidNumber: (aCreditCardData at: 'number' ifAbsent: [self signalInvalidCreditCardError]).
	aCreditCardData at: 'expiration' ifAbsent: [self signalInvalidCreditCardError]
	
	! !

!SystemInterface methodsFor: 'assertions' stamp: 'FML 7/23/2020 02:56:01'!
assertValidCart: aCartID
	
	(expiringTimes at: aCartID ifAbsent: [self signalInvalidCartError]) < clock now ifTrue: [self signalCartSessionExpiredError]! !

!SystemInterface methodsFor: 'assertions' stamp: 'FML 7/22/2020 17:19:31'!
assertValidName: aCreditCardName
	
	aCreditCardName ifEmpty: [self signalInvalidCreditCardError]! !

!SystemInterface methodsFor: 'assertions' stamp: 'FML 7/22/2020 17:21:42'!
assertValidNumber: aCreditCardNumber
	
	(aCreditCardNumber decimalDigitLength = 16) ifFalse: [self signalInvalidCreditCardError]! !


!SystemInterface methodsFor: 'error handling' stamp: 'FML 7/23/2020 02:52:36'!
signalCartSessionExpiredError
	
	self error: self class cartSessionExpiredErrorDescription! !

!SystemInterface methodsFor: 'error handling' stamp: 'FML 7/23/2020 02:54:51'!
signalInvalidCartError
	
	self error: self class invalidCartErrorDescription! !

!SystemInterface methodsFor: 'error handling' stamp: 'FML 7/22/2020 14:28:48'!
signalInvalidCredentialsError
	
	self error: self class invalidCredentialsErrorDescription.! !

!SystemInterface methodsFor: 'error handling' stamp: 'FML 7/22/2020 17:19:52'!
signalInvalidCreditCardError
	
	self error: self class invalidCreditCardErrorDescription! !


!SystemInterface methodsFor: 'rest protocol - private' stamp: 'FML 7/23/2020 01:32:47'!
associate: aCartID to: aClientID

	clientSessions at: aClientID
						ifPresent: [ :aCollectionOfCarts | aCollectionOfCarts add: aCartID]
						ifAbsent: [ | carts |
										carts := OrderedCollection new.
										carts add: aCartID.
										clientSessions at: aClientID put: carts.
									]
	
	! !

!SystemInterface methodsFor: 'rest protocol - private' stamp: 'FML 7/22/2020 16:49:28'!
convertToCreditCard: aCreditCardData
	
	^CreditCard
				for: (aCreditCardData at: 'owner')
				expiringOn: (aCreditCardData at: 'expiration')
				withNumber: (aCreditCardData at: 'number').! !

!SystemInterface methodsFor: 'rest protocol - private' stamp: 'FML 7/23/2020 02:10:13'!
listPurchasesOf: aClientID
	
	| sessions purchases total items|
	
	sessions := clientSessions at: aClientID ifAbsent: [OrderedCollection new].
	
	purchases := Dictionary new.
	
	total := 0.
	
	items := Bag new.
	
	sessions do: [ :aCartID | items addAll: (editorial itemsOf: aCartID).
								   total _ total + (editorial totalOf: aCartID).
					].
	
	purchases at: 'total' put: total.
	purchases at: 'items' put: items.
	
	^purchases
							
	
	
	! !

!SystemInterface methodsFor: 'rest protocol - private' stamp: 'FML 7/23/2020 03:08:13'!
saveExpirationTimeOf: aCartID.

	expiringTimes at: aCartID put: clock now + (Duration minutes: 30).! !


!SystemInterface methodsFor: 'rest protocol' stamp: 'FML 7/23/2020 03:08:30'!
add: anAmount of: anISBN toCart: aCartID

	self assertValidCart: aCartID.

	editorial withCartID: aCartID do: [ :aCart | aCart add: anAmount of: anISBN].
	
	self saveExpirationTimeOf: aCartID.! !

!SystemInterface methodsFor: 'rest protocol' stamp: 'FML 7/23/2020 03:02:56'!
checkOutCart: aCartID withCreditCard: aCreditCardData

	| creditCard sale |
	
	self assertValidCart: aCartID.
	
	self assertCorrectCreditCardData: aCreditCardData.
	
	creditCard := self convertToCreditCard: aCreditCardData.
	
	editorial withCartID: aCartID do: [ :aCart | sale := editorial checkout: aCart withCreditCard: creditCard.
														  editorial saveSession: sale for: aCartID.
														  editorial invalidateCart: aCartID].! !

!SystemInterface methodsFor: 'rest protocol' stamp: 'FML 7/23/2020 03:07:51'!
createCartFor: aClientID with: aPassword

	| cart cartID |

	(authenticationSystem authenticate: aClientID and: aPassword) ifFalse: [self signalInvalidCredentialsError].
	
	cart := Cart acceptingItemsOf: editorial catalog.
	
	cartID := nextCartID.
	
	self associate: cartID to: aClientID.
	
	editorial addCart: cart withID: cartID.
	
	nextCartID _ nextCartID + 1.
	
	self saveExpirationTimeOf: cartID.
	
	^cartID! !

!SystemInterface methodsFor: 'rest protocol' stamp: 'FML 7/23/2020 03:11:19'!
listCart: aCartID

	self assertValidCart: aCartID.
	
	self saveExpirationTimeOf: aCartID.
	
	^editorial withCartID: aCartID do: [ :aCart | aCart list]! !

!SystemInterface methodsFor: 'rest protocol' stamp: 'FML 7/23/2020 01:35:32'!
listPurchasesOf: aClientID with: aPassword

	(authenticationSystem authenticate: aClientID and: aPassword) ifFalse: [self signalInvalidCredentialsError].
	
	^self listPurchasesOf: aClientID.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemInterface class' category: #TusLibros!
SystemInterface class
	instanceVariableNames: ''!

!SystemInterface class methodsFor: 'instance creation' stamp: 'FML 7/23/2020 02:37:13'!
for: anEditorialSalesSystem authenticatingThrough: anAuthenticationSystem gettingTimeFrom: aClock 

	^self new initializeFor: anEditorialSalesSystem authenticatingThrough: anAuthenticationSystem gettingTimeFrom: aClock.! !


!SystemInterface class methodsFor: 'error handling' stamp: 'FML 7/23/2020 02:43:45'!
cartSessionExpiredErrorDescription
	
	^'The Cart has expired'! !

!SystemInterface class methodsFor: 'error handling' stamp: 'FML 7/23/2020 02:55:06'!
invalidCartErrorDescription
	
	^'Invalid Cart'! !

!SystemInterface class methodsFor: 'error handling' stamp: 'FML 7/22/2020 14:21:38'!
invalidCredentialsErrorDescription
	
	^'Ivalid user and/or password'! !

!SystemInterface class methodsFor: 'error handling' stamp: 'FML 7/22/2020 17:12:21'!
invalidCreditCardErrorDescription
	
	^'Invalid Credit Card'! !
