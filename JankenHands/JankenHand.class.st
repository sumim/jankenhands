Class {
	#name : 'JankenHand',
	#superclass : 'Object',
	#classInstVars : [
		'greaterHand'
	],
	#category : 'JankenHands-Core',
	#package : 'JankenHands',
	#tag : 'Core'
}

{ #category : 'comparing' }
JankenHand class >> < other [
	^ (other isKindOf: self class superclass) and: [ self ~~ other and: [ greaterHand == other ] ]
]

{ #category : 'comparing' }
JankenHand class >> > other [
	^ self ~~ other and: [ (self < other) not ]
]

{ #category : 'examples' }
JankenHand class >> NPlayersV1: N [ "JankenHand NPlayersV1: 10"
	| roundCount playerHands handAndCounts greaterHand winner |
	JankenHand openTranscript.
	roundCount := 0.
	[	roundCount := roundCount + 1.
		playerHands := (1 to: N) collect: [ :n | n -> JankenHand Pon ].
		Transcript cr; show: 'Hands: '; show: playerHands.
		handAndCounts := (playerHands collect: #value) asBag sortedElements.
		handAndCounts size = 2 and: [ handAndCounts last value = 1 ]
	] whileFalse.
	greaterHand := handAndCounts last key.
	winner := playerHands detect: [ :p | p value = greaterHand ].
	Transcript cr; 
		show: 'Round: ', roundCount printString;
		show: ', Win: ', winner key printString.
]

{ #category : 'examples' }
JankenHand class >> NPlayersV2: N [ "JankenHand NPlayersV2: 10"
	| roundCount playerNums playerHands sortedElements nextHands |
	playerNums := 1 to: 10.
	roundCount := 0.
	[roundCount := roundCount + 1.
	playerHands := playerNums collect: [:n | n -> {Guu. Choki. Paa} atRandom].
	Transcript cr; show: 'Hands: '; show: playerHands.
	sortedElements := (playerHands collect: #value) asBag sortedElements.
	sortedElements size = 2
		ifTrue: [ | greaterHand |
				greaterHand := sortedElements last key.
				nextHands := playerHands select: [:hand | hand value = greaterHand].
				Transcript show: ', Win: ', greaterHand name]
		ifFalse: [nextHands := playerHands.
				Transcript show: ', Draw'].
	(playerNums := nextHands collect: #key) size = 1] whileFalse.
	Transcript cr; 
		show: 'Round: ', roundCount printString;
		show: ', Win: ', playerNums first printString
]

{ #category : 'random' }
JankenHand class >> Pon [
	^ JankenHand subclasses atRandom
]

{ #category : 'private' }
JankenHand class >> beWeakerThan: newGreaterHand [
	greaterHand := newGreaterHand 
]

{ #category : 'class initialization' }
JankenHand class >> initialize [ "JankenHand initialize"
	Choki beWeakerThan: Guu.
	Guu beWeakerThan: Paa.
	Paa beWeakerThan: Choki
]

{ #category : 'examples' }
JankenHand class >> openTranscript [
	(World windowsSatisfying: [ :w | w model = Transcript ]) 
		ifEmpty: [ Transcript open ] 
		ifNotEmpty: [ :ws | ws first activate ].
]

{ #category : 'examples' }
JankenHand class >> twoPlayers: N [ "JankenHand twoPlayers"
	JankenHand openTranscript.
	N timesRepeat: [
		| player1 player2 result  |
		Transcript cr; show: 'Player1: ', (player1 := JankenHand Pon) printString.
		Transcript show: ' vs Player2: ', (player2 := JankenHand Pon) printString.
		result := player1 = player2 
			ifTrue: [ 'Draw' ] 
			ifFalse: [ player1 > player2 
				ifTrue: [ 'Win: Player1' ] 
				ifFalse: [ 'Win: Player2' ] ].
		Transcript cr; show: result].
]
