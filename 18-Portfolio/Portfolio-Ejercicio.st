!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'aPortfolio anAccount anotherAccount aSubPortfolio anotherSubPortfolio yetAnotherAccount anotherPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:11'!
test01EmptyPortfolioShouldHaveBalanceOf0
	
	self assert: aPortfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:11'!
test02NewPortfolioShouldHaveNoParentAccount
	
	self assert: aPortfolio parentAccounts size equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:27'!
test03NewReceptiveAccountShouldHaveNoParentAccount
	
	self assert: anAccount parentAccounts size equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:47:05'!
test04CorrectParentAccountWhenAddingAccountToPortfolio

	aPortfolio addAccount: anAccount.
	
	self assert: anAccount parentAccounts size equals: 1.
	self assert: anAccount parentAccounts includes: aPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:27'!
test05PortfolioWithOneAccountShouldHaveTheAccountsBalance

	aPortfolio addAccount: anAccount.
	Deposit register: 40 on: anAccount. 
	
	self assert: aPortfolio balance equals: 40.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:35'!
test06PortfolioWithTwoAccountShouldHaveTheAccountsBalanceSum
		
	aPortfolio addAccount: anAccount.
	aPortfolio addAccount: anotherAccount.
	
	Deposit register: 40 on: anAccount. 
	Withdraw register: 12 on: anotherAccount.
	
	self assert: aPortfolio balance equals: 28.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:47'!
test07PortfolioWithAnAccountAndPortfolioShouldHaveTheAccountAndPortfolioBalanceSum
		
	aPortfolio addAccount: anAccount.
	aSubPortfolio addAccount: anotherAccount.
	aPortfolio addAccount: aSubPortfolio.
	
	Deposit register: 40 on: anAccount. 
	Withdraw register: 12 on: anotherAccount.
	
	self assert: aPortfolio balance equals: 28.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:42:10'!
test08PortfolioWithTwoPortfoliosShouldHaveThePortfoliosBalanceSum

	aPortfolio addAccount: anAccount.
	aSubPortfolio addAccount: anotherAccount.
	aPortfolio addAccount: aSubPortfolio.
	aSubPortfolio addAccount: anotherSubPortfolio.
	anotherSubPortfolio addAccount: yetAnotherAccount.
	
	Deposit register: 40 on: anAccount. 
	Withdraw register: 12 on: anotherAccount.
	Deposit register: 23 on: yetAnotherAccount.
	
	self assert: aPortfolio balance equals: 51.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:42:02'!
test09CanNotAddAnAcountToTwoPortfoliosWithTheSameParent
			
	aPortfolio addAccount: aSubPortfolio.
	aPortfolio addAccount: anotherSubPortfolio.
	
	aSubPortfolio addAccount: anAccount.
	
	self should: [anotherSubPortfolio addAccount: anAccount]
	raise: Error
	withMessageText: anotherSubPortfolio class accountCycleErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:27'!
test10CanNotAddAnAcountToAPortfolioThatAlreadyHasThatAccount

	aPortfolio addAccount: anAccount.
	
	self should: [aPortfolio addAccount: anAccount]
	raise: Error
	withMessageText: aPortfolio class accountCycleErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:11'!
test11CanNotAddPortfolioToItself
	
	self should: [aPortfolio addAccount: aPortfolio ]
	raise: Error
	withMessageText: aPortfolio class accountCycleErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:47'!
test12CanNotAddAPortfolioToAPortfolioThatAlreadyHasThatPortfolio
	
	aPortfolio addAccount: aSubPortfolio.
	
	self should: [aPortfolio addAccount: aSubPortfolio ]
	raise: Error
	withMessageText: aPortfolio class accountCycleErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:41:47'!
test13CanNotAddAPortfolioWithAnAccountToAPortfolioThatAlreadyHasThatAccount
	
	aPortfolio addAccount: anAccount.
	aSubPortfolio addAccount: anAccount.
	
	self should: [aPortfolio addAccount: aSubPortfolio ]
	raise: Error
	withMessageText: aPortfolio class accountCycleErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:42:15'!
test14TwoPortfoliosCanHaveTheSameAccount

	aPortfolio addAccount: anAccount.
	anotherPortfolio addAccount: anAccount.
	
	Deposit register: 50 on: anAccount.
	
	self assert: 50 equals: aPortfolio balance.
	self assert: 50 equals: anotherPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'FML 6/22/2020 16:44:14'!
test15CanNotAddAportfolioWithAnAccountToAPortfolioThatHasAnotherPortfolioWithThatAccount

	aPortfolio addAccount: aSubPortfolio.
	aSubPortfolio addAccount: anAccount.
	
	anotherSubPortfolio addAccount: anAccount.
	
	self should: [aPortfolio addAccount: anotherSubPortfolio ]
	raise: Error
	withMessageText: aPortfolio class accountCycleErrorDescription.


	! !


!PortfolioTest methodsFor: 'setUp/tearDown' stamp: 'FML 6/22/2020 16:45:44'!
setUp

	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	aSubPortfolio := Portfolio new.
	anotherSubPortfolio := Portfolio new.
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	yetAnotherAccount := ReceptiveAccount new.! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 6/18/2020 17:33:13'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AbstractAccount category: #'Portfolio-Ejercicio'!
Object subclass: #AbstractAccount
	instanceVariableNames: 'parentAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AbstractAccount methodsFor: 'initialization' stamp: 'Gaston 6/20/2020 16:16:15'!
initialize
	
	parentAccounts := OrderedCollection new.! !


!AbstractAccount methodsFor: 'transactions - private' stamp: 'Gaston 6/20/2020 16:12:12'!
addParentAccount: anAccount

	parentAccounts add: anAccount.! !

!AbstractAccount methodsFor: 'transactions - private' stamp: 'FML 6/22/2020 15:39:07'!
getRecursiveParents
	
	| recursiveParents |
	
	recursiveParents := Set new.
	
	parentAccounts do: [:parent | parent ifNotNil: [recursiveParents add: parent]].
	parentAccounts do: [:parent | parent getRecursiveParents do: [:recursiveParent | recursiveParent ifNotNil: [recursiveParents add: recursiveParent]]].
	
	recursiveParents ifEmpty: (recursiveParents add: self).
	
	^recursiveParents! !

!AbstractAccount methodsFor: 'transactions - private' stamp: 'Gaston 6/20/2020 16:13:57'!
parentAccounts

	^parentAccounts.! !


!AbstractAccount methodsFor: 'transactions' stamp: 'Gaston 6/20/2020 15:41:52'!
balance
	
	^self transactions inject: 0 into: [:balance :transaction | transaction applyToBalance: balance].! !

!AbstractAccount methodsFor: 'transactions' stamp: 'Gaston 6/19/2020 18:33:07'!
transactions

	self subclassResponsibility.! !


!AbstractAccount methodsFor: 'testing' stamp: 'FML 6/22/2020 16:06:20'!
getAccounts

	self subclassResponsibility! !

!AbstractAccount methodsFor: 'testing' stamp: 'Gaston 6/19/2020 18:33:03'!
hasRegistered: aTransaction

	self subclassResponsibility.! !

!AbstractAccount methodsFor: 'testing' stamp: 'FML 6/22/2020 15:58:37'!
includesAccount: anAccount

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
AbstractAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'transactions - private' stamp: 'FML 6/22/2020 15:59:04'!
isAbleToAddAccount: anAccount
	
	self getRecursiveParents detect: [:aParent | aParent includesAccountFrom: anAccount] ifNone: [^true].
	
	^false! !


!Portfolio methodsFor: 'testing' stamp: 'FML 6/22/2020 16:24:43'!
getAccounts

	|collectionOfAccounts|
	
	collectionOfAccounts := OrderedCollection new.
	
	collectionOfAccounts add: self.

	accounts do: [:anAccount | collectionOfAccounts addAll: anAccount getAccounts].
	
	^collectionOfAccounts ! !

!Portfolio methodsFor: 'testing' stamp: 'Gaston 6/19/2020 18:47:48'!
hasRegistered: aTransaction

	accounts detect: [:account | account hasRegistered: aTransaction] ifNone: [^false].
	
	^true.
	
	! !

!Portfolio methodsFor: 'testing' stamp: 'FML 6/22/2020 15:58:37'!
includesAccount: anAccount

	^(self = anAccount) or: [(accounts includes: anAccount) or: [accounts anySatisfy: [:anotherAccount | anotherAccount includesAccount: anAccount]]]! !

!Portfolio methodsFor: 'testing' stamp: 'FML 6/22/2020 16:05:53'!
includesAccountFrom: anAccount

	^anAccount getAccounts anySatisfy: [:account | self includesAccount: account].! !


!Portfolio methodsFor: 'transactions' stamp: 'Gaston 6/20/2020 16:45:13'!
addAccount: anAccount
	
	(self isAbleToAddAccount: anAccount) ifTrue: [
		accounts add: anAccount.
		anAccount addParentAccount: self.
	] ifFalse: [
		self accountCycleErrorSignal. 
	].
	! !

!Portfolio methodsFor: 'transactions' stamp: 'Gaston 6/19/2020 18:39:48'!
transactions
	
	^accounts inject: Set new into: [:transactionsAcumulator :account | transactionsAcumulator union: account transactions].
	
	! !


!Portfolio methodsFor: 'error handling' stamp: 'Gaston 6/20/2020 16:39:30'!
accountCycleErrorSignal
	
	self error: self class accountCycleErrorDescription.
	! !


!Portfolio methodsFor: 'initialization' stamp: 'Gaston 6/20/2020 16:17:01'!
initialize
	
	super initialize.
	accounts := OrderedCollection new.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'Gaston 6/20/2020 16:38:55'!
accountCycleErrorDescription

	^'Adding this account would generate an account cycle'.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
AbstractAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Gaston 6/20/2020 16:16:32'!
initialize
	
	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'FML 6/22/2020 16:25:04'!
getAccounts

	^OrderedCollection with: self! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'FML 6/22/2020 15:58:37'!
includesAccount: anAccount

	^self = anAccount! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'Gaston 6/19/2020 18:13:33'!
applyToBalance: aBalance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'Gaston 6/19/2020 18:14:05'!
applyToBalance: aBalance

	^aBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'Gaston 6/19/2020 18:14:16'!
applyToBalance: aBalance

	^aBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
