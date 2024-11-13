# Scope
This project based on https://github.com/tosmi/fedora-silverblue/tree/40-stderr is used to create Goshansp's Family Office Fedora Silverblue Spin. It leverages quay.io to build and host the resulting image.


# Todo
- Find nicer way to keep extra-packages metadata

# Resulting Image
https://quay.io/repository/goshansp/fedora-silverblue

# Local Build
```
podman login quay.io
podman build .
podman push
```

