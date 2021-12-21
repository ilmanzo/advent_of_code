package main

import "fmt"

// rolls the dice 3 times and returns the result and new dice state
func roll_3_times(rolls *int) int {
	move := 0
	for i := 0; i < 3; i++ {
		move += *rolls%100 + 1
		*rolls++
	}
	return move
}

func main() {
	positions := [2]int{6, 8}
	scores := [2]int{0, 0}
	rolls := 0
	for {
		for player := range positions {
			move := roll_3_times(&rolls)
			positions[player] = ((positions[player] + move) % 10)
			scores[player] += positions[player] + 1
			if scores[player] >= 1000 {
				fmt.Println(rolls * scores[1-player])
				return
			}
		}
	}
}
