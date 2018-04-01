# theia-openshift
A version of Dockerized Theia to work on OpenShift.

## How it works 

Official TypeFox images does not work on OpenShift for the following reasons:

- Permission errors 
- Does not run on user/ runs on root.

This repository is a rendition of it but with added packages to be like theia-full image on theia-apps repository and it runs on user with no file permission errors.

## Contributing

All contributions are accepted. But it falls under this three parameters:

- Your PR is tested to work on OpenShift/OpenShift Online.
- Images always and SHOULD always run on usermode.
- File permissions are set correctly.