package app.facebook

class FacebookChannel {
    String userID
    String accessToken
    Date dateCreated
    Date lastUpdated

    static constraints = {
        userID nullable: false, blank: false, unique: true
        accessToken nullable: false, blank: false
    }

    static mapping = {
        autoTimestamp: true
    }
}
