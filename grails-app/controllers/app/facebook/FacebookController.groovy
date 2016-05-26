package app.facebook

import grails.converters.JSON

class FacebookController {
    private final String USER_AGENT = "Mozilla/5.0"
   

    def getLongLivedToken(String token) {
          String facebookHost = grailsApplication.config.app.facebook.host

    String appID = grailsApplication.config.app.facebook.appID

     String appSecret = grailsApplication.config.app.facebook.appSecret

        StringBuffer responseValue

        try {
            URL url = new URL(facebookHost + "/oauth/access_token?" +
                    "grant_type=fb_exchange_token&" +
                    "client_id=" + appID + "&" +
                    "client_secret=" + appSecret + "&" +
                    "fb_exchange_token=" + token + "&" +
                    "access_token=" + token)
            HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
            httpURLConnection.setRequestProperty("User-Agent", USER_AGENT)
            httpURLConnection.setRequestProperty("Accept-Charset", "UTF-8")

            int responseCode = httpURLConnection.responseCode
            BufferedReader bufferedReader = new BufferedReader(
                    new InputStreamReader(httpURLConnection.inputStream))
            String inputLine;
            responseValue = new StringBuffer()

            while ((inputLine = bufferedReader.readLine()) != null) {
                responseValue.append(inputLine)
            }

            bufferedReader.close()

            println responseValue.toString()
        } catch (MalformedURLException ex) {
            println ex.message
        } catch (IOException ex) {
            println ex.message
        }

        Map data = [data: JSON.parse(responseValue.toString())]

        withFormat {
            json { render data as JSON }
        }
    }
}
