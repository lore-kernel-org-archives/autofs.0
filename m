From: doron cohen <doron@weka.io>
Subject: autofs startup issue
Date: Tue, 25 Jul 2017 08:33:24 +0300
Message-ID: <CAH+JqnCXyQTQO8RQm_4J9mv3SZkRO1G4jgfBoZtE=dnQO5RGkA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=weka.io; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sdxSxRgMZYstdvjiGSjfNMuWQnUx0ayy1TwHfh5VxVE=;
        b=QIHl++CJrIuZSHIeSDsCiupYhCtUCs8a3ld2avYyu+w2eQRn850L13YbqDoGUw8Wne
         Cx1KFDi0FLDUlEf3MUcHzGKtlrdwurp7mNqZHDNqhGX7/3p/QkXiIJl/MLmwZQ7SUlMD
         h4cL5MpeoDfY5I2f38nV1JgFOf0LrKdrSHjpA=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: autofs@vger.kernel.org

Hi,

I encounterd an issue involving automount start.
As part of our tests we reboot our machines and test their state after
they have recovered. Sometimes these reboots include the --force flag
and even --no-sync. At other times we are forces to use more drastic
commands like "echo 1 > /proc/sys/kernel/sysrq; echo b >
/proc/sysrq-trigger".
Once in a while, after a reboot, we detect autofs is not running.
After some investigating we discovered that the pid file in
/run/autofs-running hasn't been cleaned before reboot and autofs
reports it is already running:

[root@autofs-6 ~]# pidof automount
[root@autofs-6 ~]# automount --debug
automount: program is already running.
[root@autofs-6 ~]# cat /run/autofs-running
3394
[root@autofs-6 ~]# rm /run/autofs-running
rm: remove regular file =E2=80=98/run/autofs-running=E2=80=99? y
[root@autofs-6 ~]# automount --debug
[root@autofs-6 ~]# pidof automount
6362
[root@autofs-6 ~]# cat /run/autofs-running
6362

This seems very odd to me. Why doesn't automount check if the process
is really running (like with pidof or any other way) and how do we
solve this issue?
some guesses to why this is happening include: an issue with the tmpfs
/run directory or a mount race. We are trying to reproduce and collect
some data.
We are using autofs 5.1.2.

Thanks,
Doron
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
