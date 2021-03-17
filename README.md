## docker-ombi

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/ombi) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/ombi?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-ombi/actions?query=workflow%3A"Auto+Builder+CI") [![codacy branch grade](https://img.shields.io/codacy/grade/f0bc44e57131401490bc22ca08aa8629/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-ombi)

Fork of [linuxserver/docker-ombi](https://github.com/linuxserver/docker-ombi/)

[Ombi](https://ombi.io/) allows you to host your own Plex Request and user management system. If you are sharing your Plex server with other users, allow them to request new content using an easy to manage interface! Manage all your requests for Movies and TV with ease, leave notes for the user and get notification when a user requests something. Allow your users to post issues against their requests so you know there is a problem with the audio etc. Even automatically send them weekly newsletters of new content that has been added to your Plex server!

## Usage

```bash
docker run -d \
  --name=ombi \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -e DEBUG=true/false #optional \
  -p 3579:3579 \
  -v <path to appdata>:/config \
  --restart unless-stopped \
  vcxpz/ombi
```

[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/ombi.xml)

## New Environment Variables

| Name    | Description                                                                                              | Default Value |
| ------- | -------------------------------------------------------------------------------------------------------- | ------------- |
| `DEBUG` | set `true` to display errors in the Docker logs. When set to `false` the Docker log is completely muted. | `false`       |

**See other variables on the official [README](https://github.com/linuxserver/docker-ombi/)**

## Upgrading Ombi

To upgrade, all you have to do is pull the latest Docker image. We automatically check for Ombi updates every hour. When a new version is released, we build and publish an image both as a version tag and on `:latest`.

## Credits

-   [hotio](https://github.com/hotio) for the `redirect_cmd` function

## Fixing Appdata Permissions

If you ever accidentally screw up the permissions on the appdata folder, run `fix-perms` within the container. This will restore most of the files/folders with the correct permissions.
