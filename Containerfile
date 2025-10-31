FROM quay.io/fedora/fedora-silverblue:43
ENV VERSION=43
LABEL summary="Customized Fedora Silverblue Containerized Bootc Image" \
      maintainer="Hanspeter Gosteli <hanspeter.gosteli@gmail.com>"

COPY extra-packages /

RUN dnf install -y \
      https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${VERSION}.noarch.rpm \
      https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${VERSION}.noarch.rpm && \
    (cd /etc/yum.repos.d; curl -LO https://pkgs.tailscale.com/stable/fedora/tailscale.repo) && \
    dnf install -y $(< extra-packages) && \
    dnf clean all && \
    rm -f /extra-packages

# TODO: Add timer for regular updates
# https://docs.fedoraproject.org/en-US/bootc/building-containers/
# TODO:
# 1. Rename/Add: squish-bootstrap(timer boot), squish-upgrade(timer daily, boot), squish-configuration(timer daily, boot)
# 2. Integrate squish trigger for above

COPY ansible-pull.service /etc/systemd/system/ansible-pull.service
COPY 00-hp-nopasswd /etc/sudoers.d/00-hp-nopasswd
