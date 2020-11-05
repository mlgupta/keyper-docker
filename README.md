![Docker Image Version (latest by date)](https://img.shields.io/docker/v/dbsentry/keyper)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/dbsentry/keyper-docker/CI)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/dbsentry/keyper)
![GitHub issues](https://img.shields.io/github/issues/mlgupta/keyper-docker)
![GitHub last commit](https://img.shields.io/github/last-commit/mlgupta/keyper-docker)
![GitHub](https://img.shields.io/github/license/mlgupta/keyper-docker)
![Docker Pulls](https://img.shields.io/docker/pulls/dbsentry/keyper)  
![Keyper Architecture](https://keyper.dbsentry.com/media/keyper.png)  

Keyper is an SSH Key/Certificate Authentication Manager. It standardizes and centralizes the storage of SSH public keys and SSH Public Certificates for all Linux users within your organization saving significant time and effort it takes to manage SSH public keys and certificates. Keyper is a lightweight container taking less than 100MB. It is launched either using Docker or Podman. You can be up and running within minutes instead of days.

Features include:
- Public key storage
- SSH CA
- Certificate signing and storage
- Public Key/Certificate Expiration
- Forced Key rotation
- Key Revocation List (KRL)
- Streamlined provision or de-provisioning of users
- Segmentation of Servers using groups
- Policy definition to restrict user's access to server(s)
- Centralized user account lockout
- Docker container

## Installation/Build
Follow the steps to build docker image using source code:
1. Clone this git repository
```console
$ git clone https://github.com/dbsentry/keyper-docker.git
```
2. Download keyper REST API submodule
```console
$ cd keyper-docker
$ git submodule init
$ git submodule update modules/keyper
```
3. By default Makefile creates image as dbsentry/keyper. To change, modify Makefile
4. Change .release to reflect correct tag on docker image
5. Run build
```console
$ make build
```
The generated image when run would start a docker container with openldap and Keyper REST-API service.

Refer to the [administration guide](https://keyper.dbsentry.com/docs/) for further information.

## Related Projects
- [Keyper](https://github.com/dbsentry/keyper)

## License
All assets and code are under the GNU GPL LICENSE and in the public domain unless specified otherwise.

Some files were sourced from other open source projects and are under their terms and license.
