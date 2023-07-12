import ballerinax/trigger.github;
import ballerina/http;
import ballerina/log;
import ballerinax/slack;

configurable github:ListenerConfig config = ?;
configurable string slackAuthToken = ?;
configurable string slackChannelName = ?;

listener http:Listener httpListener = new(8090);
listener github:Listener webhookListener =  new(config,httpListener);

service github:PullRequestService on webhookListener {
  
    remote function onOpened(github:PullRequestEvent payload ) returns error? {
        log:printInfo("Pull request opened ! " + payload.toJsonString());

        slack:Client slackClient = check new ({auth: {token: slackAuthToken}});
        string response = check slackClient->postMessage({
            channelName: slackChannelName,
            text: payload.toString()
        });
        log:printInfo("Message sent successfully " + response.toString());

    }
    remote function onClosed(github:PullRequestEvent payload ) returns error? {
      log:printInfo("Pull request closed !");
      //Not Implemented
    }
    remote function onReopened(github:PullRequestEvent payload ) returns error? {
      //Not Implemented
    }
    remote function onAssigned(github:PullRequestEvent payload ) returns error? {
      log:printInfo("Pull request Assigned !");
      //Not Implemented
    }
    remote function onUnassigned(github:PullRequestEvent payload ) returns error? {
      //Not Implemented
    }
    remote function onReviewRequested(github:PullRequestEvent payload ) returns error? {
      //Not Implemented
    }
    remote function onReviewRequestRemoved(github:PullRequestEvent payload ) returns error? {
      //Not Implemented
    }
    remote function onLabeled(github:PullRequestEvent payload ) returns error? {
      //Not Implemented
    }
    remote function onUnlabeled(github:PullRequestEvent payload ) returns error? {
      //Not Implemented
    }
    remote function onEdited(github:PullRequestEvent payload ) returns error? {
      //Not Implemented
    }
}

service /ignore on httpListener {}