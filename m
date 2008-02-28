From: Fabio Olive Leite <fleite@redhat.com>
Subject: Re: Mount very when reboot
Date: Thu, 28 Feb 2008 09:57:06 -0300
Message-ID: <20080228125706.GB3915@sleipnir.redhat.com>
References: <3a98c5000802080122q56d81c92x67806c7d15aeb108@mail.gmail.com>
	<1202717516.24318.8.camel@raven.themaw.net>
	<3a98c5000802110737y52bce2f0s2e0d3a07b9a1cf1e@mail.gmail.com>
	<1202797905.3233.57.camel@raven.themaw.net>
	<3a98c5000802190105v3ccb2c4h6153f334a1610004@mail.gmail.com>
	<1203413746.16791.12.camel@raven.themaw.net>
	<3a98c5000802260008l28a2ccb1qbc49953bd03bcdff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a98c5000802260008l28a2ccb1qbc49953bd03bcdff@mail.gmail.com>
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
To: autofs@linux.kernel.org

On Tue, Feb 26, 2008 at 09:08:04AM +0100, Vincent LEFORT wrote:
> =

> In the shower this morning, I thought : "Hey you put a link
> S22autofs to start autofs automatically but you havn't put a link to
> shutdown them when stop"...

Good ideas frequently come in the shower... :)

> So i put au link : K11autos juste before nfs (K12nfs) and now when i
> reboot all its ok... I can connect directly to the server...

Does SuSE not have the chkconfig command? See:

$ whatis chkconfig
chkconfig  (8)  - updates and queries runlevel information for system servi=
ces
chkconfig (rpm) - A system tool for maintaining the /etc/rc*.d hierarchy.

$ sudo chkconfig --add autofs
$ chkconfig --list autofs
autofs          0:off   1:off   2:off   3:on    4:on    5:on    6:off

$ ls -l /etc/rc*.d/*autofs
lrwxrwxrwx 1 root root 16 Feb 28 09:51 /etc/rc0.d/K72autofs -> ../init.d/au=
tofs
lrwxrwxrwx 1 root root 16 Feb 28 09:51 /etc/rc1.d/K72autofs -> ../init.d/au=
tofs
lrwxrwxrwx 1 root root 16 Feb 28 09:51 /etc/rc2.d/K72autofs -> ../init.d/au=
tofs
lrwxrwxrwx 1 root root 16 Feb 28 09:51 /etc/rc3.d/S28autofs -> ../init.d/au=
tofs
lrwxrwxrwx 1 root root 16 Feb 28 09:51 /etc/rc4.d/S28autofs -> ../init.d/au=
tofs
lrwxrwxrwx 1 root root 16 Feb 28 09:51 /etc/rc5.d/S28autofs -> ../init.d/au=
tofs
lrwxrwxrwx 1 root root 16 Feb 28 09:51 /etc/rc6.d/K72autofs -> ../init.d/au=
tofs

Cheers!
F=E1bio Oliv=E9
-- =

ex sed lex awk yacc, e pluribus unix, amem
