vcl 4.0;

backend default {
    .host = "api";
    .port = "8080";
}

sub vcl_recv {
    if (req.url ~ "/signin" || req.url ~ "/uuid") {
        return (pipe);
    }
    return (hash);
}

sub vcl_backend_response {
    if (! (beresp.status == 200)) {
        set beresp.uncacheable = true;
        return (deliver);
    }
    set beresp.ttl = 3600s;
}

sub vcl_deliver {
    set resp.http.Access-Control-Allow-Origin = "*";

    if (req.method == "OPTIONS") {
        set resp.http.Access-Control-Allow-Methods = "GET, POST, OPTIONS";
        set resp.http.Access-Control-Allow-Headers = "Authorization";

        set resp.status = 204;
    }
}