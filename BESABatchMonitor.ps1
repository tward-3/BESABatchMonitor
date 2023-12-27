# Set your AWS region and SNS topic ARN
$region = " "
$topicARN = " "

#Set credentials
Set-AWSCredential -ProfileName YOUR PROFILE NAME HERE

# Set the directory to monitor
$directoryPath = " "

# Specify the filename you want to watch for
$fileName = "Batch.txt"

# Specify the start time for monitoring (adjust as needed)
$startTime = Get-Date 

# Start monitoring the directory for file creation
while($true) {
    
    Write-Host "Looking for file"
    $files = Get-ChildItem -Path $directoryPath -Filter $fileName | Where-Object { $_.LastWriteTime -gt $startTime }

    Write-Host $files

    if ($files) {
        # File is created after the start time
        Write-Host "File $fileName created. Sending SNS notification..."
        
        # Send SNS notification
        foreach ($file in $files) {
            $message = "File $fileName was updated at $($file.LastWriteTime). Check to see if it crashed."
            Publish-SNSMessage -TopicArn $topicARN -Message $message -Region $region
        }
        
        break  # Exit the loop after sending notification for the first file found
    }
    
    Start-Sleep -Seconds 10  # Check for file creation every 10 seconds (adjust as needed)
}
