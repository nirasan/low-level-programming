FROM debian:9

RUN apt-get update
RUN apt-get install -y binutils nasm auditd gdb auditd
RUN apt-get install -y vim
