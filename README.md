![BESABatchMonitor_Logo](https://github.com/tward-3/BESABatchMonitor/assets/59423939/6dea59cd-d13e-40b7-8682-8b3d210642c1)
# 
This script will look for updates to the Batch.txt logfile for monitoring the progress of your batches run in BESA. When the batch stops, BESA updates this text file with information about the batch you just ran. When it stops (either from crashing or completion), Amazon Web Services (AWS) Simple Notification Service (SNS) will send you an email notification to the email address(es) of your choice.


## Step 1- Set up AWS User account
First, you will need an AWS User with the correct permissions and Access Policy. Contact Thomas (thomas.ward@boystown.org) or your own admin to get this set up, **don't make this on your own.**
These instructions for admins can be found in the [AdminOnboardingInstructions file](https://github.com/tward-3/BESABatchMonitor/blob/main/AdminOnboardingInstructions.md)

## Step 2- Install PowerShell7
Next, you will need to install **PowerShell 7**. To do this, run this command in the **command prompt**:

```
winget install --id Microsoft.Powershell --source winget
```

## Step 3- Install AWS modules for PowerShell
Open **PowerShell 7**, and install and import the AWS modules:

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
Now, save the "BESABatchMonitor" script to the directory of your choice, and edit the code in **Windows PowerShell ISE** to add your profile name, topic ARN, region, and directory.

## Step 6- Start your batch and the BESABatchMonitor
Start your batch in BESA ***(YOU MUST DO THIS FIRST)***, then in the **command prompt**, navigate to the directory the script is saved to, and run the following line:

```
pwsh BESABatchMonitor.ps1
```

The script will then check your log file every 10 seconds. Once the Batch.txt is updated (which means that the batch has stopped either due to a crash or because it was successfully completed), the AWS SNS will send an email notifying you that your batch has stopped.
