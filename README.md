## ragnarb/toolbox

A CoreOS toolbox container based on Debian Jessie, with some niceties such as zsh and a fully fledged vim. To use, instruct the toolbox utility to use `ragnarb/toolbox` instead of the default fedora container.

### Tools included

The toolbox is geared towards performance metric gathering and debugging. Some of the tools include generic tools like htop, dstat and sar; more specific tools like iostat, iotop, blktrace, vmstat, slabtop, pidstat, lsof and mpstat; network tools like mtr, tcpdump, nicstat, iftop, ethtool & the iproute2 tools; and tools like strace/ltrace and sysdig for tracing. A docker binary matching the latest release on CoreOS stable is also included.

Note that in order to use sysdig you must bind the host /dev fs into the toolbox and run sysdig-probe-loader to load the relevant kernel module. To use the host's docker daemon from within the toolbox bind /var/run/docker.sock to /docker.sock. See the next section for how to do this automatically.

See the [Dockerfile](https://github.com/ragnar-johannsson/toolbox/blob/master/Dockerfile) for details on which tools are installed.

### Usage

Configure the toolbox utility to use this container instead of the default one by specifying `TOOLBOX_DOCKER_IMAGE=ragnarb/toolbox` in **$HOME/.toolboxrc. See the [CoreOS documentation](https://coreos.com/docs/cluster-management/debugging/install-debugging-tools/) for details.

Setting up the toolbox with /dev and /var/run/docker.sock bound and zsh instead of bash can done with .toolboxrc along the lines of:

```bash
TOOLBOX_DOCKER_IMAGE=ragnarb/toolbox
TOOLBOX_CMD="$@"

if [ -z "$TOOLBOX_PROVISIONED" ]; then
    export TOOLBOX_PROVISIONED=1
    test -z "$TOOLBOX_CMD" && TOOLBOX_CMD=zsh
    exec /usr/bin/toolbox --bind=/dev:/dev --bind=/var/run/docker.sock:/docker/docker.sock $TOOLBOX_CMD
fi
```

Writing the .toolboxrc when provisioning can be accomplished with a section like this in your cloud-config:

```yaml
#cloud-config
write_files:
  - path: /home/core/.toolboxrc
    owner: core
    content: |
      TOOLBOX_DOCKER_IMAGE=ragnarb/toolbox
      TOOLBOX_CMD="$@"

      if [ -z "$TOOLBOX_PROVISIONED" ]; then
          export TOOLBOX_PROVISIONED=1
          test -z "$TOOLBOX_CMD" && TOOLBOX_CMD=zsh
          exec /usr/bin/toolbox --bind=/dev:/dev --bind=/var/run/docker.sock:/docker/docker.sock $TOOLBOX_CMD
      fi
```

### License

BSD 2-Clause. See the LICENSE file for details.
