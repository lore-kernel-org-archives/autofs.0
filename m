From: raven@themaw.net
Subject: Re: Is autofs4 8-bit compatible?
Date: Fri, 25 Feb 2005 21:23:25 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502252118490.1921@donald.themaw.net>
References: <421E3F05.00006A.08775@mfront7.yandex.ru>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1629620785-131795599-1109337805=:1921"
In-Reply-To: <421E3F05.00006A.08775@mfront7.yandex.ru>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: atlantos41 <atlantos41@yandex.ru>
Cc: autofs@linux.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1629620785-131795599-1109337805=:1921
Content-Type: TEXT/PLAIN; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Feb 2005, atlantos41 wrote:

In short no.

> Hi.
> I start automount with command:
> automount --timeout=3D60 /smb file /etc/auto.smb
>
> where /etc/auto.smb is
> test_data<cyrchar>est    -fstype=3Dsmbfs    ://test/data<cyrchar>est
>
> where <cyrchar> is one cyrillic char, for example "=D4", i. e.
> ~ echo -n <cyrchar> | hexdump
> 0000000 00d4
> 0000001
>
> When I try to change directory to /smb/test_data<cyrchar>est, then autofs
> fails with messages in syslog:
> automount[13111]: failed to mount /smb/test_data
>
> But if I change key in /etc/auto.smb to 7-bit, for example
> "test_data<cyrchar>est" to "test_datatest":
> test_datatest    -fstype=3Dsmbfs    ://test/data<cyrchar>est
>
> and then restart automount, autofs works as it should be.
>
> This problem appears to be in autofs 4.1.3 and autofs 4.1.4_beta1, but no=
t in
> autofs 3.1.7.

I'll check but I think v3 didn't actually do specific character=20
comparisons. Along the way this has made its way into v4.

Perhaps it's not a big deal to change.
I'm not sure yet.

Ian

--1629620785-131795599-1109337805=:1921
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--1629620785-131795599-1109337805=:1921--

