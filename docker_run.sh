#!/bin/sh
docker run -it --cap-add=SYS_PTRACE --security-opt="seccomp=unconfined" -v $(pwd)/listings:/listings -v $(pwd)/workdir:/workdir low-level-programming bash
