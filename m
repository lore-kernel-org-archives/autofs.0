From: Ning Yu <ning.yu@canonical.com>
Subject: Mount point not auto unmounted after system date/time change
Date: Wed, 16 Sep 2015 16:29:00 +0800
Message-ID: <CAA1QoHSyMHh9LoPwAM_Nto0iTVbvaVAFH2s-gCSrpYUX1zuPuQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs <autofs@vger.kernel.org>

Hi,

A auto mounted directory won't be automatically unmounted after a
system date/time change, for example we can reproduce the issue with
below steps in 100% failrate:

$ cat /etc/auto.master
/mnt /etc/auto.misc

$ cat /etc/auto.misc
removable -fstype=auto :/dev/sdb1

### now plugin a usb pendrive

$ cd /mnt/removable
$ sudo date -s "+1 year"
$ sleep 1
$ sudo date -s "-1 year"
$ cd

Now /mnt/removable will not be automatically unmounted, the root cause
is that autofs uses gettimeofday() to identify the timestamp and
calculate the delta for timeouts, however as mentioned in the manpage:

```
NOTES
       The time returned by gettimeofday() is affected by discontinuous jumps
       in the system time (e.g., if the system administrator manually changes
       the system time).  If you need a monotonically increasing  clock,  see
       clock_gettime(2).
```

So in the above reproducer autofs will wait for a one-year-long
timeout to unmount /mnt/removable.

BR
Ning
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
