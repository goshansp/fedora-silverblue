FROM quay.io/fedora-ostree-desktops/silverblue:43
ENV VERSION=43
LABEL summary="Customized Fedora Silverblue Containerized Ostree Image" \
      maintainer="Hanspeter Gosteli <hanspeter.gosteli@gmail.com>"

COPY extra-packages /

RUN rpm -Uhv https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${VERSION}.noarch.rpm && \
    rpm -Uhv https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${VERSION}.noarch.rpm && \
#    (cd /etc/yum.repos.d; curl -LO https://repo.ivpn.net/stable/fedora/generic/ivpn.repo) && \
    (cd /etc/yum.repos.d; curl -LO https://pkgs.tailscale.com/stable/fedora/tailscale.repo) && \
#    rpm -e noopenh264 && \
    rpm-ostree install -y $(< extra-packages) && \
    rm /extra-packages && \
    ostree container commit

# TODO: Add timer for regular updates
# https://docs.fedoraproject.org/en-US/bootc/building-containers/
# TODO:
# 1. Rename/Add: squish-bootstrap(timer boot), squish-upgrade(timer daily, boot), squish-configuration(timer daily, boot)
# 2. Integrate squish trigger for above

COPY ansible-pull.service /etc/systemd/system/ansible-pull.service
COPY 00-hp-nopasswd /etc/sudoers.d/00-hp-nopasswd
