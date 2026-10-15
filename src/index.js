
import { Container, getContainer } from "@cloudflare/containers";

export class XrayContainer extends Container {
  defaultPort = 8080;
  sleepAfter = "10m";
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (url.pathname === "/health") {
      return new Response("Worker is running", {
        status: 200
      });
    }

    if (!url.pathname.startsWith("/xhttp")) {
      return new Response("Not Found", {
        status: 404
      });
    }

    const container = getContainer(
      env.XRAY_CONTAINER,
      "xray-main"
    );

    return container.fetch(request);
  }
};
