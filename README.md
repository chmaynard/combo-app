# Combo!

[Combo][1] is a challenging card-matching game for iPhone and iPad. Combo is designed for a single player and does not require a network connection. 

## Contents

* [Overview](#overview)
* [Card Matching](#card-matching)
* [Game Play](#game-play)
* [A Useful Hint](#a-useful-hint)
* [Support](#support)
* [Origin and Mathematics of Combo](#origin-and-mathematics-of-combo)

### Overview

Combo starts with a deck of eighty-one cards. Each card in the deck has a unique geometric pattern. The basic idea of Combo is to match three cards at a time until the deck runs out. The three cards must match according to some special rules, described below.

### Card Matching

Each card in Combo's deck has four different attributes:

* Shape (diamond, rectangle, oval)
* Color (red, green, blue)
* Shading (solid, translucent, clear)
* Count (one, two, or three shapes)

Given any two cards, there is only one other card in the deck that forms a three-card **set** with them. What's a set? In Combo, a set is three cards that satisfy all of the following  conditions:

* All three cards have the same shape, or they have three different shapes.
* All three cards have the same count, or they have three different counts.
* All three cards use the same shading, or they have three different shadings.
* All three cards have the same color, or they have three different colors.

### Game Play

A new game starts with a deck of eighty-one cards. Combo chooses some cards from the deck and displays them on the screen. Your challenge is to examine these cards and find three that match, forming a set. When you find a set, tap on the three cards one at a time. If your guess is correct, Combo replaces them with new cards and the game continues. Each time you find another set, the bar at the bottom of the screen shows your progress. After the deck runs out and the remaining cards on the screen no longer contain a set, the game is over.

#### A Useful Hint

Occasionally, you may have trouble finding three cards that match. If you'd like Combo to show you a set, just swipe across the screen from left to right.

### Support

If you have any questions or comments about Combo, please [contact the author][4]. Combo is a [GitHub-hosted project][3].

### Origin and Mathematics of Combo

In 2013, while taking a [Stanford University course][7] on iOS app development, we wrote a card-matching game named **Matchismo** as a class exercise. Matchismo was loosely based on **Set**, an award-winning game invented by geneticist Marsha Falco in 1974. I later turned the exercise into a finished app, named it Combo, and published it in the App Store. 

The mathematics of the game Set are described in an informative [Wikipedia article][2]. In May 2016, a new [math paper][6] confirmed an important conjecture in the same area of research. 


[1]: https://itunes.apple.com/us/app/combo/id786081900?mt=8 "Combo"
[2]: https://en.wikipedia.org/wiki/Set_(game) "Wikipedia"
[3]: https://github.com/chmaynard/Combo "GitHub"
[4]: mailto:support@chmaynard.com "Support"
[5]: http://www.setgame.com/set "Set"
[6]: https://arxiv.org/abs/1605.01506 "Proof"
[7]: https://itunes.apple.com/us/course/coding-together-developing/id593208016
