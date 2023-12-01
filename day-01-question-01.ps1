#variables
$inputFilePath = "input.txt"
$outputFilePath = "output.txt"

# Check if output file exists and delete it
if (Test-Path $outputFilePath) {
    Remove-Item $outputFilePath -Force
}

# Read input from the file
$inputLines = Get-Content -Path $inputFilePath

# Initialize sum of calibration values
$totalCalibration = 0

# Initialize an array to store calibration values and input lines for each line
$outputLines = @()

# Process each line in the input
foreach ($index in 0..($inputLines.Count - 1)) {
    $line = $inputLines[$index]

    # Extract digits from the line
    $digits = $line -replace '\D', ''

    # If there are digits, concatenate the first and last digits, else use '00'
    $calibrationValue = if ($digits.Length -ge 2) {
        $digits[0] + $digits[-1]
    } elseif ($digits.Length -eq 1) {
        $digits * 2
    } else {
        '00'
    }

    # Add calibration value to the total
    $totalCalibration += [long]$calibrationValue

    # Create a line to be added to the output file
    $outputLine = "Line ${index}: Original Line: $line, Calibration Value: $calibrationValue"

    # Add the line to the output array
    $outputLines += $outputLine
}

# Write the total calibration value and individual values to the output file
"Total Calibration Value: $totalCalibration" | Out-File -FilePath $outputFilePath
$outputLines | Out-File -Append -FilePath $outputFilePath

Write-Host "Total Calibration Value: $totalCalibration"
Write-Host "Output written to $outputFilePath"