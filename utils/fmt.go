package utils

import "fmt"

// calculate returns
func getMaxLengthAndNumColumns(list []string, terminalWidth int) (int, int) {
	maxLength := 0
	for _, s := range list {
		if len(s) > maxLength {
			maxLength = len(s)
		}
	}

	// For n columns, we need enough room for n-1 spaces between the columns.
	//
	// For a list where the longest string is of length maxLength, the maximum
	// number of columns we can print is the largest number, n, where:
	//
	//    n * maxLength + n - 1 <= terminalWidth
	//
	// Rearranging:
	//
	//    n * maxLength + n <= terminalWidth + 1
	//    n * (maxLength - 1) <= terminalWidth + 1
	//    n <= (terminalWidth + 1) / (maxLength + 1)
	numColumns := (terminalWidth + 1) / (maxLength + 1)
	if numColumns == 0 {
		numColumns = 1
	}
	return maxLength, numColumns
}

func PrintInColumns(list []string, terminalWidth int) {
	maxLength, numColumns := getMaxLengthAndNumColumns(list, terminalWidth)
	fmtString := fmt.Sprintf("%%-%ds", maxLength)
	for i, s := range list {
		fmt.Printf(fmtString, s)
		if (i%numColumns == numColumns-1) || i == len(list)-1 {
			fmt.Print("\n")
		} else {
			fmt.Print(" ")
		}
	}
}
