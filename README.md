# BESABatchMonitor
Monitors the Batch.txt logfile for monitoring progress of batches. When the batch stops (from crashing or completion), Amazon AWS SNS will send an email notification.

First, you will need an AWS User with Publishing, SNSRole, SNSReadOnlyAccess, and SNSFullAccess permissions. Contact Thomas (thomas.ward@boystown.org) for these.
Next, you will need to install PowerShell 7. To do this, run this command in the command line:

```
msiexec.exe /package PowerShell-7.4.0-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1
```

Open PowerShell 7, and install and import the AWS SNS module:

```
Install-AWSToolsModule -Name AWS.Tools.SimpleNotificationService -Force -Scope CurrentUser
```

```
Import-Module -Name AWS.Tools.SimpleNotificationService
```

Next, you will need to set your credentials. 

```
Set-AWSCredential -AccessKey YOUR_ACCESS_KEY_HERE -SecretKey YOUR_SECRET_KEY_HERE -StoreAs CHOOSE_A_PROFILE_NAME
```

Now, save the "BESABatchMonitor" script to the directory of your choice, and edit the code in Windows PowerShell ISE to add your profile name.

Start your batch in BESA ***(YOU MUST DO THIS FIRST)***, then in the command line, navigate to the directory the script is saved to, and run the following line:

```
pwsh BESABatchMonitor.ps1
```

The script will then check your log file every 10 seconds. Once the Batch.txt is updated (which means that the batch has stopped either due to a crash or because it was successfully completed), the AWS SNS will send an email notifying you that your batch has stopped.
