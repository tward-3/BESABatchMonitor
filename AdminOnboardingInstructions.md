## Admin Instructions for Creating AWS Profiles and Email Subscriptions for New Users

#

Important Note: The BESABatchMonitor (at least, currently) should be managed by an admin who is responsible for creating profiles for each user in the **Identity and Access Management (IAM)** module, as well as setting up the notification subscriptions in the **Simple Notification Service (SNS)** module. If you are not the admin responsible for this, please don't set up these for yourself. 

### IAM Module

## Steps for Group Creation
These make applying permissions for new users much faster and easier. You can create a group that has a set of permissions that will be automatically applied to any users added to that group.

# Step 1- Create Group
- Navigate to the "User groups" tab and select "Create group"
- If you've already created users, you can select them and add to the group now
- Under "Attach permissions policies," search for "AmazonSNSRole" and select that one. Then click "Create Group"

# Step 2- Add SNS Publishing Permissions
- Select your new group, then click the dropdown "Add permissions" and select "Create inline policy"
- In the policy editor, select "JSON" and paste this:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowPublishToTopic",
            "Effect": "Allow",
            "Action": "sns:Publish",
            "Resource": "arn:aws:sns:us-east-2:566327938934:${aws:username}"
        }
    ]
}
```
- Click "Next"
- For "Policy name," call it something like "PublishingPermissions" and click "Create policy"


## Steps for New Users

# Step 1- Create User
- Navigate to the "Users" tab and select "Create user"
- Specify user details:
  - Add a username (I typically recommend sticking with the same naming convention moving forward, i.e., "JohnSmith_BESABatchMonitor")
  - **Don't** provide user access to the AWS Management Console
- Set permissions
  - Add user to a group (e.g., "SNS-Script-Access")

# Step 2- Create Access Keys
- Click the new username from the list in the "Users" tab
- Click "Create access key"
- Use case: **Local code**
- Set description tag (for simplicity, stick to same naming as the username e.g., "JohnSmith_BESABatchMonitor")
- Download the .csv file containing the new user's access keys. **This is the only time you will be able to view/save this.**
  - **SAVE A COPY TO A SECURE LOCATION.** This way, in the unlikely event the user loses theirs, you have a backup
  - Send a copy to the user, and tell them to save it somewhere they won't forget it (the same directory they saved the BESABatchMonitor.ps1 file is fine)


### SNS Module

## Steps to create an Email Subscription
This will need to be done for each user. This gives them a unique email subscription, so that they only receive messages from their own BESABatchMonitor, and not the other users.

# Step 1- Create a Topic
- Navigate to the "Topics" tab
- Click "Create topic"
  - Type: **Standard**
  - Name: "JohnSmith_BESABatchMonitor"
  - Under "Access Policy" in the JSON preview, make sure these are listed under "Action:"
  
    ```
    "SNS:Publish",
    "SNS:RemovePermission",
    "SNS:SetTopicAttributes",
    "SNS:DeleteTopic",
    "SNS:ListSubscriptionsByTopic",
    "SNS:GetTopicAttributes",
    "SNS:AddPermission",
    "SNS:Subscribe"
    ```
  - Publishers: **Only the topic owner**
  - Subscribers: **Only the topic owner**
- Click "Create Topic"

# Step 2- Create the Email Subscription
- In the dashboard for your new topic under "Details," copy the ARN and send it to your user
- Select "Create subscription"
- Protocol: **Email**
- Endpoint: **Email address of user's choice**
- Click "Create subscription"
- Make sure the user gets an email from AWS asking to confirm the subscription, and have them confirm it
