Class {
	#name : 'Janken',
	#superclass : 'Object',
	#category : 'JankenHands-Core',
	#package : 'JankenHands',
	#tag : 'Core'
}

{ #category : 'comparing' }
Janken class >> < other [
	^ self greaterHand == other
]

{ #category : 'comparing' }
Janken class >> > other [
	^ self ~~ other and: [ (self < other) not ]
]

{ #category : 'examples' }
Janken class >> NPlayersV1: N [ "Janken NPlayersV1: 10"
	| roundCount playerHands handAndCounts winnewtHand winner |
	Janken openTranscript.
	roundCount := 0.
	[	roundCount := roundCount + 1.
		playerHands := (1 to: N) collect: [ :n | n -> Janken Pon ].
		Transcript cr; show: 'Hands: '; show: playerHands.
		handAndCounts := (playerHands collect: #value) asBag sortedElements.
		handAndCounts size = 2 and: [ handAndCounts last value = 1 ]
	] whileFalse.
	winnewtHand := handAndCounts last key.
	winner := playerHands detect: [ :p | p value = winnewtHand ].
	Transcript cr; 
		show: 'Round: ', roundCount printString;
		show: ', Win: ', winner key printString.
]

{ #category : 'examples' }
Janken class >> NPlayersV2: N [ "Janken NPlayersV2: 10"
	| roundCount playerNums playerHands sortedElements nextHands |
	Janken openTranscript.
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
Janken class >> Pon [
	^ Janken subclasses atRandom
]

{ #category : 'comparing' }
Janken class >> greaterHand [
	self subclassResponsibility 
]

{ #category : 'examples' }
Janken class >> openTranscript [
	(World windowsSatisfying: [ :w | w model = Transcript ]) 
		ifEmpty: [ Transcript open ] 
		ifNotEmpty: [ :ws | ws first activate ].
]

{ #category : 'examples' }
Janken class >> twoPlayers: N [ "Janken twoPlayers: 3"
	Janken openTranscript.
	N timesRepeat: [
		| player1 player2 result  |
		Transcript cr; show: 'Player1: ', (player1 := Janken Pon) printString.
		Transcript show: ' vs Player2: ', (player2 := Janken Pon) printString.
		result := player1 = player2 
			ifTrue: [ 'Draw' ] 
			ifFalse: [ player1 > player2 
				ifTrue: [ 'Win: Player1' ] 
				ifFalse: [ 'Win: Player2' ] ].
		Transcript cr; show: result].
]
