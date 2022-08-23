local buildAndPublish() = {
    name: "build-and-publish",
    kind: "pipeline",
    type: "docker",
    triggers: {
        branch: ["main"],
        repo: ["hwittenborn/drone"]
    },
    volumes: [{name: "docker", host: {path: "/var/run/docker.sock"}}],
    steps: [{
        name: "build-and-publish",
        image: "docker",
        volumes: [{name: "docker", path: "/var/run/docker.sock"}],
        environment: {
            proget_api_key: {from_secret: "proget_api_key"},
            VERSION: "2.12.1"
        },
        commands: [
            "docker login -u api -p \"$${proget_api_key}\" \"proget.$${hw_url}\"",
            "docker build --no-cache --build-arg \"VERSION=$${VERSION}\" ./ -t \"proget.$${hw_url}/docker/hwittenborn/drone:$${VERSION}\"",
            "docker push \"proget.$${hw_url}/docker/hwittenborn/drone:$${VERSION}\""
        ]
    }]
};

[buildAndPublish()]

// vim: set syntax=typescript ts=4 sw=4 expandtab:
