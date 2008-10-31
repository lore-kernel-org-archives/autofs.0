From: Ian Kent <raven@themaw.net>
Subject: Re: a couple of bugs in autofs
Date: Fri, 31 Oct 2008 15:29:54 +0900
Message-ID: <1225434594.2946.53.camel@zeus.themaw.net>
References: <510ca9b40810302235v6ab05c8bk117d4991bb70f198@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40810302235v6ab05c8bk117d4991bb70f198@mail.gmail.com>
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
To: Paul Wankadia <junyer@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 2008-10-31 at 16:35 +1100, Paul Wankadia wrote:
> Hi, Ian.
> 
> I've just started to experiment with autofs and I've already
> encountered two strange bugs. (FYI, I'm pulling from the Git
> repository on kernel.org.)
> 
> ----------------------------------------
> 
> ...
> make[1]: Entering directory `/home/junyer/autofs/man'
> install -d -m 755 /man/man5
> install -c *.5 -m 644 /man/man5
> install -d -m 755 /man/man8
> install -c *.8 -m 644 /man/man8
> make[1]: Leaving directory `/home/junyer/autofs/man'
> ...
> 
> man/Makefile:
> 
>     17  install: all
>     18          install -d -m 755 $(INSTALLROOT)$(mandir)/man5
>     19          install -c *.5 -m 644 $(INSTALLROOT)$(mandir)/man5
>     20          install -d -m 755 $(INSTALLROOT)$(mandir)/man8
>     21          install -c *.8 -m 644 $(INSTALLROOT)$(mandir)/man8
> 
> INSTALLROOT and mandir are empty?
> 
> Makefile.conf:
> 
>     83  # Where to install man pages
>     84  mandir = ${datarootdir}/man
> ...
>     89  # This is here just to keep config.status quiet
>     90  UNUSED_datarootdir = ${prefix}/share
> 
> datarootdir is not set?

Yeah, I've obviously broken that at some point.
I've uploaded a patch to kernel.org just now that should fix that.
autofs-5.0.3-fix-datarootdir-define.patch

> 
> ----------------------------------------
> 
> Starting automounter version 5.0.3, master map /home/junyer/autofs/auto.master
> using kernel protocol version 5.00
> lookup_nss_read_master: reading master file /home/junyer/autofs/auto.master
> parse_init: parse(sun): init gathered global options: (null)
> lookup_read_master: lookup(file): read entry /home
> --(end of buffer or a NUL)
> --accepting rule at line 139 ("/")
> --accepting rule at line 187 ("/")
> --accepting rule at line 187 ("h")
> --accepting rule at line 187 ("o")
> --accepting rule at line 187 ("m")
> --accepting rule at line 187 ("e")
> --accepting rule at line 165 (" ")
> --accepting rule at line 289 ("/")
> --accepting rule at line 289 ("e")
> --accepting rule at line 289 ("t")
> --accepting rule at line 246 ("c")
> --accepting rule at line 314 ("c")
> --accepting default rule ("/")
> /
> --(end of buffer or a NUL)
> --accepting rule at line 314 ("auto.home")
> syntax error while parsing map.
> syntax error in map near [ bogus option ]
> no mounts in table
> 
> auto.master:
> 
>      1  /home   /etc/auto.home
> 
> Why would it treat 'c' differently?
> 
> lib/master_tok.l:
> 
>     98  DNSERVSTR1      ([[:alpha:]][[:alnum:]\-.]*(:[0-9]+)?:)
>     99  DNSERVSTR2      (\/\/[[:alpha:]][[:alnum:]\-.]*(:[0-9]+)?\/)
>    100  DNSERVSTR3      (([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}(:[0-9]+)?:)
>    101  DNSERVSTR4
> (\/\/([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}(:[0-9]+)?\/)
>    102  DNSERVERSTR     {DNSERVSTR1}|{DNSERVSTR2}|{DNSERVSTR3}|{DNSERVSTR4}
>    103
>    104  AT_CN           ([cC][[nN])
>    105  AT_NMN          ([nN][iI][sS][Mm][aA][pP][Nn][aA][mM][eE])
>    106  AT_AMN
> ([aA][uU][tT][oO][mM][oO][uU][nN][tT][Mm][aA][pP][Nn][aA][mM][eE])
>    107  AT_OU           ([oO][[uU])
>    108  AT_DC           ([dD][[cC])
>    109  AT_O            ([oO])
>    110  AT_C            ([cC])
>    111  DNATTRSTR       {AT_CN}|{AT_NMN}|{AT_AMN}|{AT_OU}|{AT_DC}|{AT_O}|{AT_C}
> ...
>    246          {DNSERVERSTR}{DNATTRSTR} {
>    247                  BEGIN(DNSTR);
>    248                  yyless(0);
>    249          }
> 
> I have to work around this by escaping 'c' and 'o' with backslashes?
