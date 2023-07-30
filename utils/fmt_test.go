package utils

import (
	"fmt"
	"testing"
)

func TestGetMaxLengthAndNumColumns(t *testing.T) {
	var tests = []struct {
		list []string
		terminalWidth,
		expectedMaxLength, expectedNumColumns int
	}{
		// Always get at least one column
		{[]string{"foo", "bar"}, 1, 3, 1},

		// Get multiple columns as soon as there is space
		{[]string{"foo", "bar"}, 6, 3, 1},
		{[]string{"foo", "bar"}, 7, 3, 2},

		// Rudimentary max width test
		{[]string{"a", "bbb", "cc"}, 1, 3, 1},
	}
	for _, tt := range tests {
		testName := fmt.Sprintf("%v,%v", tt.list, tt.terminalWidth)
		t.Run(testName, func(t *testing.T) {
			maxLength, numColumns := getMaxLengthAndNumColumns(tt.list, tt.terminalWidth)
			if maxLength != tt.expectedMaxLength {
				t.Errorf("Expected maxLength %v, got %v", tt.expectedMaxLength, maxLength)
			}

			if numColumns != tt.expectedNumColumns {
				t.Errorf("Expected numColumns %v, got %v", tt.expectedNumColumns, numColumns)
			}
		})
	}
}
