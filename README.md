# BESABatchMonitor
Monitors the Batch.txt logfile for monitoring progress of batches. When the batch stops (from crashing or completion), Amazon Web Services (AWS) Simple Notification Service (SNS) will send an email notification.


## Step 1- Set up AWS User account
First, you will need an AWS User with Publishing, SNSRole, SNSReadOnlyAccess, and SNSFullAccess permissions. SNS Topic Access Policy also needs to be updated. Contact Thomas (thomas.ward@boystown.org) to get this set up.

## Step 2- Install PowerShell7
Next, you will need to install PowerShell 7. To do this, run this command in the command line:

```
winget install --id Microsoft.Powershell --source winget
```

## Step 3- Install AWS modules for PowerShell
Open PowerShell 7, and install and import the AWS modules:

```
Install-Module -Name AWS.Tools.Installer
```

```
Install-AWSToolsModule -Name AWS.Tools.SimpleNotificationService -Force -Scope CurrentUser
```

```
Import-Module -Name AWS.Tools.SimpleNotificationService
```

## Step 4- Set credentials
Next, you will need to set your credentials. You should only need to do this once.

```
Set-AWSCredential -AccessKey YOUR_ACCESS_KEY_HERE -SecretKey YOUR_SECRET_KEY_HERE -StoreAs CHOOSE_A_PROFILE_NAME
```
## Step 5- Edit the script as necessary
Now, save the "BESABatchMonitor" script to the directory of your choice, and edit the code in Windows PowerShell ISE to add your profile name, topic ARN, region, and directory.

## Step 6- Start your batch and the BESABatchMonitor
Start your batch in BESA ***(YOU MUST DO THIS FIRST)***, then in the command line, navigate to the directory the script is saved to, and run the following line:

```
pwsh BESABatchMonitor.ps1
```

The script will then check your log file every 10 seconds. Once the Batch.txt is updated (which means that the batch has stopped either due to a crash or because it was successfully completed), the AWS SNS will send an email notifying you that your batch has stopped.
