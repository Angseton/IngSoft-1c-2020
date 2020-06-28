!classDefinition: #PortfolioTest category: #'Portfolio2-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio2-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: #'Portfolio2-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'FML 6/26/2020 13:30:54'!
test01NewAccountHasAnEmptyAccountSummary

	| account accountSummary|
	
	account := ReceptiveAccount new.
	
	accountSummary := AccountSummaryReport for: account.
	
	self assert: accountSummary printReport isEmpty.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'FML 6/26/2020 13:30:54'!
test02AccountWithADepositHasACorrectAccountSummary

	| account accountSummary|
	
	account := ReceptiveAccount new.
	
	Deposit register: 20 on: account.
	
	accountSummary := AccountSummaryReport for: account.
	
	self assert: 1 equals: accountSummary printReport size.
	self assert: accountSummary printReport includes: 'Depósito por 20.'! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'FML 6/26/2020 13:30:54'!
test03AccountWithDepositAndWithdrawalsHasACorrectAccountSummary

	| account accountSummary|
	
	account := ReceptiveAccount new.
	
	Deposit register: 20 on: account.
	
	Withdraw register: 10 on: account.
	
	accountSummary := AccountSummaryReport for: account.
	
	self assert: 2 equals: accountSummary printReport size.
	self assert: accountSummary printReport includes: 'Depósito por 20.'.
	self assert: accountSummary printReport includes: 'Extracción por 10.'.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'FML 6/26/2020 13:30:54'!
test04AccountWithTransfersHasACorrectAccountSummary

	| account accountSummary anotherAccount anotherAccountSummary|
	
	account := ReceptiveAccount new.
	
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 200 on: account.
	
	Transfer register: 50 from: account to: anotherAccount.
	
	accountSummary := AccountSummaryReport for: account.
		
	self assert: 2 equals: accountSummary printReport size.
	self assert: accountSummary printReport includes: 'Salida por transferencia de 50.'.
	
	anotherAccountSummary := AccountSummaryReport for: anotherAccount.
	
	self assert: 1 equals: anotherAccountSummary printReport size.
	self assert: anotherAccountSummary printReport includes: 'Entrada por transferencia de 50.'.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'FML 6/26/2020 13:30:54'!
test05AccountWithNoTransfersShouldHaveATransferNetOf0

	| account transferNet |
	
	account := ReceptiveAccount new.
	
	Deposit register: 300 on: account.
	
	Withdraw register: 160 on: account.
	
	transferNet := TransferNetReport for: account.
	
	self assert: 0 equals: transferNet printReport.
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'FML 6/26/2020 13:30:54'!
test06AccountWithAnIcnomingTransferShouldHaveACorrectTransferNet

	| account transferNet anotherAccount|
	
	account := ReceptiveAccount new.
	
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 300 on: account.
	
	Transfer register: 120 from: account to: anotherAccount.
	
	transferNet := TransferNetReport for: anotherAccount.
	
	self assert: 120 equals: transferNet printReport.
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'FML 6/26/2020 13:30:54'!
test07AccountWithAnOutgoingTransferShouldHaveACorrectTransferNet

	| account transferNet anotherAccount|
	
	account := ReceptiveAccount new.
	
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 300 on: account.
	
	Transfer register: 120 from: account to: anotherAccount.
	
	transferNet := TransferNetReport for: account.
	
	self assert: -120 equals: transferNet printReport.
	
	! !


!classDefinition: #TransferTest category: #'Portfolio2-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FML 6/25/2020 16:38:31'!
test01TransferAffectsCorrectlyBothAccounts

	| aSenderReceptiveAccount aRecieverReceptiveAccount |
	
	aSenderReceptiveAccount := ReceptiveAccount new.
	aRecieverReceptiveAccount := ReceptiveAccount new.
	
	Deposit register: 200 on: aSenderReceptiveAccount.
	
	Transfer register: 100 from: aSenderReceptiveAccount to: aRecieverReceptiveAccount.
	
	self assert: 100 equals: aSenderReceptiveAccount balance.
	self assert: 100 equals: aRecieverReceptiveAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'Gaston 6/28/2020 16:03:56'!
test02CannotTransferNegativeOrZeroAmountOfMoney

	| aSenderReceptiveAccount aRecieverReceptiveAccount |
	
	aSenderReceptiveAccount := ReceptiveAccount new.
	aRecieverReceptiveAccount := ReceptiveAccount new.
	
	self should: [Transfer register: -1 from: aSenderReceptiveAccount to: aRecieverReceptiveAccount.]
		 raise: Error
		 description: Transfer invalidTransferValueErrorDescription.! !


!classDefinition: #Account category: #'Portfolio2-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio2-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio2-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio2-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #'Portfolio2-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'FML 6/26/2020 19:10:21'!
affectReport: aReport

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio2-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'FML 6/26/2020 19:26:33'!
value

	^value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'FML 6/26/2020 19:15:52'!
affectReport: aReport

	aReport registerDepositWithValue: value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio2-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: #'Portfolio2-Ejercicio'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferTransaction methodsFor: 'legBrowsing' stamp: 'Gaston 6/28/2020 15:40:23'!
getTheOtherLeg
	
	self subclassResponsibility! !


!TransferTransaction methodsFor: 'initialization' stamp: 'Gaston 6/28/2020 15:43:06'!
initializeOf: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: #'Portfolio2-Ejercicio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'Gaston 6/28/2020 15:43:14'!
of: aTransfer

	^self new initializeOf: aTransfer! !


!classDefinition: #IncomingTransfer category: #'Portfolio2-Ejercicio'!
TransferTransaction subclass: #IncomingTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!IncomingTransfer methodsFor: 'value' stamp: 'FML 6/25/2020 19:09:03'!
value

	^transfer value! !


!IncomingTransfer methodsFor: 'balance' stamp: 'FML 6/25/2020 19:09:44'!
affectBalance: aBalance

	^aBalance + self value! !


!IncomingTransfer methodsFor: 'report' stamp: 'FML 6/26/2020 19:19:32'!
affectReport: aReport

	aReport registerIncomingTransferWithValue: self value.! !


!IncomingTransfer methodsFor: 'legBrowsing' stamp: 'Gaston 6/28/2020 15:41:15'!
getTheOtherLeg
	
	^transfer getOutgoingLeg.! !


!classDefinition: #OutgoingTransfer category: #'Portfolio2-Ejercicio'!
TransferTransaction subclass: #OutgoingTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!OutgoingTransfer methodsFor: 'value' stamp: 'FML 6/25/2020 19:09:13'!
value

	^transfer value! !


!OutgoingTransfer methodsFor: 'balance' stamp: 'FML 6/25/2020 19:10:04'!
affectBalance: aBalance

	^aBalance - self value! !


!OutgoingTransfer methodsFor: 'report' stamp: 'FML 6/26/2020 19:19:24'!
affectReport: aReport

	aReport registerOutgoingTransferWithValue: self value.! !


!OutgoingTransfer methodsFor: 'legBrowsing' stamp: 'Gaston 6/28/2020 15:41:29'!
getTheOtherLeg
	
	^transfer getIncomingLeg.! !


!classDefinition: #Withdraw category: #'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'FML 6/26/2020 19:26:52'!
value

	^value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'FML 6/26/2020 19:19:15'!
affectReport: aReport

	aReport registerWithdrawWithValue: value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio2-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'Portfolio2-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Report methodsFor: 'report' stamp: 'FML 6/26/2020 13:30:54'!
printReport

	self subclassResponsibility! !


!Report methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:20:06'!
registerDepositWithValue: aValue

	self subclassResponsibility! !

!Report methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:20:30'!
registerIncomingTransferWithValue: aValue

	self subclassResponsibility! !

!Report methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:20:36'!
registerOutgoingTransferWithValue: aValue

	self subclassResponsibility! !

!Report methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:20:22'!
registerWithdrawWithValue: aValue

	self subclassResponsibility! !

!Report methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:06:03'!
reportFor: anAccount

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'Portfolio2-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'FML 6/25/2020 20:42:42'!
for: aReceptiveAccount

	^self new initializeFor: aReceptiveAccount! !


!classDefinition: #AccountSummaryReport category: #'Portfolio2-Ejercicio'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummaryReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:27:30'!
initializeFor: anAccount

	| transactions |

	transactions := anAccount transactions.
	
	report := Set new.
	
	transactions do: [ :aTransaction | aTransaction affectReport: self].! !

!AccountSummaryReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:21:40'!
registerDepositWithValue: aValue

	report add: 'Depósito por ', aValue asString, '.'.! !

!AccountSummaryReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:22:19'!
registerIncomingTransferWithValue: aValue

	report add: 'Entrada por transferencia de ', aValue asString, '.'.! !

!AccountSummaryReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:22:29'!
registerOutgoingTransferWithValue: aValue

	report add: 'Salida por transferencia de ', aValue asString, '.'.! !

!AccountSummaryReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:21:56'!
registerWithdrawWithValue: aValue

	report add: 'Extracción por ', aValue asString, '.'.! !


!AccountSummaryReport methodsFor: 'report' stamp: 'FML 6/26/2020 13:33:12'!
printReport

	^report! !


!classDefinition: #TransferNetReport category: #'Portfolio2-Ejercicio'!
Report subclass: #TransferNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferNetReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:28:08'!
initializeFor: anAccount

	| transactions |

	transactions := anAccount transactions.
	
	report := 0.
	
	transactions do: [ :aTransaction | aTransaction affectReport: self].! !

!TransferNetReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:25:59'!
registerDepositWithValue: aValue! !

!TransferNetReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:24:14'!
registerIncomingTransferWithValue: aValue

	report _ report + aValue.! !

!TransferNetReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:24:23'!
registerOutgoingTransferWithValue: aValue

	report _ report - aValue.! !

!TransferNetReport methodsFor: 'initialization' stamp: 'FML 6/26/2020 19:26:04'!
registerWithdrawWithValue: aValue! !


!TransferNetReport methodsFor: 'report' stamp: 'FML 6/26/2020 13:33:12'!
printReport
	
	^report.! !


!classDefinition: #Transfer category: #'Portfolio2-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'incoming outgoing value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Transfer methodsFor: 'legBrowsing' stamp: 'Gaston 6/28/2020 15:36:25'!
getIncomingLeg

	^incoming.
	! !

!Transfer methodsFor: 'legBrowsing' stamp: 'Gaston 6/28/2020 15:36:51'!
getOutgoingLeg

	^outgoing.
	! !


!Transfer methodsFor: 'initialization' stamp: 'FML 6/25/2020 19:08:35'!
initializeFor: aValue from: aSenderReceptiveAccount to: aRecieverReceptiveAccount
	
	value := aValue.
	
	incoming := IncomingTransfer of: self.
	
	outgoing := OutgoingTransfer of: self.
	
	aSenderReceptiveAccount register: outgoing.
	
	aRecieverReceptiveAccount register: incoming.
	! !


!Transfer methodsFor: 'value' stamp: 'FML 6/25/2020 19:14:00'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio2-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'Gaston 6/28/2020 15:53:10'!
register: aValue from: aSenderReceptiveAccount to: aRecieverReceptiveAccount
	
	self assertValidTransferValue: aValue. 
	
	^self new initializeFor: aValue from: aSenderReceptiveAccount to: aRecieverReceptiveAccount.! !


!Transfer class methodsFor: 'error handling' stamp: 'Gaston 6/28/2020 16:03:09'!
assertValidTransferValue: aValue
	
	aValue > 0 ifFalse: [self error: self invalidTransferValueErrorDescription].! !

!Transfer class methodsFor: 'error handling' stamp: 'Gaston 6/28/2020 16:02:50'!
invalidTransferValueErrorDescription
	
	^'Invalid transfer value: Transfer value should be positive'.! !
