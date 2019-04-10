//Check if facebook_refresh query string is present
if(window.location.search.indexOf("facebook_refresh") >= 0)
{
    //Feature check browsers for support
    if(document.addEventListener && window.XMLHttpRequest && document.querySelector)
    {
        //DOM is ready
        document.addEventListener("DOMContentLoaded", function() {
            var httpRequest = new XMLHttpRequest();
            httpRequest.open("POST", "https://graph.facebook.com", true);

            httpRequest.onreadystatechange = function () {
                if (httpRequest.readyState == 4) { console.log("httpRequest.responseText", httpRequest.responseText);
                var url = window.location.href;
                url = url.split('?')[0];
                window.location.replace(url);
               }
            };

            //Default URL to send to Facebook
            var url = window.location;

            //og:url element
            var og_url = document.querySelector("meta[property='og:url']");

            //Check if og:url element is present on page
            if(og_url != null)
            {
                //Get the content attribute value of og:url
                var og_url_value = og_url.getAttribute("content");

                //If og:url content attribute isn't empty
                if(og_url_value != "")
                {
                    url = og_url_value;
                } else {
                    console.warn('<meta property="og:url" content=""> is empty. Falling back to window.location');
                }
            } else {
                console.warn('<meta property="og:url" content=""> is missing. Falling back to window.location');
            }

            //Send AJAX
            httpRequest.send("scrape=true&id=" + encodeURIComponent(url));
        });
    } else {
        console.warn("Your browser doesn't support one of the following: document.addEventListener && window.XMLHttpRequest && document.querySelector");
    }
}
