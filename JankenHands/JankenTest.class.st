Class {
	#name : 'JankenTest',
	#superclass : 'TestCase',
	#category : 'JankenHands-Tests',
	#package : 'JankenHands',
	#tag : 'Tests'
}

{ #category : 'tests' }
JankenTest >> test01weakerThan [
	self should: Guu < Paa.
	self shouldnt: Guu < Choki.
	self should: Paa < Choki.
	self shouldnt: Paa < Guu.
	self should: Choki < Guu.
	self shouldnt: Choki < Paa
]

{ #category : 'tests' }
JankenTest >> test02greaterThan [
	self shouldnt: Guu > Paa.
	self should: Guu > Choki.
	self shouldnt: Paa > Choki.
	self should: Paa > Guu.
	self shouldnt: Choki > Guu.
	self should: Choki > Paa
]
