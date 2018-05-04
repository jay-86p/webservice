### WebService

* Listens for a Delete Repository Event when a [repository is deleted](https://help.github.com/articles/deleting-a-repository/) in an organization; using the [`repository`](https://developer.github.com/v3/repos/#delete-a-repository) event and `deleted` action.

* Creates an Issue in an organization's `NOTIFICATION_REPO` and includes:
    - The name of the deleted repository in an organization
    - Comments to review the deletion and mentions it to the `@USERNAME`

### WebService Configuration

* Refer to the [webhooks](https://developer.github.com/webhooks/) documentation on how to [Create Webhooks](https://developer.github.com/webhooks/creating/) in an organization and [Configure Your Server](https://developer.github.com/webhooks/configuring/).

* Set the following required environment variables:
    - `USERNAME` - GitHub Username
    - `API_TOKEN` - a [Personal Access Token](https://help.github.com/enterprise/user/articles/creating-a-personal-access-token-for-the-command-line/) that has the ability to create an issue in the notification repository
    - `NOTIFICATION_REPO` - the repository in which to create the notification issue. e.g. github.example.com/organization/custom-notifications

### Development References

* Utilized [Octokit](https://github.com/octokit/octokit.rb) to authenticate and [create issue](https://octokit.github.io/octokit.rb/Octokit/Client/Issues.html#create_issue-instance_method
) in a GITHUB Repository via API.
