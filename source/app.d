import vibe.d;

shared static this()
{
	auto router = new URLRouter;
	router.get("/", serveStaticFile("public/dist/index.html"));
	router.get("*", serveStaticFiles("public/dist"));

	auto settings = new HTTPServerSettings;
	settings.bindAddresses = ["127.0.0.1"];
	settings.port = 8080;
	settings.errorPageHandler = toDelegate(&showError);

	listenHTTP(settings, router);
}

void showError(HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error)
{
	res.render!("error.dt", req, error);
}